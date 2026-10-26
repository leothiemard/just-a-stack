# Start the reviewer

Follow the active host's tool-routing instructions. Resolve supported provider and model IDs rather than inventing a CLI command or falling back to another model.

In T3 Code, use `orchestrator_capabilities` before the first delegated review. Each round uses a fresh `delegate_task` with `role: review`, the chosen target and explicit effort when supported. Pass a self-contained brief with absolute input paths. Read-only reviewers share the existing checkout; they do not create another checkout. Follow the returned `next`. Do not poll or send a new round to the old child thread.

Outside T3, use the harness's supported reviewer/subagent tool. A native same-provider reviewer is suitable when the host supports it and it is the selected model. If the harness cannot run that reviewer, report BLOCKED instead of reviewing your own change as its replacement.

The reviewer must not edit files, commit, push, post comments or delegate. Do not give it unrelated conversation history. Wait for its result before editing the reviewed paths. Verify that its verdict covers the recorded inputs; a successful dispatch is not a completed review.
