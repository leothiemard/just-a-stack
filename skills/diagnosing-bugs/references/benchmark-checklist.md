# Performance measurement

Adapted from pstack's benchmark-checklist at commit `8b3326d99fd4b993cb33a24dad8af03175c642c5`; see the repository's third-party notices and MIT license.

Match the depth to the claim. For a requested ballpark, one labeled run can suffice after checking correctness and whether the work happened. A decision between implementations or a claimed regression needs comparable repeated measurements.

Before measuring, state the proposed claim, unit and timed boundary. Read the harness to see what it includes, excludes, awaits and counts. Check machine load and competing jobs using available platform tools. Use comparable versions, inputs, concurrency, production settings and cache state. Profile in a separate run so profiler overhead does not enter the reported timing.

Check these facts:

- **The work happened:** requests reached the target, asynchronous work was awaited, lazy results were consumed, and outputs are correct. Count errors, rejected work, retries and timeouts; skipped work often looks fast.
- **The comparison is fair:** same meaningful work and realistic configuration on each side. Label warm/cold caches and setup costs. Where an option is untuned or unavailable, bound the conclusion to what was actually compared.
- **The result repeats:** alternate before/after runs when practical. For a consequential choice, start with at least five per side and report the median and spread. Treat a gap within run variation as inconclusive; use the harness's statistics when needed.
- **The magnitude is plausible:** identify the bottleneck and compare the claimed savings with the portion of the run changed. A faster helper may barely affect total response time.
- **The number matches the user's wait:** include an end-to-end measure alongside a microbenchmark. In CI, distinguish total job time, parallel execution and critical-path wall-clock time; aggregate minutes are not elapsed latency. Separate dependency installation, cache restoration, builds and tests.

Report the verdict, primary number with units, run count/spread, environment and remaining uncertainty. Keep raw runs in an artifact when they would bury the conclusion. If errors, skipped work or incomparable setup explain the difference, repair the measurement before reporting a speedup.
