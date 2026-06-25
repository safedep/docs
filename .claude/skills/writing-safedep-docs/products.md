# SafeDep Product Map (stable facts only)

> **Purpose:** Per-product card with only the facts that almost never change — name, one-line purpose, public repo (where applicable), docs home, key concepts. Anything mutable (CLI flags, feature lists, supported package managers, version-specific behavior) is **not** here — read the product's `README.md` / `AGENTS.md` on demand.
>
> **If a fact below contradicts the product's current README, the README wins.** Open a PR against this file.

---

## vet

- **One-liner (from README):** Real-time malicious package detection and software supply chain security.
- **What it is:** A CLI scanner for open-source dependencies. Detects malicious packages, generates risk reports, runs CEL-based queries and policies, produces SBOMs.
- **Public repo:** `github.com/safedep/vet`
- **Docs home:** **Visibility & Governance › Repository Scanning** (`governance/vet/`). vet also powers CI/CD & Platform Integrations (vet-action) and the Reference tab (Query & Policy: `reference/filtering`, `policy-as-code`, `sql-query`). Note: the standalone **xBom** product is a separate repo (`github.com/safedep/xbom`), not part of vet.
- **Key concepts surfaced:** CEL (filtering / queries / policy), Malysis (intelligence backend), Policy-as-Code, SBOM (CycloneDX).
- **Where to read up-to-date facts:** `README.md`, `docs/` in the vet repo; `cmd/` for command surface; `scan.go` / `query.go` for top-level behavior.
- **vet-action note:** Lives under the vet repo (`.github/actions/`) and as `safedep/vet-action`. Split per use-case: blocking → Package Security; scanning/SBOM → Visibility & Governance.

---

## pmg (Package Manager Guard)

- **One-liner (from README):** Block malicious npm and pip packages before they install. Defense in depth for the package managers you already use.
- **What it is:** A wrapper / proxy around `npm` and `pip` (and similar) that intercepts installs and blocks known-malicious packages at the dev machine, before code touches disk.
- **Public repo:** `github.com/safedep/pmg`
- **Docs home:** **Package Security › Install-Time Package Blocking** (`package-security/pmg/`). R8 landing at `package-security/pmg/overview`.
- **Key concepts surfaced:** Malysis (intelligence used to decide block/allow), Package Manager interception, Truststore.
- **Where to read up-to-date facts:** `README.md`, `CLAUDE.md`, `AGENTS.md` in the pmg repo; `cmd/` for command surface; `packagemanager/` and `extractor/` for what's supported.
- **Note:** `pmg` and `vet-action` together are the two halves of Package Security — local-machine vs CI/CD. Both block malicious packages; they differ only in *where*.

---

## gryph

- **One-liner (from repo description):** Security layer for AI coding agents. Works with Claude Code, Cursor, Windsurf, Gemini CLI, OpenCode, Pi Agent and more.
- **What it is:** An **observability / audit** layer for AI coding agents. It *records* what an agent reads, writes, and runs into a **local** audit log. It does **not** block, sandbox, or enforce. Do **not** describe it as a "sandbox", "fence", "guardrail", or anything implying enforcement (the fleet review caught exactly this overstatement). Commands: `gryph logs` (recent activity), `gryph query` (filter the log), `gryph sessions` (list sessions). There is no "replay" feature.
- **Public repo:** `github.com/safedep/gryph`
- **Docs home:** **AI Agent Security › AI Agent Observability**. R8 landing page is live at `ai-security/gryph-overview`.
- **Key concepts surfaced:** AI agent observability, local audit trail. Different from MCP (Gryph *observes* the agent at runtime; MCP exposes SafeDep tools *to* the agent).
- **Where to read up-to-date facts:** `README.md`, `CLAUDE.md`, `AGENTS.md` in the gryph repo; `cli/` and `cmd/` for surface; `agent/` for supported agents.

---

## SafeDep MCP server

