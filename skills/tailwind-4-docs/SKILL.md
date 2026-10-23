---
name: tailwind-4-docs
description: Tailwind CSS v4 documentation and engineering guidance for utilities, variants, configuration, migrations and implementation reviews. Use official docs or the local snapshot for version-sensitive behavior.
metadata:
  snapshot-requires: Git, Python 3, internet access and acceptance of the upstream docs license.
---

# Tailwind 4 Docs

Use official Tailwind v4 documentation for the installed version. This skill includes an engineering playbook and gotchas; the optional documentation snapshot is generated locally and excluded from Git.

## Find the relevant guidance

Check the project's Tailwind version and requested topic. For implementation, refactoring or review, read `references/engineering-playbook.md`; for migration pitfalls, read `references/gotchas.md`.

When `references/docs/` and `references/docs-index.tsx` exist, use the index to locate only the relevant MDX files. Read `references/docs-source.txt` for the source revision and snapshot date. Confirm potentially changed or version-sensitive guidance against [official documentation](https://tailwindcss.com/docs). If the snapshot is absent or unsuitable, browse the relevant official pages directly. A missing local snapshot does not block the task. If neither is available, distinguish the bundled guidance from unverified current behavior.

In MDX, treat exported titles/descriptions as metadata and JSX callouts as guidance. Common snapshot entries include `upgrade-guide.mdx`, `compatibility.mdx`, `theme.mdx`, `functions-and-directives.mdx`, `adding-custom-styles.mdx`, `hover-focus-and-other-states.mdx`, `responsive-design.mdx`, `preflight.mdx` and `detecting-classes-in-source-files.mdx`.

For a v3 migration, confirm browser support, integration packages, import syntax, utility renames, prefixes, important modifiers and variant/transform changes against the documentation.

## Optional local snapshot

The source repository's documentation has its own [license](https://github.com/tailwindlabs/tailwindcss.com#license). Obtain the user's acceptance before downloading it. From this skill directory, run:

```sh
python3 scripts/sync_tailwind_docs.py --accept-docs-license
```

The script writes `references/docs/`, `references/docs-index.tsx` and `references/docs-source.txt`. Keep them local. Refresh when the task needs newer documentation; there is no mandatory weekly refresh.

An existing clean clone can be read without changing its branch or files:

```sh
python3 scripts/sync_tailwind_docs.py --accept-docs-license --local-repo /path/to/tailwindcss.com --ref main
```

The clone's HEAD must match the requested local ref. Updating that clone is a separate action.
