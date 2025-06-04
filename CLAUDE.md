# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Codebase Architecture

This repository contains documentation for SafeDep, built using two different documentation frameworks:

1. **Current Mintlify Documentation** (root directory)
   - Modern documentation platform using Mintlify
   - Configuration: `docs.json` 
   - Content structure: `introduction.mdx`, `quickstart.mdx`, `development.mdx`, `essentials/`, `api-reference/`
   - Static assets: `images/`, `logo/`, `snippets/`

2. **Legacy Docusaurus Documentation** (`docs-legacy/`)
   - Previous documentation built with Docusaurus v3
   - Contains comprehensive SafeDep product documentation
   - Configuration: `docusaurus.config.js`, `sidebars.js`
   - Content: `docs/` directory with guides, concepts, cloud features, etc.

## Common Development Commands

### Mintlify Documentation (Current)
```bash
# Install Mintlify CLI globally
npm i -g mintlify

# Start development server
mintlify dev

# Troubleshoot dependencies
mintlify install
```

### Legacy Docusaurus Documentation
```bash
# Navigate to legacy docs
cd docs-legacy

# Install dependencies
npm install

# Start development server
npm run start

# Build documentation
npm run build

# Serve built documentation
npm run serve

# Clear cache
npm run clear
```

## Key Configuration Files

- `docs.json`: Mintlify configuration with navigation, theming, and site metadata
- `docs-legacy/docusaurus.config.js`: Docusaurus configuration for legacy docs
- `docs-legacy/package.json`: Dependencies and scripts for legacy documentation

## Content Structure

The current Mintlify docs are structured as a starter template and need to be populated with actual SafeDep content from the legacy documentation. The legacy docs contain the real SafeDep documentation including:

- Product concepts and "why vet" explanations
- Cloud features and authentication guides  
- Advanced usage patterns and integrations
- Community resources and FAQs

## Development Notes

- Run Mintlify commands from the repository root where `docs.json` is located
- Legacy Docusaurus documentation is fully functional with SafeDep-specific content
- The current Mintlify setup appears to be a template that needs migration from legacy docs
- Both documentation systems use MDX for content authoring