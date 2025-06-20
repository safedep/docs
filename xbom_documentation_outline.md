# xBom Documentation

## I. Introduction
    * What is xBom?
        * Generating BOMs enriched with AI, SaaS, and more
        * Using Static Code Analysis
    * Why xBom?
        * Beyond Manifests: Building inventory from codebase evidence
        * Extensible Signatures: Adding custom signatures
        * Robust Compliance: Single tool for software supply chain compliance
        * Multi-ecosystem support: Java, Python, and more

## II. Getting Started
    * Installation
        * macOS & Linux (brew)
        * Pre-built binary
    * Quick Start Guide
        * Generating a BOM for source code
        * Output format: CycloneDX v1.6 JSON

## III. Features
    * Supported Languages
        * Python (Active)
        * Java (Active)
        * JavaScript (WIP)
    * Supported BOMs / Integrations
        * AI
            * LangChain
            * Anthropic
            * CrewAI
            * OpenAI
        * Cloud
            * GCP
            * Azure
        * Requesting new framework support (link to GitHub issues)
    * Visual Convenience
        * Interactive HTML output for BOM overview

## IV. Development
    * Signatures
        * Community-driven signatures
        * Location: `signatures/`
        * Naming convention: `signatures/$vendor/$product/$service.yml`
        * Contributing new signatures (link to CONTRIBUTING.md#contributing-signatures)

## V. Contributing
    * General contribution guidelines (link to CONTRIBUTING.md)

## VI. Limitations
    * Current focus: AI BOM generation
    * Method: Static code analysis for AI product identification
    * For comprehensive SBOM with library dependencies: Use `vet` (link to safedep/vet)

## VII. Telemetry
    * Anonymous telemetry collection
    * Purpose: Understanding usage and improving the product
    * Disabling telemetry: `XBOM_DISABLE_TELEMETRY=true` (environment variable)

## VIII. Appendix / Additional Information (Optional)
    * Badges / Project Health Indicators (briefly mention what they signify if deemed necessary)
        * Go Report Card
        * License
        * Release Version
        * OpenSSF Scorecard
        * SLSA Level
        * CodeQL
        * Go Reference
