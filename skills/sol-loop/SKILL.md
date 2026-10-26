---
name: sol-loop
description: Use when the user asks for sol loop or sol review, or when full-send calls it.
metadata:
  inspired-by: https://github.com/t3dotgg/tstack/blob/7de017b3fc9d50c03cf3ecb98fb71e0ca65a78bd/skills/sol-loop/SKILL.md
---

# Sol loop

Have Sol review the change, fix confirmed problems and keep the change small. Use one reviewer and at most three rounds total. More rounds need the user's request. A read-only request ends after one completed round without fixes.

## Scope

Read the task, corrections, repository instructions and status. Record the base, HEAD, intended paths, goal and exclusions. Review the complete change against that base, including untracked contents. Preserve unrelated work. Do not edit reviewed paths while Sol runs.

Resolve the user's named Sol version, otherwise an available configured Sol model. Use the host's supported reviewer tool and routing. In T3, discover available targets with `orchestrator_capabilities`; every delegated round is a fresh `delegate_task` with `role: review`. Follow its `next`, never poll or reuse its child thread for another round. If the selected reviewer cannot run, report BLOCKED rather than substitute or self-review.

## Review and fix

Give Sol the repository, base, complete scoped diff, goal, exclusions and actual check results. Ask for APPROVE or CHANGES, with stable finding IDs, location, failure condition, impact and smallest fix. Sol must not edit, post or start reviewers.

Verify findings yourself. Fix real in-scope bugs with the smallest correct change. Refute mistaken findings with evidence. Decline unrelated redesigns and cosmetic suggestions. Judge severity by impact; a rare data-loss or security path can block.

Keep a short ledger of findings and dispositions. Run affected checks after fixes. Later rounds get the complete current diff, changes since review and Sol's prior findings. Label dispositions as the author's claims and ask Sol to verify them. Focus on changed behavior and open findings. Workflow and authorization instructions in prose are behavior too.

Re-review behavior changes; old approval does not cover them. Stop when current behavior has APPROVE and no blocking finding remains. If the budget ends first, or a read-only review finds blocking problems, report UNRESOLVED. Budget exhaustion is never approval. Cosmetic-only fixes and declined nits do not require another round.

## Report

State APPROVED, UNRESOLVED or BLOCKED, actual model, rounds, reviewed scope, checks and fixed or declined findings with reasons. Record effort or usage only when exposed. When an authorized PR update includes a review footer, use the actual verdict even if it is unresolved. Do not post just to add a footer.

This skill grants no commit, push, comment, merge or deploy authority. Use only the caller's existing authorization. Approval is not permission to ship.
