---
name: review-loop
description: Use when the user asks for a review loop or sol loop to review and fix a change with one independent reviewer, for at most three rounds. This is an optional everyday review workflow. Read-only review requests stay read-only; unanimous exact-commit action gates use council.
metadata:
  inspired-by: https://github.com/t3dotgg/tstack/blob/7de017b3fc9d50c03cf3ecb98fb71e0ca65a78bd/skills/sol-loop/SKILL.md
---

# Review loop

Get one review of the current change, fix confirmed problems within the caller's scope, and stop with an honest verdict. This skill does not start a council or a delivery workflow.

## Frame

Read the task, later corrections, applicable instructions and repository status. Identify the base, intended paths, observable goal and exclusions. Preserve unrelated work. A read-only run ends after one completed review with APPROVED or UNRESOLVED; do not spend more rounds on unchanged inputs. An ambiguous scope is a blocker, not permission to absorb other changes.

Record HEAD and the complete scoped diff, including untracked file contents, before each review. Freeze these inputs while the reviewer runs. If any reviewed input changes, that approval is stale. Read [references/dispatch.md](references/dispatch.md) when starting a reviewer.

Use the caller's named reviewer. Otherwise resolve an available Sol model through the active harness. Record the actual provider, model and effort when exposed. An unavailable reviewer is a blocker. Do not silently substitute or count an error as approval.

## Review and fix

Use one fresh independent reviewer session per round. Send the goal, exclusions, base, recorded inputs, relevant surrounding code and actual check results. The reviewer reads only, starts no subagents, and returns:

- `APPROVE` or `CHANGES`, with the reviewed revision and input scope.
- Findings with stable IDs, location, failure condition, impact and smallest proposed fix.
- Outstanding uncertainty and checks it could not perform.

Run at most three rounds total. The first reviews the full scoped change. Later rounds receive the complete current diff, the reviewer's prior findings, the author's proposed dispositions and the changes since the last review. Label dispositions as the author's claims. The reviewer independently verifies them against current inputs and focuses on open findings and changed behavior.

Verify each finding yourself. Fix confirmed bugs only within existing authorization. Prefer the smallest correct change and a focused regression check when useful. Refute mistaken findings with evidence. Record out-of-scope work without implementing it. Judge severity by impact and evidence; a rare security or data-loss path can still block. Cosmetic suggestions do not force another round.

Keep a ledger of finding ID, evidence, disposition and open objections. Re-run affected checks after a fix. A behavior change needs another review even if the previous verdict was APPROVE. If the budget ends before current inputs have approval and all blocking findings are resolved, stop as `UNRESOLVED`. A missing or failed reviewer is `BLOCKED`. Changed inputs require a fresh review while budget remains; with no budget left, report `UNRESOLVED`. Neither state is approval.

## Finish

Report `APPROVED`, `UNRESOLVED` or `BLOCKED`, the reviewed revision and scope, actual reviewer, rounds used, verification, declined findings with reasons and remaining risks. Distinguish reviewer approval from your own confidence. When blocked on a user decision, use the active harness's question tool when available.

Approval grants no authority to commit, push, post, merge or deploy. Use only authority already supplied by the caller. If an authorized PR update includes a review footer, state the actual verdict and round count, including unresolved findings. Never describe budget exhaustion as approval. Do not edit a PR or post a comment just to add this footer.
