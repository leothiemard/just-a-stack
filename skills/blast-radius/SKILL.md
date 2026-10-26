---
name: blast-radius
description: Check persisted-data and contract compatibility for schema or GROQ renames, migrations, serialized APIs and deployment order. Use for contract blast-radius requests. General downstream-impact reviews use pstack:blast-radius when available. Skip cosmetic and isolated changes.
metadata:
  inspired-by: https://github.com/cursor/plugins/blob/1dcc2bacde73ddd284803b7af28164d0436198fc/pstack/skills/blast-radius/SKILL.md
---

# Blast radius

Find the one or two facts a change's safety depends on, then prove them using the real implementation. A caller list alone misses persisted documents, serialized contracts and deployment order.

## Establish the change

Read applicable project instructions, the supplied requirements and relevant linked documents/comments. Use historical notes identified by the user, calling workflow or project conventions; treat them as context, not current requirements. Without an external issue or notes directory, assess the stated goal against the actual code and contracts.

Pin the checkout, base/head revisions and diff being assessed. For local work include the intended uncommitted changes; distinguish them from the remote PR. Inspect status before running anything. Preserve unrelated edits. For an existing PR, register it with this T3 thread when the linking tool is available.

## Trace the contract

1. State the observable behavior before and after, including changes not obvious in the diff.
2. Identify the critical safety assertion, such as “every stored legacy selector still resolves during rollout.”
3. Trace beyond symbol references: field names in GROQ strings, generated types, drafts/releases, references, migrations, API payloads, other apps, indexing and deployment timing. Inspect installed library versions and patches where behavior depends on them.
4. Separate confirmed failures from plausible but unproven risks and checked-and-cleared cases. Cite real paths, lines or source documents. Bound negative-search claims by the searched scope.
5. Prove the critical assertion with the cheapest meaningful check: an existing test, a scratch script importing the real library, read-only data comparison, or the running app. Reuse existing tooling before adding anything.

For Sanity, establish the physical dataset behind any alias and the actual perspective. Compare raw, draft or release behavior only when relevant. Record code revision and observation time; generated types and successful builds do not prove existing content compatibility.

Keep one-off scripts and evidence in the location specified by the user or calling workflow, following project conventions when present; otherwise use a task-specific scratch directory. Dataset writes, schema deployment, commits, pushes and PR creation require explicit user authorization. Check scripts for side effects before invoking them, including commands called dry-run or build.

Work inline unless delegation is requested or an applicable instruction requires it. Include the original brief, later constraints and prior findings in delegated work. In T3, discover available provider/model IDs and start each independent review round with a fresh delegated task.

## Report

- **Change:** one paragraph, revision and scope.
- **Safety fact:** assertion, proof command/artifact and observed result; say unproven when evidence is missing.
- **Confirmed risks:** failure path, impact, evidence and smallest verification/fix.
- **Cleared:** checked cases and why they are safe.
- **Remaining:** cheapest outstanding checks and rollout dependencies.

Use evidence levels: source inspected, failure path traced, real code executed, running surface reproduced. Report failed or unavailable checks accurately. Do not widen the implementation to resolve unrelated risks.
