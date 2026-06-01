# Architecture Board — Kiro CLI Setup

AI-powered architecture decision workspace using Kiro CLI with specialized sub-agents, MkDocs Material for documentation, and Marp for presentations.

## Quick Start

```bash
# Start documentation server
mkdocs serve

# Open in browser
open http://localhost:8000
```

## Project Structure

```
.
├── cases/                    # All architecture cases (MkDocs docs_dir)
│   ├── index.md              # Dashboard — all cases with status/progress
│   ├── stylesheets/          # MkDocs custom CSS
│   ├── javascripts/          # Custom JS (nav state persistence)
│   └── <case-name>/          # Individual case folders
│       ├── requirements/
│       ├── alternatives/
│       │   ├── summary.md
│       │   ├── shared-deep-dives/
│       │   ├── option-1/
│       │   ├── option-2/
│       │   └── option-N/
│       ├── decisions/
│       └── documentation/
├── templates/marp/           # Marp presentation themes (per-brand)
├── .kiro/
│   ├── agents/               # Sub-agent definitions (roles + prompts)
│   └── steering/             # Cross-agent rules (deep-dive placement)
├── mkdocs.yml                # MkDocs config + navigation
├── .env                      # Brand template + secrets (not committed)
├── validate-md.sh            # Markdown structural validator
└── apply-theme.sh            # Brand theme switcher
```

## Scripts

### `./validate-md.sh [path]`

Validates markdown files for structural issues that break MkDocs rendering:
- Tables without a blank line before them (won't render as tables)
- Headers without a blank line before them

```bash
./validate-md.sh                    # Validate all cases/
./validate-md.sh cases/my-case/     # Validate specific case
```

### `./apply-theme.sh`

Applies brand-specific styling to MkDocs and Marp. Reads `BRAND_TEMPLATE` from `.env`.

```bash
# Set brand in .env: BRAND_TEMPLATE=default|brand-1|brand-2
./apply-theme.sh
# Then restart mkdocs serve
```

## Agents

| Agent | Role |
|-------|------|
| `architecture-supervisor` | Orchestrates the full workflow, delegates to specialists |
| `architecture-researcher` | Identifies architecture patterns, proposes options |
| `technology-researcher` | Evaluates technology stacks, produces comparison matrices |
| `requirement-engineer` | Gathers and structures functional/non-functional requirements |
| `critic` | Identifies risks, weak points, organizational constraints |
| `documentalist` | Produces final documentation, presentations, summaries |
| `web-crawler-mcp-playwright-agent` | Browser automation for web research |

## Workflow Phases

1. **Discovery** — Stakeholder Q&A to gather context
2. **Initial Research** — Parallel delegation to specialists (requirements, architecture, technology)
3. **Draft Artifacts** — Structure findings into case folder (status: DRAFT)
4. **Human Review** ⏸️ — Stakeholder reviews drafts
5. **Critique** — Critic evaluates each option
6. **Human Review** ⏸️ — Stakeholder reviews critique
7. **Amendments** — Fix issues from feedback
8. **Decision** ⏸️ — Write ADR collaboratively
9. **Consistency Verification** — Cross-check all artifacts
10. **Documentation** — Final deliverables (Documentalist)

## Steering Rules

### Deep Dive Placement (`.kiro/steering/deep-dive-placement.md`)

Determines where deep-dive analyses go:
- **Cross-cutting** (applies to all options) → `alternatives/shared-deep-dives/`
- **Option-specific** (triggered by one option) → `alternatives/option-N/`
- **Affects 2+ options** → treat as cross-cutting

## MkDocs Features

- **Collapsible navigation** — all sidebar sections collapse/expand
- **State persistence** — nav collapse state saved in localStorage across page loads
- **Mermaid diagrams** — all architecture diagrams render as interactive SVGs
- **Dark theme** — slate color scheme with custom brand colors
- **Instant navigation** — SPA-style page transitions

## Configuration

### `.env`

```bash
BRAND_TEMPLATE=default              # default | brand-1 | brand-2
GITHUB_PERSONAL_ACCESS_TOKEN=...    # For GitHub MCP server
```

### Adding a New Case

The supervisor agent handles this automatically, but manually:

1. Create folder structure under `cases/<case-name>/`
2. Add nav entry to `mkdocs.yml`
3. Update `cases/index.md` dashboard table
