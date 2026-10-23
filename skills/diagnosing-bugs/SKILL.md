---
name: diagnosing-bugs
description: Diagnose bugs and performance regressions using a reproducible symptom, falsifiable hypotheses and a focused fix. Use for debugging failures, unexpected output, intermittent behavior or unexplained slowness.
metadata:
  adapted-from: https://github.com/mattpocock/skills/blob/5beb35b040e3de97e54fa9e386d7e42d15c295c2/skills/engineering/diagnosing-bugs/SKILL.md
  premise-check: https://github.com/cursor/plugins/blob/8b3326d99fd4b993cb33a24dad8af03175c642c5/pstack/skills/principle-attack-the-premise/SKILL.md
---

# Diagnosing bugs

Establish the user's exact symptom and build the cheapest useful feedback loop. Scale the investigation to the uncertainty: an obvious local defect needs a focused check, while a hard or intermittent bug needs controlled experiments.

## Establish the failure

Read the relevant instructions, code, existing checks and supplied evidence. Identify the actual failing environment, revision, inputs and expected result. Distinguish an application failure from a preview, build, browser, dataset or authentication problem before changing code. Recover prior attempts and their results when available.

Reuse an existing test, CLI command, HTTP request or supported browser journey that exercises the symptom. Make its outcome observable and rerunnable. Verify that it fails for the reported reason; a nearby startup error or a command that merely exits successfully is weak evidence. Reduce irrelevant setup when that makes the loop faster without changing the failure.

For intermittent behavior, record frequency and conditions rather than claiming deterministic proof. Use bounded retries with controlled inputs. If reproduction is unavailable, state the missing access or evidence and distinguish source-based diagnosis from a reproduced failure. Continue useful read-only investigation; ask for what is actually needed to verify a fix.

## Test explanations

For a non-obvious cause, rank a small set of plausible explanations and state what observation would disprove each. Run the cheapest distinguishing probe first, changing one variable at a time. Prefer targeted inspection, debugger output or tagged temporary instrumentation over broad logging. Keep credentials out of commands and artifacts.

After two failed fixes sharing an assumption, write down that assumption and test it directly before another fix. For example, check whether the failing request reaches the suspected service or whether the artifact being viewed matches the changed revision.

For slowness or a measured speedup, read `references/benchmark-checklist.md` before interpreting the number. Separate time spent waiting on setup or a harness from time spent in the application.

## Fix and verify

Make the smallest change that removes the demonstrated cause while preserving intended contracts. When a cheap existing test seam can catch the real failure, run a regression check failing before the fix and passing after it. Prefer the original executable repro when a new test would only mirror implementation or require an unrelated framework.

Rerun the original scenario and relevant nearby checks. Preserve unrelated edits and remove only owned temporary instrumentation and fixtures. Report the cause, change, observed verification and material limits. A passing substitute check alone does not prove the user's original symptom is resolved. Deployment, production instrumentation and data writes remain within the user's existing authorization.
