# Running the council outside T3

Run both seats through their CLIs in the background, each with a timeout of at least 30 minutes, and wait for both. Each seat reads its own brief from `<work>/briefs` on stdin and writes to `<work>/out`. Never pass a brief as a shell argument. Neither seat may load the subject's instruction files: both start in `<work>/in` and read the snapshot by absolute path. Codex loads AGENTS.md and project skills from its working directory, and `project_doc_max_bytes=0` is a second guard. Claude starts there, because it loads CLAUDE.md from its working directory but not from added directories. Neither directory is a git repository, which is why Codex needs `--skip-git-repo-check`. `<work>` must be the resolved path (`pwd -P`), because the deny rules below match real paths.

```sh
codex exec -s read-only -m gpt-6.1-sol -c model_reasoning_effort=xhigh -c project_doc_max_bytes=0 \
  --ignore-user-config --ignore-rules --ephemeral --skip-git-repo-check \
  -C <work>/in -o <work>/out/sol-r<round>.md - < <work>/briefs/sol-r<round>.md

cd <work>/in && claude -p --model claude-opus-5-5 --effort xhigh \
  --tools "Read,Grep,Glob" --add-dir <work>/snapshot \
  --strict-mcp-config --setting-sources user \
  --settings '{"disableAllHooks":true,"permissions":{"deny":["Read(/<work>/briefs/**)","Read(/<work>/out/**)"]}}' \
  --permission-mode dontAsk --no-session-persistence \
  < <work>/briefs/opus-r<round>.md > <work>/out/opus-r<round>.md
```

In the deny rules, `/<work>` starts with `//` because `<work>` is absolute. In Claude Code permission rules, `//` marks an absolute path.

What each seat is limited to:

- **Sol** runs shell commands inside Codex's read-only sandbox. The sandbox blocks writes and network access but allows reads anywhere on disk, including the other seat's brief and output. For Sol, independence is an instruction only. `--ignore-user-config` drops MCP servers, and `--ignore-rules` drops saved "run outside the sandbox" approvals.
- **Opus** has only Read, Grep and Glob. It has no shell, no MCP servers, no project settings and no user hooks. Its reads cover `<work>/snapshot` and `<work>/in`, plus anything the user's own settings allow. The deny rules still block the briefs and the outputs. Hooks enforced by managed policy can still run. If the machine has any, say so in the report.

Neither seat can fetch anything, so put the diff and every other input in `<work>/in` before dispatch. Count a non-zero exit or an empty output as malformed.
