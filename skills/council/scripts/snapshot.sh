#!/usr/bin/env bash
# Usage: snapshot.sh export|verify <repo> <pin> <dir>
#   export  writes the pinned commit's files into an empty <dir> straight from git objects,
#           with no checkout, filters, replacement objects or hooks.
#   verify  checks that <dir> still holds exactly those files: same paths, bytes, modes
#           and symlink targets, and nothing else. Prints "clean" and exits 0, or exits non-zero.
set -euo pipefail
export LC_ALL=C GIT_NO_LAZY_FETCH=1 GIT_GRAFT_FILE=/dev/null
action=$1
repo=$2
pin=$3
dir=$4
case $dir in /*) ;; *) dir=$PWD/$dir ;; esac
fail() { printf 'snapshot: %s\n' "$@" >&2; exit 1; }
g() { git --no-replace-objects -c core.hooksPath=/dev/null -c core.fsmonitor=false -c advice.graftFileDeprecated=false -C "$repo" "$@"; }
is_empty_dir() { [ -d "$1" ] && [ ! -L "$1" ] && [ -z "$(find "$1" -mindepth 1 -maxdepth 1)" ]; }
is_executable() { [ -n "$(find "$1" -prune -perm -u+x)" ]; }
# Sets $target to a symlink blob's exact bytes. Refuses targets the shell cannot hold (NUL).
target=
read_target() {
  target=$(g cat-file blob "$1"; echo x); target=${target%x}
  [ "$(printf '%s' "$target" | g hash-object --stdin)" = "$1" ] || fail "symlink target cannot be represented exactly: $2"
}
# Matches a symlink target exactly. find -lname compares the raw bytes; readlink output is
# not exact on every platform. The target is escaped so glob characters match literally.
escaped=
link_is() {
  escaped=${2//\\/\\\\}; escaped=${escaped//\*/\\*}; escaped=${escaped//\?/\\?}; escaped=${escaped//\[/\\[}
  [ -n "$(find "$1" -prune -lname "$escaped")" ]
}

case $action in export|verify) ;; *) fail "action must be export or verify" ;; esac
# A partial clone would fetch missing objects on demand, running transport helpers.
[ -z "$(g config --get-regexp '^(extensions\.partialclone|remote\..*\.promisor)$' || true)" ] || fail "partial clones are not supported"
resolved=$(g rev-parse --verify --quiet --end-of-options "$pin^{commit}") || fail "pin is not a commit"
[ "$resolved" = "$pin" ] || fail "pin must be the full commit SHA ($resolved)"
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT
# git refuses paths such as .git, .GIT and ../ when it reads a tree into an index.
GIT_INDEX_FILE="$work/index" g read-tree "$pin" || fail "tree has paths git would refuse to check out"
g ls-tree -r -z --full-tree "$pin" >"$work/entries"

# Creates the parent directories of a path inside <dir>, refusing symlinks and collisions.
prepare() {
  local rest=$1 cur=$dir comp
  while :; do
    case $rest in
      */*) comp=${rest%%/*}; rest=${rest#*/} ;;
      *) break ;;
    esac
    cur=$cur/$comp
    [ ! -L "$cur" ] || fail "path goes through a symlink: $1"
    if [ -e "$cur" ]; then [ -d "$cur" ] || fail "path goes through a file: $1"
    else mkdir "$cur"; fi
  done
  cur=$cur/$rest
  [ ! -e "$cur" ] && [ ! -L "$cur" ] || fail "path collides with another entry: $1"
}

if [ "$action" = export ]; then
  is_empty_dir "$dir" || fail "export needs an existing empty directory"
  while IFS= read -r -d '' entry; do
    meta=${entry%%$'\t'*}
    path=${entry#*$'\t'}
    mode=${meta%% *}
    sha=${meta##* }
    prepare "$path"
    case $mode in
      100644) g cat-file blob "$sha" >"$dir/$path"; chmod 644 "$dir/$path" ;;
      100755) g cat-file blob "$sha" >"$dir/$path"; chmod 755 "$dir/$path" ;;
      120000) read_target "$sha" "$path"; ln -s -- "$target" "$dir/$path" ;;
      160000) mkdir "$dir/$path" ;;
      *) fail "unsupported mode $mode: $path" ;;
    esac
  done <"$work/entries"
fi

[ -d "$dir" ] && [ ! -L "$dir" ] || fail "no such directory: $dir"
: >"$work/expected"
while IFS= read -r -d '' entry; do
  meta=${entry%%$'\t'*}
  path=${entry#*$'\t'}
  mode=${meta%% *}
  sha=${meta##* }
  p="$dir/$path"
  case $mode in
    100644|100755)
      [ -f "$p" ] && [ ! -L "$p" ] || fail "not a regular file: $path"
      if [ "$mode" = 100755 ]; then is_executable "$p" || fail "lost its executable bit: $path"
      else ! is_executable "$p" || fail "gained an executable bit: $path"; fi
      [ "$(g hash-object --no-filters --stdin <"$p")" = "$sha" ] || fail "content changed: $path" ;;
    120000)
      [ -L "$p" ] || fail "not a symlink: $path"
      read_target "$sha" "$path"
      link_is "$p" "$target" || fail "symlink target changed: $path" ;;
    160000)
      is_empty_dir "$p" || fail "submodule directory is missing or not empty: $path" ;;
  esac
  printf '%s\0' "$path" >>"$work/expected"
done <"$work/entries"
(cd "$dir" && find . -mindepth 1 \( ! -type d -o -type d -empty \) -print0) | while IFS= read -r -d '' found; do
  printf '%s\0' "${found#./}"
done >"$work/found"
sort -z "$work/expected" >"$work/expected.sorted"
sort -z "$work/found" >"$work/found.sorted"
cmp -s "$work/expected.sorted" "$work/found.sorted" || fail "files were added or removed"
echo clean
