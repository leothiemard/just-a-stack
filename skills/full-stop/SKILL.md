---
name: full-stop
description: Use when the user explicitly asks for full stop. Finish at a reviewed PR for the user to merge; never merge it.
metadata:
  inspired-by: https://github.com/t3dotgg/tstack/blob/7de017b3fc9d50c03cf3ecb98fb71e0ca65a78bd/skills/full-stop/SKILL.md
---

# Full stop

Read [full-send](../full-send/SKILL.md) and follow its implementation, proof, Sol review, PR and CI workflow. The explicit full-stop request authorizes that work, including commits, pushes and lease-protected rebases of this task's branch. Replace its merge step with a handoff. Never merge, enable auto-merge, enter a merge queue, push to the default branch or delegate those actions.

Before the first mutation, disable existing auto-merge and remove queue membership for requested PRs. If no PR exists yet, confirm that and apply these checks once it exists. Verify both states before every push, on each wake and at handoff. Report settings changed and any observed queue rebuild. Leave unrelated PR settings alone. If disarming or verification fails, stop before further mutation and ask. Unknown state is not off.

If another actor rearms merging after verified disarming, stop mutations and ask rather than silently reversing their decision. Carry the no-merge constraint and observed settings in any branch-owner handoff; require that owner to verify before its push. Do not claim control over external actors or merges between observations.

Use full-send's merge gate as the readiness check. Read the live head, base, checks, reviews and mergeability again. Confirm the PR is open, not a draft, with auto-merge off and no queue entry. If someone else merged it, report that fact.

Report READY, WAITING FOR REQUIRED APPROVAL or BLOCKED with the PR, final head, observed proof, actual reviewer outcome and remaining risks. Say whether the PR remains open and unmerged. Stop this run's watches before handing off or asking the user.
