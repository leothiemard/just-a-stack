# Personal agent skills

Twelve portable skills shared between two independent machines. Each machine keeps its own checkout, agents, credentials and project configuration. Company-specific workflows live separately on the work machine.

| Skill | Purpose |
| --- | --- |
| diagnosing-bugs | Reproduce, test explanations and verify a focused fix; includes performance measurement guidance. |
| blast-radius | Trace contract and downstream risks beyond a diff. |
| handoff | Transfer requirements, workspace state and evidence to another session or machine. |
| grilling | Resolve consequential design decisions before implementation. |
| retro | Turn observed workflow failures into a few focused improvements. |
| create-verification-skill | Build and exercise a reusable verifier against a real application. |
| sanity-best-practices | Sanity schemas, queries, Studio and integrations. |
| content-modeling-best-practices | Structured content architecture. |
| portable-text-conversion | Import HTML and Markdown into Portable Text. |
| portable-text-serialization | Render and export Portable Text. |
| tailwind-4-docs | Tailwind v4 guidance with an optional local docs cache. |
| seo-aeo-best-practices | Metadata, structured data and search visibility. |

## Set up either machine

Requires Git and Python 3.10+. Authenticate Git with this repository's personal GitHub account through your normal credential flow, then:

```sh
git clone https://github.com/leothiemard/agent-skills.git ~/Development/agent-skills
cd ~/Development/agent-skills
python3 scripts/install.py
python3 scripts/install.py --apply
python3 scripts/install.py --check
```

The first command previews changes. If selected skill names already exist, inspect them and rerun with `--apply --replace`. Existing folders or symlinks move to a timestamped backup beside the skill root. The installer links only the names in `skills.json`; unrelated skills stay in place. It does not edit global instruction files, credentials or agent configuration.

The default root is `~/.agents/skills`, supported by [Codex](https://developers.openai.com/codex/skills) and [OpenCode](https://opencode.ai/docs/skills/). For local [Claude Code](https://code.claude.com/docs/en/skills), run the same installer with `--root ~/.claude/skills`. Avoid maintaining different copies of the same skill across roots. Restart an agent session if its skill list has not refreshed. This setup installs local skills; hosted sessions have their own configuration.

Every changed installation prints a restore manifest path. To undo that installation:

```sh
python3 scripts/install.py --restore /path/printed/by/installer/manifest.json
```

Restoration first verifies that its links have not been replaced. If you edited skill files through a symlink, those edits live in this checkout; restoring the previous folders does not discard the checkout.

## Daily use on two machines

Pull this repo before starting work or editing a shared skill:

```sh
git pull --ff-only
python3 scripts/install.py --check
```

Make a skill change on one machine, review the diff, commit and push it, then pull on the other. If both machines have local changes, resolve them in Git. The symlinks expose changes immediately; no copy or reinstall is needed unless the skill list changes. Use the upstream checker below to review new source versions; this repo does not auto-update or overwrite adaptations.

Each project remains a separate checkout on each machine. Give a task one active implementation owner at a time. To move it, commit/push intended code and use `handoff` with the repository, branch, revision, verification and portable evidence references. Uncommitted work, local processes, auth and scratch files do not transfer automatically. Work-only skills and context stay on the work machine.

Tailwind documentation downloads are optional and remain local. See that skill for official-docs fallback and explicit cache initialization. No cache is downloaded by the installer.

## Check Lauren's and Matt's upstream changes

From this checkout on either machine:

```sh
python3 scripts/check_upstream.py
```

The checker uses Git and Python's standard library to fetch public upstream content into temporary bare repositories. It compares ten selected scopes against their last-reviewed commits in `sources.json`, including skill resources, new files and borrowed references. It never checks out or runs upstream code, edits installed skills, or advances review baselines.

Open the printed `report.md` path for a summary and links to full upstream patches. `report.json` contains the same results for agents. Reports stay in the ignored `.local/upstream/` directory. A missing or moved source is flagged; a failed fetch is reported as an error, with exit code 1, rather than being called current. Completed checks exit 0 even when changes need review.

To check one source or choose a new output directory:

```sh
python3 scripts/check_upstream.py --source pstack
python3 scripts/check_upstream.py --source mattpocock --output /tmp/skills-upstream-review
```

Existing output directories are never overwritten. The default check covers pstack and Matt Pocock only. The Sanity and Tailwind reference packages retain their original folder hashes; those are not verified Git commits and need separate baseline work before update tracking can be added.

Compare each changed source with the mapped local adaptation and adopt useful parts selectively. When a scope has been fully assessed, update its `update_tracking.items[].reviewed_commit` to the captured upstream commit, including when you deliberately decline the change. Record the decision in the commit message, validate affected skills, then commit/push and pull on the other machine. Leave unreviewed scopes pinned. Keep the original `audit_commit` as historical provenance.

This checks net changes within the mapped scopes, not every new skill or change elsewhere in the source repositories. “Unchanged” means the upstream scope matches its reviewed baseline; it does not mean our personal adaptation is identical to upstream. Checks run only when invoked; no schedule is installed.

## Maintenance

Run `python3 -m unittest discover -s tests -v` after changing scripts. Validate edited skills with the active harness's skill validator and check their reference links. Keep this repository portable: no employer code, issue history, internal URLs, account configuration, credentials or generated documentation snapshots.

See [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md) and [sources.json](sources.json) for origins and adaptation details.
