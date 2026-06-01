# Draw.io Diagram Duplicates Rule

All Mermaid diagrams in case documentation MUST have a corresponding `.drawio` file.

## Rule

Every `\`\`\`mermaid` block in a case's markdown files requires a matching `.drawio` file placed in:

```
cases/<case-name>/documentation/diagrams/<diagram-name>.drawio
```

## Naming Convention

Derive the `.drawio` filename from the diagram's context:

| Source file | Mermaid diagram topic | `.drawio` filename |
|-------------|----------------------|-------------------|
| `requirements/requirements.md` | System overview | `system-overview.drawio` |
| `alternatives/option-1/research.md` | Architecture diagram | `option-1-architecture.drawio` |
| `alternatives/option-1/research.md` | Pipeline sequence | `option-1-pipeline.drawio` |
| `alternatives/summary.md` | Comparison flow | `comparison-flow.drawio` |
| `documentation/architecture.md` | Token pipeline | `token-pipeline.drawio` |

If a file contains multiple mermaid diagrams, each gets its own `.drawio` file.

## Responsibility

- **During research phases**: The agent producing mermaid diagrams is NOT required to create `.drawio` files (speed matters).
- **During documentation phase (Phase 10)**: The Documentalist MUST create `.drawio` duplicates for ALL mermaid diagrams across the entire case before marking documentation as complete.
- **Verification**: Before closing a case, check that the count of `.drawio` files in `documentation/diagrams/` matches the total count of mermaid blocks across all case markdown files.

## Format

`.drawio` files are XML (mxGraphModel format). Generate them directly via file write — no special tool needed.

## Inline Link Rule

Every mermaid diagram in markdown MUST have a link to its `.drawio` sibling directly below the closing ` ``` ` fence. This ensures the rendered HTML always provides access to the editable diagram.

Format (as a blockquote, immediately after the mermaid block):

```markdown
> 📎 [Open in draw.io](<relative-path-to-drawio-file>)
```

Use relative paths from the markdown file's location to `documentation/diagrams/`.

## Why

- Mermaid renders in MkDocs but is not editable by stakeholders in presentation tools
- `.drawio` files can be opened in draw.io, exported to PNG/SVG/PDF for slides and documents
- Stakeholders and agencies can modify diagrams without touching markdown
