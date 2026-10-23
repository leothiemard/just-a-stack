# Writing for agents

Adapted from Matt Pocock's writing-for-agents at commit `5beb35b040e3de97e54fa9e386d7e42d15c295c2`; see the repository's third-party notices and MIT license.

Use this when a retrospective identifies a concrete change to a skill or instruction file.

- Put the correction at its existing source of truth. Inspect current instructions and executable configuration before adding another rule. Prefer fixing an ambiguous instruction or wiring an existing check over duplicating it elsewhere.
- Describe the behavior and the condition that should trigger it. A reference needs a pointer explaining when to read it; a useful document behind a vague pointer may never be loaded.
- Keep always-loaded descriptions and instructions short. Inline what every relevant task needs; put substantial guidance for a particular branch in a linked reference. Split only where the distinction makes the next task easier to perform.
- Keep a concept, its constraints and exceptions together. Remove repeated meanings and stale examples. Cache facts only when rediscovery is costly or the reason cannot be found in the repository.
- Give important steps an observable completion criterion. Replace “verify thoroughly” with the specific behavior or invariant the check needs to demonstrate. Keep the criterion proportional to the failure observed.
- State the desired behavior positively, retaining explicit prohibitions for actual boundaries. Avoid universal rules derived from one unusual session.
- Explain which observed incident the proposed instruction would have prevented and what cost it adds. Validate with a realistic request when behavior is uncertain; wording checks alone do not prove improvement.

For skill packaging and metadata, follow the active harness's current skill-authoring guidance rather than copying another agent's invocation fields.
