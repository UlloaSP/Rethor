---
name: legilimens
description: Visualize comparisons and mappings, sequences and state changes, hierarchies and dependencies, or quantitative patterns directly in the answer when prose would make the reader reconstruct their relationships. Prefer compact prose when no visual materially improves comprehension. Must always apply.
---

# Legilimens

Make structure visible. Design the answer around what the reader needs to understand or decide. Use an inline visual when it materially reduces reader reconstruction while preserving the meaning, uncertainty, emphasis, and scope of the source material. The visual is the explanation, not decoration around it.

## Choose the representation

| Governing relationship | Preferred form | The form succeeds when |
|---|---|---|
| Options, repeated fields, exact mappings | Table | Rows and columns make comparison or lookup immediate |
| Order, causality, transitions, state changes | Flow or timeline | Direction and transitions are explicit |
| Containment, ownership, nesting | Tree | Parent-child relationships are unambiguous |
| Dependencies, interactions, data flow | Node-link diagram | Nodes and meaningful edges are identifiable |
| Magnitude, trend, proportion, distribution | Chart | Values, units, scale, and categories come from real data |
| One linear claim or nuance without useful structure | Compact prose or a short list | The reader can understand it without reconstructing relationships |

Treat these as choices, not a fixed hierarchy. Combine forms only when each exposes a different relationship the reader needs.

## Compose the answer

1. Identify the governing relationship and the reader's task. If neither yields a useful visual structure, use compact prose.
2. Choose the smallest representation that preserves every material distinction. Prefer a Markdown table for tabular information. For diagrams and charts, use syntax the current renderer supports; when support is uncertain, use a readable monospaced text diagram.
3. Place the visual directly where the explanation is needed, usually before supporting commentary. Keep it understandable without requiring the reader to execute code or open another artifact unless they requested one.
4. Label elements precisely. Preserve qualifications, uncertainty, chronology, causality, units, and scale. Show unknown or disputed relationships as unknown or disputed.
5. Let prose carry only interpretation, caveats, or conclusions the visual cannot carry. Each sentence should add information beyond the cells, nodes, or edges.

## Verify

Before answering, confirm that:

- every category, connection, and quantity is grounded in the available information;
- the visual is legible on its own and emphasizes the relationship that matters;
- each supporting sentence adds meaning beyond the visual; and
- the visual reduces reader reconstruction more than compact prose. Otherwise, use the prose.
