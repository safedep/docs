# xBom: AI-Enriched Bill of Materials

## Overview

### What is xBom?
xBom is a tool designed to generate Bill of Materials (BOMs) that are enriched with information about AI components, SaaS integrations, and more. It achieves this by utilizing static code analysis to identify these elements within your codebase. This allows for a more comprehensive understanding of all the software and services your application relies on, going beyond traditional dependency tracking.

### Why use xBom? (The problem it solves)
Modern applications are complex and extend far beyond just open-source libraries. They frequently incorporate:

- AI SDKs 🧠
- ML models 🤖
- 3rd party SaaS APIs ☁️
- Cryptographic algorithms 🔑

Traditional BOM tools often focus solely on listed dependencies in manifest files (like `requirements.txt` or `pom.xml`). xBom addresses the need for a deeper insight into the actual components and services your code interacts with, providing a more accurate inventory for compliance, security, and operational awareness.

## Key Features

-   **Beyond Manifests**: xBom doesn't just look at your declared dependencies. It analyzes your code to find actual evidence of AI SDKs, cloud service APIs, and other critical components, providing a true inventory of what your application uses.
-   **Extensible Signatures**: xBom uses a system of signatures to detect various components. You can add your own custom signatures to identify proprietary or less common tools, tailoring xBom to your specific needs. These signatures are maintained in a community-driven repository.
-   **Robust Compliance**: In an era of increasing focus on software supply chain security and transparency (e.g., Executive Orders, industry standards), xBom helps you meet these requirements by providing a detailed and accurate BOM. It's a single tool to assist with various compliance needs.
-   **Multi-ecosystem Support**: xBom is designed to work with multiple programming languages and ecosystems. Currently, it actively supports Java and Python, with more languages like JavaScript in progress.

## Quick Start

### Installation

You can install xBom using one of the following methods:

**macOS & Linux (Homebrew):**
```bash
# Installation on macOS & Linux
brew install safedep/tap/xbom
```

**Pre-built binary:**
Alternatively, you can download a **[pre-built binary](https://github.com/safedep/xbom/releases)** suitable for your operating system from the GitHub releases page.

### Generating Your First BOM

To generate a BOM for your source code, use the `generate` command:

```bash
# Generate BOM for your source code
xbom generate --dir /path/to/your/code --bom /path/to/output/bom.cdx.json
```

Replace `/path/to/your/code` with the actual path to your project's source code directory and `/path/to/output/bom.cdx.json` with the desired path and filename for the generated BOM.

This command will produce a Software Bill of Materials (SBOM) in the **[CycloneDX v1.6 JSON format](https://cyclonedx.org/docs/1.6/json/)**. The BOM will include any AI components and other supported elements detected within the codebase.

## Supported Languages

Currently, `xbom` supports the following programming languages:

| Language   | Status   |
| ---------- | -------- |
| Python     | ✅ Active |
| Java       | ✅ Active |
| JavaScript | 🚧 WIP    |

We are continuously working to expand language support.

## Supported BOM Types

xBom specializes in identifying a variety of components beyond traditional libraries.

### AI Components
xBom can detect the usage of various AI SDKs and services, including:

*   LangChain
*   Anthropic
*   CrewAI
*   OpenAI

### Cloud Services
It can also identify integrations with major cloud platforms:

*   Google Cloud Platform (GCP)
*   Microsoft Azure

**ℹ️ To request support for a new AI framework or cloud service, please <a href="https://github.com/safedep/xbom/issues/new">create an issue</a> on our GitHub repository.**

## Visual Convenience

While the primary output of xBom is a CycloneDX JSON file, which is machine-readable and standardized, we understand the need for a quick, human-readable overview. xBom provides a link in its console output to an interactive HTML representation of the BOM. This allows for easy browsing and understanding of the detected components.

<div align="center">
  <img src="assets/xbom-demo.gif" alt="xbom-demo" width="100%" />
</div>

## Advanced Topics

### Signatures

**How they work:**
Signatures are the patterns and rules that xBom uses to detect the presence of specific SDKs, APIs, and libraries within your codebase. These signatures look for characteristic import statements, function calls, or other code constructs that indicate the use of a particular component.

**Community-driven repository:**
xBom maintains a repository of these signatures, which is community-driven. This allows for a broad and up-to-date set of detections. These are stored in the `signatures/` directory of the xBom project.

**Naming convention:**
Signatures follow a clear naming convention to ensure organization and clarity:
`signatures/$vendor/$product/$service.yml`

For example, a signature for an OpenAI service might be located at `signatures/openai/api/gpt.yml`.

**Link to contributing signatures guide:**
To add new signatures for components not yet covered, or to improve existing ones, please refer to the [contributing signatures guide](CONTRIBUTING.md#contributing-signatures).

### Contributing
We welcome contributions to xBom! Whether it's adding new signatures, improving the core functionality, or enhancing documentation, your help is valuable. Please refer to our main [CONTRIBUTING.md](CONTRIBUTING.md) file for detailed guidelines on how to contribute to the project.

### Limitations

**Current focus (AI BOM generation):**
It's important to note that `xbom` is currently focused on AI BOM generation. Its primary strength lies in using static code analysis to identify AI products, SaaS APIs, and similar non-library components used in your codebase.

**Recommendation for comprehensive SBOMs (vet tool):**
For generating a more comprehensive SBOM that includes a detailed list of all your open-source library dependencies (often derived from manifest files), we recommend using a complementary tool like [vet](https://github.com/safedep/vet). `vet` is another tool from SafeDep that specializes in dependency analysis and vulnerability management. Using xBom and vet together can provide a more holistic view of your software supply chain.

### Telemetry

**Purpose:**
`xbom` collects anonymous telemetry to help us understand how the tool is used. This data provides valuable insights into common use cases, popular integrations, and potential areas for improvement, ultimately helping us make xBom a better product for everyone. We do not collect any personally identifiable information or sensitive data.

**How to disable:**
If you prefer to disable telemetry collection, you can do so by setting the `XBOM_DISABLE_TELEMETRY` environment variable to `true`:

```bash
export XBOM_DISABLE_TELEMETRY=true
```
This will prevent xBom from sending any usage data.