- **One-liner:** A Model Context Protocol (MCP) server that exposes SafeDep's package-intelligence and vet capabilities to AI coding tools (Claude Code, Cursor, etc.) so the agent can ask "is this package safe?" before suggesting `npm install`.
- **What it is:** Not a separate repo — lives inside the vet repo at `mcp/`.
- **Docs home:** **AI Agent Security › AI Coding Protection** (`ai-security/mcp-server`). Hosted endpoint: `mcp.safedep.io`. The `safedep` CLI configures it via `safedep setup mcp install`.
- **Where to read up-to-date facts:** `mcp/` in the vet repo; `safedep-cli` for the `setup mcp` flow.
- **Distinction:** MCP = give SafeDep *to* the AI tool (the agent can ask "is this package safe?"). Gryph = *observe and record* what the AI tool does. Different products, both under AI Agent Security, never conflate them.

---

## xBom

- **One-liner (repo tagline):** Generate xBOMs enriched with AI, SaaS, Crypto and more using static code analysis. **Caveat:** the tagline is aspirational. The shipped tool is **AI-BOM focused** (AI SDKs + some SaaS/cloud); crypto is not delivered. Do not advertise crypto as a current capability (the fleet review caught this over-claim). Verify the current language/component coverage against the xbom README before writing.
- **What it is:** A standalone CLI that generates a Bill of Materials (CycloneDX) from static code analysis, covering not just declared packages but AI and SaaS usage found in source. Separate from vet's own SBOM output (`governance/cyclonedx-sbom`); don't conflate the two.
- **Public repo:** `github.com/safedep/xbom`. Installs via `brew install safedep/tap/xbom` or a pre-built binary; **no npm package**.
- **Docs home:** **Visibility & Governance › Bill of Materials** (`governance/xbom/`).
- **Key concepts surfaced:** SBOM / xBOM, CycloneDX, dependency inventory.
- **Where to read up-to-date facts:** `README.md` in the xbom repo.

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
- **Docs home: NONE as a tab or group.** R4 is explicit: the Malysis *pipeline* is the intelligence *underneath* the products; it is never a product tab. It appears as:
  - The user-facing detection story in the concept page `concepts/malicious-package` (the names "Malysis" and "Malbase" are internal and stay out of user docs). Note: "malicious package *protection*" is a solution (the Package Security tab), not a concept; the concept page is `concepts/malicious-package` (the malicious package itself) alongside `concepts/vulnerability`.
  - The signal source mentioned in product overviews (e.g. "pmg checks packages against SafeDep's malicious-package intelligence").
- **Why this matters:** treating the Malysis pipeline as a product tab is the textbook R3/R4 violation. If you find yourself writing "Malysis › setup" or "Malysis › API," stop — that content belongs under the specific product that uses it.
- **Planned exception — Threat Intelligence productization:** a user-facing TI *product* is expected to ship and gets its own fourth solution tab (scope and rules: `docs-ia.md` §8). The R4 distinction holds — the pipeline never gets a tab; the productized offering does. Until that product ships, nothing changes.

---

## Reading order when starting work on a product

When asked to write or revise docs for a product, read in this order:

1. **This `products.md` card** — find the tab and stable facts.
2. **The product's `README.md`** (in its public repo) — current capabilities, supported package managers, etc.
3. **The product's `CLAUDE.md` / `AGENTS.md`** (if present) — internal conventions.
4. **The relevant section of `docs-ia.md` §7** — what pages already exist in this product's group.
5. **The existing pages** at those paths — match voice and depth.

Never write product behavior from memory. Package managers supported, CLI flags, default config locations, and version-specific behavior all drift between product releases.

---

## Verified facts & gotchas

> These are the traps a docs-correctness review surfaced. They can drift, so re-confirm against source when in doubt, but these were the known-correct values as of the IA migration. Each one was a real bug in the docs before it was fixed.

**Where the source lives** (sibling checkouts under `../`, next to this docs repo): `vet`, `pmg`, `safedep-cli`, `control-tower`, `xbom`, `homebrew-tap`. `vet-action` is usually **not** checked out locally; infer its inputs from how the product repos invoke it, or read the action repo on GitHub.

