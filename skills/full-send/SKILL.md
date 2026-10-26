---
name: full-send
description: Use when the user explicitly asks for full send. Full-stop also reads this workflow with its no-merge overrides.
metadata:
  inspired-by: https://github.com/t3dotgg/tstack/blob/7de017b3fc9d50c03cf3ecb98fb71e0ca65a78bd/skills/full-send/SKILL.md
---

# Full send

An explicit full-send request asks you to finish the goal through a merged PR. It authorizes commits, pushes, a lease-protected rebase of this task's branch and merging after the gate below passes. Full-stop uses the same work but never grants merge authority. Do not infer either request from ordinary coding work.

## Finish, prove, review, publish

1. Read the task, later corrections, repository instructions and current status. Preserve unrelated work. Use a task branch, never implement directly on the default branch. Make the smallest change that satisfies the goal.
2. Observe proof yourself. Reproduce a reported bug before fixing it and repeat the reproduction afterward. Run relevant repository checks. For runtime or UI behavior, exercise the actual app with its supported driver. Follow host and project rules for testing; this skill does not bypass them. Green mocks alone do not prove the user experience.
3. Use [sol-loop](../sol-loop/SKILL.md). Do not publish an unresolved or blocked review as approved. Council and multi-model panels are optional when explicitly requested or required by the repository; do not add them automatically.
4. Fetch the actual base branch and reconcile changes before publishing. Record the remote task-branch head before a rebase and tie any force-with-lease push to that head. Recheck proof and review when behavior changes. Never overwrite another actor's update or force-push another branch.
5. Find an existing PR before creating one. Follow the repository's conventions. Lead its short description with the user's problem, the change and observed proof. Use the host's PR creation tool when available, otherwise `gh` with a body file. Open it ready for review, and link it to the T3 thread immediately. Include actual model and harness names when available, without guessing.

## Review and CI

Handle existing checks and review findings before waiting. Verify each finding against the code. Fix real in-scope bugs, prove fixes and refresh review for behavior changes. Do not grow the PR to satisfy speculative suggestions. Give evidence when declining feedback; post only PR replies needed for the requested work.

Use the host's supported PR notifications. In T3, the owning coordinator calls `watch_pull_request` while checks or reviews are pending and ends its turn as instructed. A delegated reviewer never watches. On each wake, read the current head, base, checks and reviews again. Do not write another watcher or poll. If the host has no supported way to continue, report that blocker rather than claim autonomous completion.

## Merge gate

All of these must hold for the latest change:

- Observed proof and review cover its current behavior.
- Required checks pass, required review bots have finished, and findings are fixed or dismissed with evidence.
- No human changes-requested review or required approval remains outstanding.
- The branch is current with its base and GitHub reports it mergeable.

Use the repository's allowed merge method and branch protections. Never bypass protection or use an administrative override. A queued merge request is not a completed merge; verify the actual merged state before reporting success.

## Blockers and finish

Decide routine implementation details yourself. If proof, the merge gate, missing access or an unresolved product decision prevents progress, ask through the host's question tool when available. Include the PR, blocker and recommendation. Stop rather than treating an unanswered question as permission.

Production changes, data deletion, closing unrelated PRs and work outside the requested goal need their own authorization. Full send grants no such authority.

Before a handoff or question, stop this run's PR watches. Report the PR, actual merged state and merge commit when applicable, proof, reviewer outcome, remaining risks and material decisions. If blocked, leave the PR open and state that clearly.
