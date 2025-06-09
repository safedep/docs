# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Codebase Architecture

This repository contains documentation for SafeDep, built using Mintlify documentation platform:

**Mintlify Documentation** (root directory)
- Modern documentation platform using Mintlify
- Configuration: `docs.json` 
- Content structure includes:
  - Core pages: `introduction.mdx`, `quickstart.mdx`, `development.mdx`
  - Organized sections: `essentials/`, `api-reference/`, `guides/`, `concepts/`, `cloud/`, `advanced/`
  - Static assets: `images/`, `logo/`, `snippets/`
  - Community and resources: `community.mdx`, `resources.mdx`, `faq.mdx`

## Common Development Commands

```bash
# Install Mintlify CLI globally
npm i -g mintlify

# Start development server
mintlify dev

# Troubleshoot dependencies
mintlify install
```

## Key Configuration Files

- `docs.json`: Mintlify configuration with navigation, theming, and site metadata

## Content Structure

The documentation is organized into the following main sections:

- **Concepts**: Core SafeDep concepts and explanations (`concepts/`)
- **Guides**: Step-by-step tutorials and integrations (`guides/`)
- **Cloud**: Cloud platform features and authentication (`cloud/`)
- **Advanced**: Advanced usage patterns and configurations (`advanced/`)
- **API Reference**: API endpoints and OpenAPI specification (`api-reference/`)
- **Essentials**: Documentation writing guidelines (`essentials/`)

## Documentation Writing Guidelines

When creating or editing documentation, follow the [Diátaxis framework](https://diataxis.fr/) to ensure content is appropriately structured and user-focused. More information can be found in [CONTRIBUTING.md](CONTRIBUTING.md).

## Development Notes

- Run Mintlify commands from the repository root where `docs.json` is located
- All content uses MDX format for enhanced markdown capabilities
- Images and assets are stored in the `images/` directory
- Reusable content snippets are stored in `snippets/`
- Follow Diátaxis principles when creating or restructuring content