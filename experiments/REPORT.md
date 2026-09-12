# Experiment log

The benchmark is a development aid, not proof of general writing quality. Every run uses anonymous A/B ordering and the rubric in `rubric.md`. Raw outputs remain local under `results/`.

## Run 1: discarded prototype baseline

- Date: 2026-09-12
- Model: `gpt-6-astra`
- Cases: 4
- Mapping: A = control, B = deliberate-writing
- Blind score: control 119/120, deliberate-writing 118/120
- Case preferences: control 1, deliberate-writing 1, ties 2

This run predates the current user-supplied `SKILL.md` and is retained only as experiment history. It did not show an overall advantage. Both systems hit the rubric ceiling on most dimensions.

No conclusion from this run was added to the current skill. Two harder cases were added to test selective editing and preservation of epistemic qualifications.

## Run 2: user-supplied v0.1

- Date: 2026-09-12
- Model: `gpt-6-astra`
- Cases: 6
- Mapping: A = control, B = deliberate-writing
- Blind score: control 173/180, deliberate-writing 179/180
- Case preferences: control 0, deliberate-writing 4, ties 2

The treatment won the technical explanation, argumentative paragraph, professional email, and semantic-preservation rewrite. The informative answer and selective literary edit tied. The evaluator attributed the gains to a stated physical assumption in the technical example, more useful decision criteria for the skeptical council, a concrete planning deadline in the email, and better preservation of the source's wording about workload.

Both semantic-preservation responses introduced "followed," which can imply a longitudinal design absent from the source. The skill reduced but did not eliminate semantic drift. This single run supports further testing; it does not establish a general effect size.

The comparison is controlled at the prompt level and judged blind, but it still uses one model to generate and evaluate the responses. Future runs should randomize across several seeds or models and include human raters.
