# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Codebase Architecture

This repository contains documentation for SafeDep, built using Mintlify documentation platform.

### Information Architecture

> **Canonical IA:** `docs-ia.md` (mirrored to Notion). This section is the condensed
> operational copy — keep it in sync with `docs-ia.md` when the structure changes.

The documentation is organized into **6 tabs** — three solution tabs at the core, plus supporting tabs:

1. **Get Started** — "What is SafeDep?" primer, quickstarts, core concepts
2. **Package Security** — block malicious packages at install time and in CI/CD (pmg)
3. **AI Agent Security** — discover, audit, and control what AI agents access and run (MCP, Gryph, vet AI discovery)
4. **Visibility & Governance** — scan repos/SBOMs/CI/CD for risk; manage policy and cloud visibility (vet, xBom, SafeDep Cloud, Endpoint Hub, Endpoint Sync)
5. **Reference** — exact syntax/APIs (vet query & policy, API & automation)
6. **Community & Support** — community resources and FAQ

> **Implementation note:** Tab renames in `docs.json` are a later phase. `docs-ia.md` records the intended structure.

### Governing Rules (how the IA evolves)

Every placement decision derives from these rules. Full rationale and page map: `docs-ia.md`.

- **R1 — One primary entry point.** New visitors meet a clear "What is SafeDep?" primer, not a tool catalog.
- **R2 — Capability ladder, not persona gate.** The journey runs: individual dev → team → org-wide governance. Navigation doesn't pin users to a tier. Features requiring SafeDep Cloud are marked with a `<Note>` callout — no structural separation.
- **R3 — Organize by solution, not by tool.** Tabs name the security outcome SafeDep delivers. Grammar test: "SafeDep solves ___" must complete naturally with the tab name.
- **R4 — Concepts are first-class, atomic, linkable.** Each concept (Policy, Endpoint, Tenant, Malysis/Malbase, SBOM, CEL) gets one dedicated page under Get Started › Core Concepts. Malysis is the intelligence layer — never a product tab.
- **R5 — Progressive disclosure.** Tab depth is unlimited; groups handle it. A tab splits only when it covers fundamentally different security outcomes. The Reference tab is the only place for exhaustive lookup content.
- **R6 — docs.safedep.io is the guide layer.** Product-level technical reference (CLI flags, type definitions) lives in individual product repos. This site covers concepts, how-tos, and integration guides.
- **R7 — AI-agent consumability is first-class.** One concept per atomic page, predictable headings, stable URLs.

**Test for any new page:** *What security outcome does this serve?* If the answer is "it documents tool X" rather than "it helps someone achieve Y," it is in the wrong place.

### Where does a new page go?

| If the page… | Tab | Example group |
|---|---|---|
| Defines a concept/term used across docs | Get Started | Core Concepts |
| Onboards a new user / routes entry points | Get Started | Introduction / Quickstarts |
| Covers malicious package blocking (install-time or CI/CD) | Package Security | pmg / CI/CD Package Blocking |
| Covers AI agent discovery, audit, or control | AI Agent Security | AI Agent Observability / AI Coding Protection |
| Covers scanning repos, SBOMs, CI/CD for risk | Visibility & Governance | Repository Scanning / Bill of Materials / CI/CD |
| Covers cloud policy, endpoint inventory, access | Visibility & Governance | SafeDep Cloud / Endpoint Hub / Policy & Risk |
| Is pure lookup (syntax, flags, API) | Reference | vet Query & Policy / API & Automation |
| Is community/support | Community & Support | Community / Support |

A page appears in **exactly one** sidebar slot. To surface it from another tab, add an in-body `<Card>` — never a second nav entry.

### Product Philosophy

SafeDep is **open source first**. All core security tools (vet, pmg, xBom) are free, open source, and operate independently of SafeDep's commercial business. SafeDep Cloud provides optional hosted services and additional features for teams.

