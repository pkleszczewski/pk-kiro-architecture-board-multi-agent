# Deep Dive Placement Rules

Rules for all agents producing deep-dive analyses within architecture cases.

## Decision Rule

When creating a deep dive, determine placement by answering:

> **Does this analysis apply regardless of which option/alternative is chosen?**

| Answer | Placement | Path |
|--------|-----------|------|
| Yes — problem exists across multiple options | `alternatives/shared-deep-dives/` | Cross-cutting |
| No — triggered by or specific to one option | `alternatives/option-N/` | Option-specific |

## Classification Logic

- **Cross-cutting:** The concern exists independent of the architectural choice. Authentication, multi-cloud consistency, observability strategy, shared infrastructure — these problems must be solved no matter which option wins.
- **Option-specific:** The analysis was triggered by a technology or design decision unique to one option. A framework evaluation that only one option proposes, or a pattern that only applies to one option's architecture.
- **Multi-option (2+):** If it affects 2 or more options, treat as cross-cutting → `shared-deep-dives/`.

## Rules

1. **Default to option-specific.** If unclear, place under the triggering option. Promote to shared later if needed.
2. **Multi-option = shared.** Affects 2+ options → `shared-deep-dives/`.
3. **Shared architecture elements are always cross-cutting.** Anything listed in the summary's "Shared Architecture Elements" table produces cross-cutting deep dives.
4. **Reference, don't duplicate.** If an option-specific deep dive uncovers a cross-cutting concern, extract it to `shared-deep-dives/` and link from the option document.
5. **Update navigation.** After placing a deep dive, update `mkdocs.yml`:
   - Option-specific → under the relevant `Option X` nav section
   - Cross-cutting → under `Cross-Cutting Deep Dives` nav section

## Folder Structure

```
alternatives/
├── summary.md
├── shared-deep-dives/
│   ├── <cross-cutting-topic>.md
│   └── ...
├── option-1/
│   ├── research.md
│   ├── critique.md
│   └── <option-specific-deep-dive>.md
├── option-2/
│   └── ...
└── option-3/
    ├── research.md
    ├── critique.md
    └── <option-specific-deep-dive>.md
```

## Examples

| Topic | Classification | Reason |
|-------|---------------|--------|
| Authentication / Identity | Cross-cutting | Auth must be solved regardless of which architecture is chosen |
| Multi-cloud consistency | Cross-cutting | Cloud topology is a constraint that affects all options equally |
| Specific framework adoption | Option-specific | Triggered by one option's tech stack choice, not relevant to others |
| Shared infrastructure (e.g., workflow engine) | Cross-cutting | All options depend on it (shared element) |
| Library fitness evaluation | Depends | Cross-cutting if multiple options use it; option-specific if only one does |