**Hosts (verified):**
- `app.safedep.io`: web console. API keys at `app.safedep.io/settings/api-keys`.
- `api.safedep.io`: data plane (API key auth).
- `cloud.safedep.io`: control plane (JWT / OAuth).
- `auth.safedep.io`: identity (OAuth2 / OIDC).
- `community-api.safedep.io`: keyless community API (pmg uses this).
- `mcp.safedep.io`: hosted MCP server.
- GONE: `platform.safedep.io` (retired, never present it as live). Does not exist: `community.safedep.io`.

**vet CLI traps:**
- Lockfiles/manifests: `--lockfiles` (`-L`, plural) and `--manifests` (`-M`). There is no singular `--lockfile`.
- Policy on `vet scan`: `--filter` / `--filter-suite` are DEPRECATED in favor of `--policy` / `--policy-suite`. But the v2 `--policy` engine uses a **different CEL schema and suite YAML** than v1, so you cannot blindly rename existing `--filter` examples; the expressions and YAML differ. `vet query --filter` is a different command and is **not** deprecated. `--filter-fail` is not deprecated.
- Debug: `--debug` / `-d`. There is no `--log-level`.
- Auth: `vet auth` has only `configure` and `verify` (no `logout`). Credentials live at `~/.safedep/vet-auth.yml` (delete that file to log out). `vet cloud` has `login`, `whoami`, `ping`, `quickstart`, `query`.
- SBOM: `--report-cdx` and `--report-cdx-app-name` exist; there is no `--report-cdx-app-version`.
- `--exclude` uses doublestar **glob** (`**/test/**`, `**/*.md`), not regular expressions.

**Cloud SQL query:** the canonical CLI is `safedep query exec --sql` (the `safedep` CLI, v2, JOIN-based; schema catalog at `control-tower/services/query/v2/catalog/catalog.go`, which documents tables, columns, indexed-anchor rules, and join edges). The older `vet cloud query execute` is v1 with a flat schema; prefer `safedep query`. `safedep query` authenticates non-interactively via `SAFEDEP_API_KEY` + `SAFEDEP_TENANT_ID` env vars, or `safedep auth login [--api-key --api-key-value <key>]`. `--api-key` is a boolean flag; the key value goes in `--api-key-value`. Bare `safedep auth login` runs an OAuth device flow and ignores the env vars.

**pmg:** free community API, no account or API key. Supported managers: `npm`, `pnpm`, `yarn`, `bun`, `npx`, `pnpx`, `pip`, `uv`, `poetry`. After `pmg setup install`, `which npm` resolves to the shim `~/.pmg/bin/npm` (not "pmg"). Config at `config.yml`. Proxy mode currently covers the JS managers only.

**vet-action inputs (real):** `policy`, `exception-file`, `cloud`, `cloud-key`, `cloud-tenant`, `enable-comments-proxy`, `trusted-registries`. There is no `scan-dir`, `report-cdx`, `app-name`, or `lockfile-as` input. To generate a CycloneDX SBOM in CI, run vet directly (e.g. `docker run --rm -v "$PWD:/app" ghcr.io/safedep/vet:latest scan -D /app --report-cdx ...`), not vet-action.

**Homebrew:** `vet`, `pmg`, `gryph`, `xbom` are formulae (`brew install safedep/tap/<tool>`). The unified `safedep` CLI is a **Cask**: `brew install --cask safedep/tap/cli`. Tap formulae are generated at release time and may not appear in the `homebrew-tap` repo tree, so trust each tool's README over the tap checkout.

**CI secret naming (standardized across docs):** secret/variable names are `SAFEDEP_CLOUD_API_KEY` and `SAFEDEP_CLOUD_TENANT_DOMAIN`; the env vars the tools actually read are `SAFEDEP_API_KEY` and `SAFEDEP_TENANT_ID`.

**Editorial invariants:** no em-dashes anywhere in published pages; one Diátaxis mode per page (keep "Benefits / Why / Best Practices" explanation and advice out of how-tos); `broken-links` does not catch wrong commands, bad anchors, or dropped content (verify those by hand).
