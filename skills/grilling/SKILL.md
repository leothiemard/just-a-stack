---
name: grilling
description: Use when asked to grill, challenge or stress-test an implementation plan before coding. Resolve consequential product and rollout decisions. Ordinary architecture work, straightforward fixes and factual lookup do not trigger this interview.
metadata:
  inspired-by: https://github.com/mattpocock/skills/blob/49dd158d1076134a641b33efb035946536778336/skills/productivity/grilling/SKILL.md
---

# Grilling

Reach a small set of explicit consequential decisions, not an exhaustive questionnaire.

Read the supplied requirements/comments, notes identified by the user or project conventions, applicable instructions, current code and existing patterns. Finding facts is the agent's job. Ask the user only for decisions or inaccessible information that changes the implementation, could lose data or alters rollout.

Map dependencies between unresolved decisions. Ask only questions whose prerequisites are settled, at most three in a round. For each:

- **Decision:** precise question and the requirement it affects.
- **Recommendation:** default answer first, with one sentence of evidence and tradeoff.
- **Alternative:** include only a materially different viable choice.

Phrase questions so “yes” accepts the recommendation. Wait for answers before dependent questions. Reuse settled answers rather than asking them again.

Challenge optional fallbacks, identity remodels, dependencies, test frameworks and abstractions against the smallest correct implementation. Ask whether a simpler existing pattern satisfies the criterion. Separate product decisions from facts established by repository or dataset inspection.

Work inline unless delegation is requested or required by applicable instructions. If delegating factual exploration, use the requested provider/model and a bounded brief; keep unrelated decisions moving while its result is pending.

Finish with agreed decisions, minimal implementation steps, verification and remaining blockers. Preserve exact scope and identify deviations from the supplied requirements. Grilling alone does not authorize implementation or dataset writes; proceed only within the user's existing task authorization after consequential decisions are settled.
