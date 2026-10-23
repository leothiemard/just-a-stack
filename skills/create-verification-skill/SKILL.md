---
name: create-verification-skill
description: Create or update a reusable verify-app, verify-studio or verify-storybook skill grounded in an actual repository and exercised through its real UI, CLI or service. Use when asked to create a verification/control skill or codify repeated app verification. Ordinary screenshot requests use an existing verifier instead of generating a skill.
metadata:
  inspired-by: https://github.com/cursor/plugins/blob/1dcc2bacde73ddd284803b7af28164d0436198fc/pstack/skills/create-verification-skill/SKILL.md
  visual-parity: https://github.com/cursor/plugins/blob/1dcc2bacde73ddd284803b7af28164d0436198fc/pstack/skills/poteto-mode/playbooks/visual-parity.md
---

# Create verification skill

Generate instructions a fresh agent can execute against the real application. Discover commands and selectors from the repository and running surface, then prove one complete journey. Read `references/verifier-template.md` while authoring the result.

## Interview the repository

Read applicable instructions, historical notes supplied by the user or project conventions, scripts, README, existing test harnesses, routes/stories, environment setup and current dependencies. Find:

- **Surface:** web UI, Studio, Storybook, CLI, service or another user-facing interface; choose the requested surface.
- **Launch:** exact documented command, working directory, readiness check, ports, auth and data preconditions.
- **Drive:** existing Playwright/Cypress, browser, PTY or HTTP harness. Prefer available T3 preview tools for supported browser interaction; inspect a snapshot before acting and use stable semantic selectors. Respect tab ownership and user-controlled sessions.
- **Observe:** before/action/after evidence, user-visible results and relevant side effects.
- **Isolate:** owned process IDs, port ownership, unique fixture IDs and safe concurrent-instance boundaries.

Resolve facts from the code rather than questioning the user. Ask only about missing target, access or consequential policy decisions. Report startup failures accurately; generating a skill is not authorization to repair unrelated code, install dependencies or alter shared `.env` symlinks.

## Generate a focused verifier

Default to `~/.agents/skills/verify-<project>-<surface>/` for a personal skill usable across checkouts, unless the active harness uses another personal skill root. Bind it by repository identity and discover the active checkout rather than hardcoding a stale worktree. Use a project-local skill directory only when requested, following that harness's conventions.

Preserve an explicitly requested skill name such as `verify-storybook`; use the default naming pattern only when no name was given. If launching through a non-mutating alternative that skips a documented deployment hook, record that alternative and leave the original startup path unverified.

Inspect an existing same-name skill before updating it. Write `SKILL.md` with a matching kebab-case name and a precise description, plus `features/README.md` and up to three observed feature journeys. Include:

1. **Target and preconditions:** identity, surface, dataset/perspective if relevant, access and version evidence.
2. **Launch and readiness:** exact commands or existing-instance reuse, observable usable state and owned-instance tracking.
3. **Doctor:** read-only checks for correct build, target, port ownership and auth. Distinguish a login page from a usable app.
4. **Drive:** actual routes/stories/selectors/commands and required fixture setup. Label unavailable prerequisites rather than inventing selectors or seed data.
5. **Evidence:** action and resulting state, observable pass/fail assertions and artifacts kept in the user/caller's destination or project convention; otherwise use a task-specific scratch directory. Capture screenshots with a save-capable tool and use its returned path. Include viewport, route/story, revision and target metadata.
6. **Cleanup:** stop only owned processes and remove only explicitly authorized exact-ID fixtures. Preserve evidence and the user's tabs/processes.

Treat generated feature maps as observed journeys, not proof of whole-application coverage. Use repository tools rather than adding a new harness by default. Commands that build Studio, create fixtures or call a dry-run require side-effect inspection and appropriate authorization.

## Responsive and parity evidence

Discover project breakpoints and choose representative widths/states plus boundary widths for affected behavior. Keep data, fonts, locale, theme and viewport controlled. Use fresh snapshots after interactions.

For a parity task, capture the baseline before the change and compare against the same surface and conditions using the existing image-diff tooling. Preserve the baseline. Report the actual diff and existing configured tolerance; do not raise thresholds, mask changed regions or update snapshots to manufacture a pass. Visual inspection alone is a smoke check, not pixel-equivalence proof. An intentional design change needs its own expected outcome rather than a zero-diff claim.

## Prove and hand over

Execute launch → doctor → one mapped journey → evidence → cleanup. Verify evidence still exists afterward, including after a failed attempt. Fix only the generated instructions/helpers within scope and repeat the affected check when necessary.

If auth, target access or authorization blocks execution, deliver an explicitly **unverified draft** with exact missing prerequisites, not a validated verifier. Record which journey, target and revision were exercised and which remain unverified. Do not create a PR or schedule maintenance unless requested.
