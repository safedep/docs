# SafeDep Product Map (stable facts only)

> **Purpose:** Per-product card with only the facts that almost never change — name, one-line purpose, public repo (where applicable), docs home, key concepts. Anything mutable (CLI flags, feature lists, supported package managers, version-specific behavior) is **not** here — read the product's `README.md` / `AGENTS.md` on demand.
>
> **If a fact below contradicts the product's current README, the README wins.** Open a PR against this file.

---

## vet

- **One-liner (from README):** Real-time malicious package detection and software supply chain security.
- **What it is:** A CLI scanner for open-source dependencies. Detects malicious packages, generates risk reports, runs CEL-based queries and policies, produces SBOMs.
- **Public repo:** `github.com/safedep/vet`
- **Docs home:** **Visibility & Governance › Repository Scanning (vet)**. Also: Bill of Materials (xBom lives inside vet at `pkg/xbom`), CI/CD & Platform Integrations (vet-action), Reference (vet Query & Policy).
- **Key concepts surfaced:** CEL (filtering / queries / policy), Malysis (intelligence backend), Policy-as-Code, SBOM (CycloneDX).
- **Where to read up-to-date facts:** `README.md`, `docs/` in the vet repo; `cmd/` for command surface; `scan.go` / `query.go` for top-level behavior.
- **vet-action note:** Lives under the vet repo (`.github/actions/`) and as `safedep/vet-action`. Split per use-case: blocking → Package Security; scanning/SBOM → Visibility & Governance.

---

## pmg (Package Manager Guard)

- **One-liner (from README):** Block malicious npm and pip packages before they install. Defense in depth for the package managers you already use.
- **What it is:** A wrapper / proxy around `npm` and `pip` (and similar) that intercepts installs and blocks known-malicious packages at the dev machine, before code touches disk.
- **Public repo:** `github.com/safedep/pmg`
- **Docs home:** **Package Security › Package Manager Guard (pmg)**. R8 landing page lives here.
- **Key concepts surfaced:** Malysis (intelligence used to decide block/allow), Package Manager interception, Truststore.
- **Where to read up-to-date facts:** `README.md`, `CLAUDE.md`, `AGENTS.md` in the pmg repo; `cmd/` for command surface; `packagemanager/` and `extractor/` for what's supported.
- **Note:** `pmg` and `vet-action` together are the two halves of Package Security — local-machine vs CI/CD. Both block malicious packages; they differ only in *where*.

---

## gryph

- **One-liner (from README):** Security layer for AI coding agents. AI coding agents have no security boundaries — Gryph is building one.
- **What it is:** A runtime sandbox / proxy that intercepts what an AI coding agent (Cursor, Claude Code, etc.) actually does — file access, shell commands, network — and lets you observe and gate it.
- **Public repo:** `github.com/safedep/gryph`
- **Docs home:** **AI Agent Security**. R8 landing page (`ai-security/gryph-overview`) is in the backlog.
- **Key concepts surfaced:** AI agent observability, AI coding protection, runtime policy. Different from MCP (Gryph wraps the agent at runtime; MCP exposes SafeDep tools *to* the agent).
- **Where to read up-to-date facts:** `README.md`, `CLAUDE.md`, `AGENTS.md` in the gryph repo; `cli/` and `cmd/` for surface; `agent/` for supported agents.

---

## SafeDep MCP server

- **One-liner:** A Model Context Protocol (MCP) server that exposes SafeDep's package-intelligence and vet capabilities to AI coding tools (Claude Code, Cursor, etc.) so the agent can ask "is this package safe?" before suggesting `npm install`.
- **What it is:** Not a separate repo — lives inside the vet repo at `mcp/`.
- **Docs home:** **AI Agent Security › AI Coding Protection (MCP)**.
- **Where to read up-to-date facts:** `mcp/` in the vet repo.
- **Distinction:** MCP = give SafeDep *to* the AI tool. Gryph = put a fence *around* the AI tool. Different products, both under AI Agent Security, never conflate them.

---

## xBom

- **One-liner:** SBOM (Software Bill of Materials) generation, including CycloneDX output.
- **What it is:** A sub-tool inside `vet` — not a standalone repo. Generates CycloneDX SBOMs from scanned dependency graphs.
- **Source location:** `pkg/xbom/` inside the vet repo. (The `xbom/` directory in this docs repo is a grandfathered legacy path.)
- **Docs home:** **Visibility & Governance › Bill of Materials**.
- **Key concepts surfaced:** SBOM, CycloneDX, dependency inventory.
- **Where to read up-to-date facts:** `pkg/xbom/` and `cmd/` in the vet repo (look for sbom/xbom subcommands).

---

## SafeDep Cloud / Endpoint Hub

- **One-liner:** SafeDep Cloud is the hosted control and management plane — policy, multi-repo / multi-machine visibility, org governance.
- **What it is:** A closed-source hosted offering. It surfaces in the docs as user-facing features: **SafeDep Cloud, Endpoint Hub, Endpoint Sync, Malware Analysis, Policy & Risk, Tenants & Access.**
- **Public repos:** none — the implementation is internal. Document the user-facing surface only (UI flows, API endpoints exposed to users, concepts).
- **Docs home:** **Visibility & Governance** — across the SafeDep Cloud, Endpoint Hub, Policy & Risk, and Access & Identity groups. R2 reminder: Cloud features get a simple `<Note>` callout, **not** a separate persona/tier tab.
- **Where to read up-to-date facts:** the live product (`app.safedep.io`), the public API reference under `api-reference/` in this docs repo, and any user-facing release notes. Do not document internal services, internal repo names, or non-public endpoints.
- **Public API surface — `buf.build/safedep/api`:** the canonical, public definition of everything you can do with/to SafeDep Cloud. Use it as the source of truth for API capabilities, request/response schemas, and service names:
  - API docs: `https://buf.build/safedep/api/docs` (e.g. `main:safedep.services.insights.v2`)
  - Generated SDKs (all supported languages): `https://buf.build/safedep/api/sdks`
  - When writing API/automation pages, link schemas to buf.build rather than restating them (R6) — the existing pattern is `vet/guides/insights-api-using-typescript.mdx`.
- **What lives in the user docs vs the product:** the docs site covers concepts, how-tos, and screens-level workflows. Exhaustive API/SDK reference belongs in the product's own reference (R6).

---

## Malysis (the intelligence layer — never a product tab)

- **One-liner:** SafeDep's threat intelligence layer — the malware detection / signal pipeline that powers vet, pmg, MCP, etc.
- **Status:** internal infrastructure; not directly user-facing.
- **Docs home: NONE as a tab or group.** R4 is explicit: Malysis is the intelligence *underneath* the products; it is never a product tab. It appears as:
  - A **concept page** under Get Started › Core Concepts (planned).
  - The signal source mentioned in product overviews (e.g. "pmg uses Malysis to decide block/allow").
- **Why this matters:** treating Malysis as a product tab is the textbook R3/R4 violation. If you find yourself writing "Malysis › setup" or "Malysis › API," stop — that content belongs under the specific product that uses it.

---

## Reading order when starting work on a product

When asked to write or revise docs for a product, read in this order:

1. **This `products.md` card** — find the tab and stable facts.
2. **The product's `README.md`** (in its public repo) — current capabilities, supported package managers, etc.
3. **The product's `CLAUDE.md` / `AGENTS.md`** (if present) — internal conventions.
4. **The relevant section of `docs-ia.md` §7** — what pages already exist in this product's group.
5. **The existing pages** at those paths — match voice and depth.

Never write product behavior from memory — package managers supported, CLI flags, default config locations, and version-specific behavior all drift between product releases.
