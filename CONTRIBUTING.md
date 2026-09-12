# Contributing

Treat every new rule as a hypothesis about model behavior. Add it only after a realistic example exposes a repeatable failure, and prefer the narrowest instruction that fixes the failure without constraining unrelated writing.

For behavioral changes:

1. Add or refine a case that makes the failure observable.
2. Run `scripts/run-experiments.ps1` before and after the change.
3. Check semantic fidelity before style scores.
4. Keep the change only when the evidence shows a functional gain across the affected cases without regressions elsewhere.

Do not turn individual phrases into a blacklist. Record why a choice fails in context.
