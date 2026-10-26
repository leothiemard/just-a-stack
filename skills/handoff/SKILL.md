---
name: handoff
description: Use when asked to write a handoff, fix prompt or transfer brief for another agent, session or machine. Return a concise paste-ready brief. Resuming an existing handoff belongs to the active pickup workflow; writing one does not start another thread.
metadata:
  inspired-by: https://github.com/mattpocock/skills/blob/49dd158d1076134a641b33efb035946536778336/skills/productivity/handoff/SKILL.md
---

# Handoff

Write for an agent that has no conversation history. Preserve the original task and every material later correction without copying whole plans, diffs or transcripts.

Read the specified conversation and relevant plans, notes and evidence identified by the user, calling workflow or project conventions. Use available conversation-history tools to recover relevant history missing from the current context; in T3, use thread read/search and recover truncated items where necessary. Distinguish current user requirements from superseded assistant proposals and automatic watch messages.

## Brief structure

Include only fields relevant to the next task.

1. **Goal and scope:** task or issue/spec reference when available, desired outcome, acceptance criteria and explicit exclusions. Preserve exact branch names, commands and requested titles.
2. **Workspace:** repository/project identity, source environment and worktree path, branch, base/head revision, PR URL and remote versus local state when applicable. Label machine-local paths with their source environment. For another machine, include portable repository/artifact references and require the receiving agent to verify its checkout and available evidence. Mark unverified values rather than guessing.
3. **Read first:** applicable instructions, current plan and evidence paths/URLs. Link artifacts; summarize only what the next agent cannot recover from them.
4. **Current state:** completed work, verification actually performed, failures, relevant uncommitted changes and unrelated user work to preserve.
5. **Next actions:** bounded numbered steps, unresolved decisions and smallest meaningful checks. For fixes include severity, exact location, failure condition and expected behavior.
6. **Constraints:** explicit authorization boundaries, known environment dependencies, generated outputs and relevant skills. Include only constraints material to this handoff.

Default to a code block the user can paste. When asked to save a handoff, use the destination specified by the user or calling workflow; otherwise follow the project's documented handoff convention or use a task-specific scratch directory. Exclude credentials, secret contents and unnecessary personal data. Reference shared environment paths without copying or modifying `.env`.

## Dispatch only when requested

A prompt request returns a prompt, not a newly started agent. When dispatch is requested, use the current harness's supported tools. In T3:

- For explicitly delegated child work use `delegate_task`; discover provider/model IDs and honor the requested model. Include the consolidated brief. Independent review rounds use fresh tasks with prior findings and responses.
- A separate/new/top-level thread requires an explicit user request. Use `t3_thread_launch` with `workspaceStrategy`; choose existing worktree, root or new worktree before startup. Uncommitted changes do not transfer to a new worktree.
- If the exact new branch is required but unspecified, ask before creating it. Never substitute shell worktree creation for T3 thread binding.

Conclude with the brief or the dispatched task/thread link and actual status. Do not infer completion from successful dispatch.