### Documentation Organization (Diátaxis Framework)

All documentation follows the **Diátaxis framework** with four content types:

1. **Tutorials** (`introduction.mdx`, `*/quickstart.mdx`) — Learning-oriented, hands-on. Live in Get Started or at the top of a solution tab.
2. **How-to Guides** — Live in the relevant solution tab (Package Security / AI Agent Security / Visibility & Governance):
   - CI/CD & Platform Integrations: GitHub, GitLab, Bitbucket, JFrog, DefectDojo
   - SBOM & Analysis: CycloneDX, dependency inventory, code analysis
   - API & Automation: TypeScript API usage, Terraform audits
3. **Reference** (`vet/advanced/`, `api-reference/`) — Technical specifications and lookup. All live in the **Reference** tab.
4. **Explanation / Concepts** (`concepts/`) — Conceptual understanding. Live in Get Started › Core Concepts (atomic, first-class, linkable — R4).

**Diátaxis → location quick map:** Tutorial → Get Started · How-to → relevant solution tab · Reference → Reference tab · Explanation → Get Started › Core Concepts.

### File Structure

```
/
├── docs.json              # Mintlify config: navigation, theme, SEO
├── docs-ia.md             # Canonical living IA document (← update when IA changes)
├── docs-ia-proposal.md    # Design/decision record (benchmarks, rationale)
├── styles.css             # Custom styling
│
├── concepts/              # ★ New: atomic concept pages (Get Started › Core Concepts)
├── get-started/           # ★ New: primer, entry points, quickstart aggregators
├── package-security/      # ★ New: Package Security tab content
├── ai-security/           # ★ New: AI Agent Security tab content
├── governance/            # ★ New: Visibility & Governance tab content
├── reference/             # ★ New: Reference tab content
│
├── vet/                   # Legacy tool path (grandfathered — don't move files)
│   ├── quickstart.mdx
│   ├── concepts/
│   ├── guides/
│   └── advanced/
├── pmg/                   # Legacy tool path (grandfathered)
├── xbom/                  # Legacy tool path (grandfathered)
├── cloud/                 # Legacy tool path (grandfathered)
├── apps/                  # Legacy tool path (grandfathered)
├── scan/                  # Legacy tool path (grandfathered)
├── api-reference/         # API specifications (grandfathered)
│
├── images/                # Static images and screenshots
├── logo/                  # Brand assets
└── snippets/              # Reusable MDX content blocks
```

**Path convention:** New pages use solution-aligned paths (`package-security/`, `ai-security/`, `governance/`, `concepts/`). Legacy paths (`vet/`, `pmg/`, `cloud/`, `apps/`, `scan/`) are grandfathered — moving them requires a `redirects` entry in `docs.json`.

## Common Development Commands

```bash
# Install Mintlify CLI globally
npm i -g mintlify

# Start development server (runs at http://localhost:3000)
mintlify dev

# Troubleshoot dependencies
mintlify install
```

**Important:** All Mintlify commands must be run from the repository root where `docs.json` is located.

## Documentation Writing Guidelines

