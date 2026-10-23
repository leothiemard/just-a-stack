# Verifier structure

Replace the guidance below with observed facts. Generated executable instructions contain no guessed commands or selectors. Missing access belongs under Blockers and makes the affected journey unverified.

## Frontmatter

Use the user's explicitly requested name, or default to `verify-<project>-<surface>`, matching its folder. Write a description naming repository, surface and verification triggers. Mention exclusions that prevent running against a different app.

## Target

Identify the repository from the active checkout, apply its instructions and use its current revision. Record the surface, target URL or command, physical dataset and perspective where applicable. Reference environment variable names and setup documentation, never secret values.

## Launch

Show exact commands, working directory, readiness predicate and reuse/ownership rules. Identify potentially mutating startup/build steps. Include teardown for newly owned instances.

## Doctor

Check process/port ownership, actual build identity, auth and data alignment read-only. If a required check is unavailable, state it and avoid a false verified-target claim.

## Drive

Read `features/README.md`, select the journey relevant to the changed behavior and follow its real entry point. Use semantic selectors, stable CLI arguments or documented endpoints. Require the journey's preconditions before proceeding.

## Evidence

Record revision, observation time, target, viewport/state, actions, expected and actual result, check output and saved artifact paths. Use the user/caller's destination or project convention, otherwise a named scratch directory. Distinguish behavioral smoke tests, screenshots and measured visual-parity checks.

## Cleanup

Track owned process IDs and exact fixture identifiers. Cleanup only those resources with the needed authorization. Preserve original data, evidence and existing user instances.

## Verification status

List each exercised journey and result; label remaining journeys unverified. Include failed commands and blockers.

## Feature map

`features/README.md` indexes the observed journeys and their coverage. Each journey file includes:

- **Preconditions:** auth/data/state and any authorized fixture setup.
- **How to reach it:** actual route, story, menu, CLI command or endpoint.
- **Drive:** exact observed actions and selectors.
- **Proof:** expected visible result and relevant side effect.
- **Gotchas:** observed failure modes and constraints.

Keep the map small; expand it when later work actually exercises another entry point.
