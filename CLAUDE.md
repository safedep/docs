# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Codebase Architecture

This repository contains documentation for SafeDep, built using Mintlify documentation platform.

### Information Architecture

The documentation is organized into **4 main tabs**:

**1. Welcome** - Introduction and overview
- `introduction.mdx` - Home page with OSS philosophy and getting started

**2. Open Source** - OSS supply chain security implementation (use-case based)
- **Concepts** - Single comprehensive page per tool (vet, pmg, xBom)
  - `vet/concepts/why-vet.mdx` - Combined "why" and "about" content
  - `pmg/concepts/why-pmg.mdx` - Combined "why" and "about" content
  - `xbom/concepts/why-xbom.mdx` - Combined "why", features, and signatures content
- **Quickstart** - Getting started guides for each tool
- **Integration Guides** - CI/CD and platform integrations
- **SBOM & Analysis** - SBOM generation and dependency analysis workflows
- **API & Automation** - Programmatic access and automation
- **Advanced Usage** - Advanced configurations and policy management

**3. SafeDep Cloud** - Commercial SaaS platform and integrations
- Cloud platform features (`cloud/`)
- Apps & integrations (`apps/`)
- API Reference (`api-reference/`)

**4. Community & Support** - Community resources and general FAQ

### Product Philosophy

SafeDep is **open source first**. All core security tools (vet, pmg, xBom) are free, open source, and operate independently of SafeDep's commercial business. SafeDep Cloud provides optional hosted services and additional features for teams.

### Documentation Organization (Diátaxis Framework)

All documentation follows the **Diátaxis framework** with four content types:

1. **Tutorials** (`introduction.mdx`, `*/quickstart.mdx`) - Learning-oriented, hands-on lessons for beginners
   - The `introduction.mdx` serves as the home page and emphasizes the OSS philosophy
2. **How-to Guides** (`vet/guides/`, organized by use-case):
   - Integration Guides: GitHub, GitLab, DefectDojo
   - SBOM & Analysis: CycloneDX, dependency inventory, code analysis
   - API & Automation: TypeScript API usage, Terraform audits
3. **Reference** (`api-reference/`, `vet/advanced/`) - Technical specifications and lookup resources:
   - API specifications and endpoints (under SafeDep Cloud tab)
   - Advanced filtering, policy-as-code syntax, query language
4. **Explanation** (`*/concepts/`, `cloud/`) - Understanding-oriented conceptual content explaining "why" and architecture

### File Structure

```
/
├── docs.json              # Mintlify config: navigation, theme, SEO
├── styles.css             # Custom styling
├── {product}/             # Product-specific sections (vet, pmg, xbom, apps, cloud)
│   ├── quickstart.mdx     # Getting started tutorial
│   ├── concepts/          # Explanatory content
│   ├── guides/            # How-to guides
│   └── advanced/          # Reference documentation
├── api-reference/         # API specifications
├── images/                # Static images and screenshots
├── logo/                  # Brand assets
└── snippets/              # Reusable MDX content blocks
```

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
1. Find the appropriate tab and group in the `navigation` section
2. Add the page path (without `.mdx` extension) to the `pages` array
3. Ensure the page appears in the correct group based on use-case (not tool)

Example:
```json
{
  "group": "Integration Guides",
  "pages": [
    "vet/guides/github-code-scanning",
    "vet/guides/new-integration"  // Added page
  ]
}
```

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
1. Create file in appropriate `guides/` subdirectory (e.g., `vet/guides/new-integration.mdx`)
2. Add frontmatter with title and description
3. Structure with clear step-by-step instructions
4. Include practical code examples
5. Update `docs.json` navigation under the appropriate use-case group
6. Test locally with `mintlify dev`

**Adding concept content for an OSS tool:**
1. Edit the existing consolidated concept page (e.g., `vet/concepts/why-vet.mdx`)
2. Add new H2 sections to organize the content
3. Focus on explaining "why" and architecture
4. Avoid step-by-step instructions (that's for How-to Guides)
5. Connect to broader security concepts
6. No need to update `docs.json` - concepts are already in navigation

**Updating API Reference:**
1. Modify files in `api-reference/`
2. Ensure technical accuracy and completeness
3. Keep explanations minimal (reference, not tutorial)
4. Update OpenAPI specs if applicable

## Use-Case Based Organization

The "Open Source" tab is organized by **use-case and workflow** rather than by tool. This helps users find solutions based on what they want to accomplish, not which tool they need to use.

When adding new content:
- **Don't** create new tool-specific groups
- **Do** add pages to existing use-case groups (Integration Guides, SBOM & Analysis, etc.)
- Think about the user's goal, not the tool being documented