All content must follow the **[Diátaxis framework](https://diataxis.fr/)** principles. Before creating or editing content:

1. **Identify the content type** - Determine which quadrant your content belongs to:
   - **Tutorial**: Teaching through hands-on practice for beginners (e.g., quickstart guides)
   - **How-to Guide**: Solving specific problems with step-by-step instructions (e.g., integrations)
   - **Reference**: Technical specifications for lookup (e.g., API docs, filtering syntax)
   - **Explanation**: Conceptual understanding of "why" (e.g., architecture, design decisions)

2. **Write in the appropriate style**:
   - Tutorials: Learning-oriented, safe to fail, build confidence
   - How-to Guides: Problem-oriented, goal-focused, practical steps
   - Reference: Information-oriented, comprehensive, minimal explanation
   - Explanation: Understanding-oriented, theoretical, connects concepts

3. **Don't mix content types** - Each document should serve one purpose

### Content Standards

**File Naming:**
- Use kebab-case: `github-code-scanning.mdx`, `why-vet.mdx`
- Be specific and descriptive (avoid generic names like `guide.mdx`)

**Frontmatter (required):**
```yaml
---
title: Descriptive Page Title
description: "Clear, searchable description under 160 characters"
---
```

**Structure:**
- Start with frontmatter (no H1 header - Mintlify handles titles from frontmatter)
- Use H2 (`##`) for main sections, H3 (`###`) for subsections
- End with related links using `<CardGroup>` components

**Mintlify Components:**
- `<CardGroup>` and `<Card>` - Related links and navigation
- `<Steps>` - Sequential processes
- `<Tabs>` - Alternative approaches
- `<AccordionGroup>` - Optional details
- `<Info>`, `<Warning>`, `<Tip>`, `<Note>` - Callouts

**Code Examples:**
- Always test code examples before including them
- Use appropriate language tags for syntax highlighting
- Include comments for complex parts
- Provide complete, runnable examples when possible

### Navigation Updates

When adding new pages, update `docs.json`:
1. Consult the "Where does a new page go?" table above to pick the correct tab and group
2. Find that tab and group in the `navigation.tabs` array
3. Add the page path (without `.mdx` extension) to the `pages` array
4. New files should use goal/topic-based paths (see File Structure above)

Example — adding a new CI/CD integration guide:
```json
{
  "tab": "Scan & Analyze",
  "groups": [
    {
      "group": "CI/CD & Platform Integrations",
      "pages": [
        "apps/github/overview",
        "vet/guides/github-code-scanning",
        "scan/new-platform-integration"  // ← new page at goal-based path
      ]
    }
  ]
}
```

After every `docs.json` change, run: `node_modules/.bin/mintlify broken-links`

## Development Notes

- All content uses **MDX format** for enhanced markdown capabilities
- Images go in `images/` directory - optimize before committing
- Reusable content blocks go in `snippets/` directory
- The `essentials/` directory contains Mintlify usage examples (not part of main docs navigation)
- Use descriptive alt text for all images (accessibility)
- Test all external links before committing
- Write for international audiences (clear, accessible language)

## Common Tasks

**Adding a new How-to Guide:**
1. Use the placement table ("Where does a new page go?") to pick the correct tab and group
2. Create the file at a **solution-aligned path** (e.g., `governance/new-platform-integration.mdx`, not `vet/guides/new-integration.mdx`)
3. Add frontmatter with title and description
4. Structure with clear step-by-step instructions (Diátaxis: How-to)
5. Include practical code examples
6. Update `docs.json` under the correct solution tab and group
7. Run `node_modules/.bin/mintlify broken-links` to verify no broken links

**Adding a concept page:**
1. Create the file at `concepts/<topic>.mdx` (e.g., `concepts/policy.mdx`)
2. Add to Get Started › Core Concepts in `docs.json`
3. Focus on explaining "what this is and why it matters" — no step-by-step instructions (Diátaxis: Explanation)
4. Make it atomic: one concept, one page, stable URL for linking
5. Update `docs-ia.md` §7 to include the new page, and update the Notion mirror

**Updating API Reference:**
1. Modify files in `api-reference/`
2. Ensure technical accuracy and completeness
3. Keep explanations minimal (reference, not tutorial)
4. Update OpenAPI specs if applicable

## Solution-Based Organization

The docs site is organized by **security outcome** rather than by tool. Users navigate to what they want to accomplish; the tools appear one level deeper.

When adding new content:
- **Don't** create new tool-specific tabs or top-level groups
- **Do** add pages to the appropriate solution tab using the placement table above
- Think about the security outcome, not the tool being documented
- If a page logically surfaces in multiple tabs, pick the primary home and add in-body `<Card>` links from the secondary location — never duplicate the nav entry
