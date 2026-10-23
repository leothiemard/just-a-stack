---
name: retro
description: Conduct a coding-session or PR retrospective and propose small improvements to personal instructions, verification or agent handoffs. Use only when the user asks for a retro, postmortem or workflow lessons; do not rewrite configuration or team code as part of the retrospective.
metadata:
  inspired-by: https://github.com/mattpocock/skills/blob/49dd158d1076134a641b33efb035946536778336/skills/engineering/retro/SKILL.md
---

# Retro

Explain which observable workflow failure caused repeated work and propose the smallest prevention. A difficult session is not proof that the codebase needs a new framework or rule.

Read the requested session/PR history and relevant notes supplied by the user or project conventions; default to the current session when none is named. Use available conversation-history and repository tools; in T3, use thread read/search, and use `gh` for GitHub evidence when available. Distinguish user steering, agent actions, automatic monitor updates and superseded findings. Register a PR with the current thread when actively auditing it and the harness provides a linking tool.

Inspect existing personal instructions, applicable repo standards, scripts and CI before recommending new checks. Look for:

- Scope growth that the ticket or existing pattern should have prevented.
- Review-to-fix handoff losing requirements, findings or workspace state.
- Repeated navigation or unnecessarily large tool output.
- Verification that checked a proxy rather than real data or user behavior.
- Missing or unwired existing checks, rather than automatically adding new suites.
- Conflicting instructions, stale evidence and redundant skill triggers.

For each candidate state **observed incident → cause → proposed change → expected benefit → cost**, with a transcript/file reference. Separate observed causes from inference. Prefer repairing an existing instruction or check, then a small deterministic check for a mechanical failure. Reserve prose rules for judgment calls.

Recommend up to three improvements ordered by likely value. Use the user's destination or project convention for proposed notes; otherwise suggest an appropriate personal skill or instruction file. When proposing changes to agent-facing instructions, read `references/writing-for-agents.md`. Team-wide lint, CI and repo policy changes require a separate explicit request. Keep credential contents and unnecessary personal data out of examples.

Return recommendations, not edits, commits, PR comments or scheduled automation. If the user subsequently asks to implement one, inspect the current target before changing it and verify the actual improvement.
