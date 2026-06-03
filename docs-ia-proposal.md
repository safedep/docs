# SafeDep Documentation — Information Architecture Proposal

> **Status:** Approved — Phase 1 (structure) executing · **Type:** Design doc (design-first) · **Tracking:** [safedep/docs#48](https://github.com/safedep/docs/issues/48) · **Living IA:** [`docs-ia.md`](./docs-ia.md) · **Execution plan:** [`docs/superpowers/plans/2026-06-03-safedep-docs-ia-migration.md`](./docs/superpowers/plans/2026-06-03-safedep-docs-ia-migration.md)
>
> Companion to the [SafeDep CLI Experience](https://www.notion.so/32861d70b23680baa6d6e62bd45c3dbc) doc. Like that doc, this establishes the **governing rules** and the **rationale** for the structure before any file is moved. No `docs.json` edits or content rewrites are part of this proposal — execution is a follow-up planned from here.

---

## 1. Problem statement

`docs.safedep.io` grew organically to mirror SafeDep's internal **tool taxonomy** (vet, pmg, xBom, Cloud, Endpoint Hub, MCP) rather than what a user is trying to **accomplish**. The result: tool-named top-level sections, three near-duplicate "Why / Quickstart" pairs, core concepts (Endpoint, Policy, Tenant, Malysis, Malbase) defined only inline, no single "What is SafeDep?" primer, a tool linked from the homepage that has zero docs (Gryph), and reference material interleaved with how-to. On top of the human-navigation problem, [issue #48](https://github.com/safedep/docs/issues/48) sets a second mandate: the docs must also **serve AI agents** today (via Mintlify markdown) and be the **foundation for a future SafeDep Agent Skill**.

This proposal reorganizes the docs around **user goals**, makes **concepts first-class**, and treats **AI-agent consumability as a design principle**, not an afterthought.

---

## 2. Governing rules

These rules decide how the docs are structured today and how they evolve. Every structural decision below is derived from them.

| # | Rule | Why |
|---|------|-----|
| **R1** | **One primary entry point.** A new visitor meets a "What is SafeDep?" primer and one explicit "start here" decision — not a tool catalog. | Today there is no primer; `introduction.mdx` mixes philosophy, architecture, and CTAs. New users have no on-ramp. |
| **R2** | **Two audiences, both at home.** The IA serves (a) the **developer** installing tools locally and (b) the **security engineer** managing dashboards and policy — without forcing either through the other's content. | These are distinct journeys with distinct vocabulary. The current nav assumes one undifferentiated reader. |
| **R3** | **Organize by goal, not by tool.** Top-level sections name *what the user wants to do*; tool-specific material lives one level deeper. *(Validated against benchmarks in §5 — not assumed.)* | "vet / pmg / xBom" as top-level forces users to know which tool solves their problem before they can navigate. |
| **R4** | **Concepts are first-class, atomic, and linkable.** Endpoint, Policy, Tenant, Malysis, Malbase, CEL, SBOM each get one dedicated page, linkable from anywhere, distinct from how-to. | These terms are load-bearing across the docs but defined only inline, inconsistently, or not at all. |
| **R5** | **Progressive disclosure.** The homepage and top level are opinionated and narrow; exhaustive reference (query syntax, API, policy DSL) is buried appropriately deep. | Reference currently sits beside conceptual content ("Advanced Usage" mixes both), flattening the hierarchy. |
| **R6** | **AI-agent consumability is first-class.** The docs are structured to be parsed by machines as well as read by humans: one concept per atomic page, predictable headings, stable URLs, a published `llms.txt` / `llms-full.txt`, and a content shape a future SafeDep Agent Skill can index. | Issue #48's explicit second mandate. Also a direct, proven pattern from the Talos benchmark (§3). |

> **The test for any new page:** *What goal does this serve, and for whom?* If the answer is "it documents tool X" rather than "it helps a developer/security-engineer do Y," it is filed in the wrong place.

---

## 3. Benchmark analysis

Four well-structured docs sites, each fetched live. The takeaway for each is a *decision*, not a description.

### Kubernetes — `kubernetes.io/docs`
Top level is pure **content-type / Diátaxis**: **Concepts · Tasks · Tutorials · Reference** (plus Getting Started, Contribute). The *same* topic recurs across types — a Pod is a Concept, a Task, and a Reference page — and the landing page routes by intent ("Understand / Try / Set up / Look up reference"). This works because Kubernetes is **one product with many facets**.
**Borrow:** the content-type discipline *within* a section, and the intent-based landing cards (R1, R5). **Don't borrow** the pure-content-type *top level* — SafeDep is several distinct tools, not one system, so a top-level "Concepts/Tasks/Reference" split would scatter each tool across four places.

### Stripe — `docs.stripe.com`
A deliberate **hybrid**: a **goal/task** top layer ("Accept payments", "Sell subscriptions", "Set up your dev environment") sits above a **"Browse by product"** layer (Payments, Billing, Issuing…). It is explicitly **not** role-based. API Reference is a **separate property**, not mixed into guides.
**Borrow:** goal-first-then-product is the exact shape SafeDep needs (R3), and isolating heavy reference from guides (R5). The fact that the canonical multi-product docs site **rejects role-based** top-level nav is strong evidence against a "For Developers / For Security Engineers" split.

### Vercel — `vercel.com/docs`
A multi-product platform that organizes its landing by **capability/goal** — "Build your applications", "Use Vercel's AI infrastructure", "Secure", "Deploy and scale", "Collaborate" — with individual products nested under each capability. **AI infrastructure is its own first-class group** (AI SDK, AI Gateway, MCP Servers, *Agent Resources*), and long-form learning lives in a separate Knowledge Base.
**Borrow:** capability/goal headings with tools nested underneath (R3), and **AI as a first-class top-level concern** — direct precedent for SafeDep elevating its AI-coding-protection and AI-governance stories rather than burying them under "vet/guides" (R6, R2).

### Talos Linux — `docs.siderolabs.com`
Opens with a **"What is Talos?"** primer, then a conceptual track (**Learn More**, which lists `Architecture, Components, Control Plane, Philosophy, KubeSpan, Controllers and Resources, AI Agent Integration`), goal/task operational sections (Getting Started, Platform-Specific Installations, Build and Extend, Deploy and Manage), and an isolated **Reference**. Most importantly, the docs **publish an `llms.txt` as the canonical documentation index** and — confirmed in that index — ship a dedicated **AI Agent Integration** page under Learn More.
**Borrow:** this is the template for R6 made concrete — a strong "What is X?" primer (R1), a clean concept/how-to/reference separation, **and** first-class AI-agent affordances (`llms.txt` + an AI-integration page). SafeDep should copy this pattern directly.

**Convergence:** the three *multi-product* benchmarks (Stripe, Vercel, Talos) all land on **goal/capability at the top, products nested beneath, reference isolated, a conceptual primer up front**. Only the *single-product* one (Kubernetes) uses a content-type top level. Two of the four (Vercel, Talos) already treat AI-agent material as first-class. This convergence directly drives the axis decision in §5.

---

## 4. Current-state audit

### 4.1 Current navigation (from `docs.json`)

Four tabs:

- **Welcome** → Get Started: `introduction`
- **Open Source** → groups: *Concepts* (`vet/concepts/why-vet`, `pmg/concepts/why-pmg`, `xbom/concepts/why-xbom`), *Quickstart* (`vet/quickstart`, `pmg/quickstart`, `xbom/quickstart`), *Integration Guides*, *SBOM & Analysis*, *AI Governance*, *API & Automation*, *Advanced Usage*, *Changelogs* (`pmg/updates`)
- **SafeDep Cloud** → groups: *Getting Started*, *Apps & Integrations*, *SCA*, *Endpoint Hub*, *Management*, *Reference*, *Support*
- **Community & Support** → `community`, `faq`

### 4.2 Inventory (44 in-nav pages + 8 orphaned)

| Path | Section (current) | Audience | Content type |
|------|-------------------|----------|--------------|
| `introduction` | Welcome | All | Landing (mixed) |
| `vet/concepts/why-vet` | OSS › Concepts | Sec Eng / DevOps | Concept |
| `vet/quickstart` | OSS › Quickstart | Developer / DevOps | Quickstart |
| `vet/guides/github-code-scanning` | OSS › Integration Guides | DevOps | How-to |
| `vet/guides/defect-dojo-integration` | OSS › Integration Guides | Sec Eng | How-to |
| `vet/guides/cyclonedx-sbom` | OSS › SBOM & Analysis | DevOps / Sec Eng | How-to |
| `vet/guides/dependency-inventory` | OSS › SBOM & Analysis | Sec Eng | How-to |
| `vet/guides/code-analysis` | OSS › SBOM & Analysis | Developer | How-to |
| `vet/guides/dependency-usage-identification` | OSS › SBOM & Analysis | Developer | How-to |
| `vet/guides/ai-governance` | OSS › AI Governance | Sec Eng | How-to / Concept |
| `vet/guides/shadow-ai-detection` | OSS › AI Governance | Sec Eng | How-to |
| `vet/guides/ai-tools-discovery` | OSS › AI Governance | Sec Eng | How-to |
| `vet/guides/insights-api-using-typescript` | OSS › API & Automation | Developer | How-to |
| `vet/guides/terraform-supply-chain-audit` | OSS › API & Automation | DevOps / Sec Eng | How-to |
| `vet/advanced/filtering` | OSS › Advanced Usage | Sec Eng | Reference |
| `vet/advanced/build-your-own-queries` | OSS › Advanced Usage | Sec Eng | How-to / Reference |
| `vet/advanced/policy-as-code` | OSS › Advanced Usage | Sec Eng | Reference / How-to |
| `vet/advanced/exceptions` | OSS › Advanced Usage | Sec Eng | How-to |
| `vet/advanced/path-exclusion` | OSS › Advanced Usage | Sec Eng | Reference |
| `pmg/concepts/why-pmg` | OSS › Concepts | All | Concept |
| `pmg/quickstart` | OSS › Quickstart | Developer | Quickstart |
| `pmg/updates` | OSS › Changelogs | Developer | Reference (changelog) |
| `xbom/concepts/why-xbom` | OSS › Concepts | Sec Eng / Compliance | Concept |
| `xbom/quickstart` | OSS › Quickstart | Developer / DevSecOps | Quickstart |
| `cloud/overview` | Cloud › Getting Started | All | Landing / Concept |
| `cloud/quickstart` | Cloud › Getting Started | DevOps / Sec Eng | Quickstart |
| `cloud/authentication` | Cloud › Reference | Developer / DevOps | Reference / How-to |
| `cloud/sync` | Cloud › SCA | DevOps | How-to |
| `cloud/malware-analysis` | Cloud › SCA | Sec Eng | Concept / How-to |
| `cloud/package-exclusions` | Cloud › Management | Sec Eng | How-to |
| `cloud/faq` | Cloud › Support | All | Reference (FAQ) |
| `cloud/endpoint-hub/overview` | Cloud › Endpoint Hub | Sec Eng / DevOps | Concept / How-to |
| `cloud/endpoint-hub/inventory` | Cloud › Endpoint Hub | Sec Eng | How-to |
| `cloud/endpoint-hub/package-guard` | Cloud › Endpoint Hub | DevOps / Sec Eng | How-to |
| `cloud/endpoint-hub/inventory-catalog` | Cloud › Endpoint Hub | Sec Eng | Reference |
| `apps/overview` | Cloud › Apps & Integrations | All | Landing |
| `apps/github/overview` | Cloud › Apps & Integrations | DevOps / Developer | How-to |
| `apps/gitlab/overview` | Cloud › Apps & Integrations | DevOps | How-to |
| `apps/bitbucket/bitbucket-pipes` | Cloud › Apps & Integrations | DevOps | How-to |
| `apps/mcp/overview` | Cloud › Apps & Integrations | Developer (AI) | How-to |
| `apps/jfrog/overview` | Cloud › Apps & Integrations | Enterprise / Sec Eng | How-to |
| `api-reference/introduction` | Cloud › Reference | Developer | Reference |
| `community` | Community & Support | All | Landing |
| `faq` | Community & Support | All | Reference (FAQ) |

**Orphaned (on disk, not in nav):** `development.mdx`, `essentials/{code,images,markdown,navigation,settings,reusable-snippets}.mdx`, `snippets/snippet-intro.mdx` — Mintlify template/scaffold files.

### 4.3 Structural problems

1. **Tool-named top level.** "Open Source" splits into per-tool `vet/pmg/xbom` trees; a user must already know which tool solves their problem. (Violates R3.)
2. **Triplicated entry pattern.** Three separate "Why X?" + "Quickstart" pairs, with no unifying "Why SafeDep?" or "which tool do I need?" primer. (Violates R1.)
3. **Concepts defined inline only.** Endpoint, Policy, Tenant, Malysis, Malbase, CEL, SBOM have no dedicated pages; definitions are scattered and inconsistent. (Violates R4.)
4. **Reference mixed with how-to.** "Advanced Usage" bundles reference (`filtering`, `path-exclusion`) with how-to (`exceptions`, `build-your-own-queries`). (Violates R5.)
5. **An undocumented tool is advertised.** `introduction.mdx` lists **Gryph** as a core OSS tool; it has zero pages.
6. **Audience is implicit.** Developer vs security-engineer journeys are interleaved with no signposting. (Violates R2.)
7. **Same feature, two homes.** `cloud/endpoint-hub/package-guard` is the cloud-sync side of pmg (a developer tool) but lives only under a security-engineer section.
8. **Integrations split across tabs.** GitHub *App* lives under Cloud › Apps; GitHub *Code Scanning* lives under OSS › Integration Guides — the same platform, two tabs.
9. **No AI-agent affordances.** No `llms.txt`, no atomic concept pages, no "use SafeDep from your AI agent" page — despite issue #48's mandate. (Violates R6.)

---

## 5. Choosing the organizing axis

The top-level **axis** is the highest-leverage decision. Four candidates, each as a concrete top-level nav, scored against the governing rules and the §3 evidence.

### Candidate A — Goal / use-case
```
Get Started · Protect Developers · Scan & Analyze · Govern & Manage · Threat Intelligence · Reference
```
Pro: directly satisfies R3; matches the mental model already in `introduction.mdx` (pmg = protect dev environment, vet = CI/CD protection). Con: a few items (xBom SBOM) can plausibly sit in two goals; needs clear filing rules.

### Candidate B — Role / persona
```
For Developers · For Security Engineers · For DevOps · Open Source Tools · Reference
```
Pro: maximal R2 signposting. Con: **the same content is needed by multiple roles**, forcing duplication or arbitrary assignment (where does "GitHub App" go?). Stripe — the canonical multi-product docs site — **explicitly rejects** role-based top-level nav. Fails R3/R5.

### Candidate C — Product / tool (status quo)
```
vet · pmg · xBom · gryph · SafeDep Cloud · Integrations
```
Pro: trivial to maintain; each team owns a tree. Con: this **is** today's structure and the source of every problem in §4.3. Forces tool-knowledge before navigation. Fails R1, R3.

### Candidate D — Hybrid: goal-first top level + persona routing on the landing
```
Get Started (with "I'm a developer / I'm a security engineer" routing)
Protect Developers · Scan & Analyze · Govern & Manage · Reference · Community
                         (tools nested one level deeper inside each goal)
```
Pro: goal-first top level (R3) **plus** explicit persona on-ramps in Get Started (R2), tools nested (R3), reference isolated (R5), concepts first-class in Get Started (R4), and an obvious home for AI affordances (R6). Mirrors the **Stripe + Vercel + Talos convergence** from §3.

### Decision

| Axis | R1 entry | R2 audiences | R3 goal-first | R5 reference isolation | Benchmark precedent |
|------|:--:|:--:|:--:|:--:|--|
| A — Goal | ✅ | ⚠️ implicit | ✅ | ✅ | Stripe (goal layer) |
| B — Role | ⚠️ | ✅ | ❌ | ⚠️ | **None** — Stripe rejects it |
| C — Product | ❌ | ❌ | ❌ | ❌ | None (this is the problem) |
| **D — Hybrid** | ✅ | ✅ | ✅ | ✅ | **Stripe + Vercel + Talos** |

> **Recommendation: Candidate D — goal-first top level with persona routing in "Get Started."** It is the only candidate that satisfies all six rules, and it is the structure the three multi-product benchmarks independently converged on. Role-based (B) is explicitly counter-indicated by Stripe; product-based (C) is the status quo we are replacing; pure goal (A) is D without the persona on-ramp, which we add to honor R2.

---

## 6. Proposed Information Architecture

Top level (Mintlify tabs):

```
Get Started · Protect Developers · Scan & Analyze · Govern & Manage · Reference · Community & Support
```

Proposed `docs.json` navigation shape (**illustrative, annotated structure** — `jsonc` with inline comments and `★ = new page` markers for review, not literal valid JSON; see §7):

```jsonc
"tabs": [
  {
    "tab": "Get Started",
    "groups": [
      { "group": "Introduction", "pages": [
        "introduction",                       // reworked into a true "What is SafeDep?" primer
        "get-started/choose-your-path"        // ★ persona routing: developer vs security engineer
      ]},
      { "group": "Quickstarts", "pages": [
        "get-started/protect-ai-coding",      // ★ 5-min: pmg + MCP (curated from pmg/quickstart + apps/mcp)
        "vet/quickstart",
        "cloud/quickstart"
      ]},
      { "group": "Core Concepts", "pages": [
        "concepts/malicious-package-protection", // ★ Malysis + Malbase, central
        "concepts/policy",                    // ★
        "concepts/endpoint",                  // ★
        "concepts/tenant",                    // ★
        "concepts/sbom",                      // ★
        "concepts/policy-as-code"             // concept half of vet/advanced/policy-as-code
      ]}
    ]
  },
  {
    "tab": "Protect Developers",
    "groups": [
      { "group": "Overview", "pages": [ "protect/overview" ] }, // ★
      { "group": "Package Manager Guard (pmg)", "pages": [
        "pmg/concepts/why-pmg", "pmg/quickstart", "pmg/updates"
      ]},
      { "group": "AI Coding Protection & Audit", "pages": [
        "apps/mcp/overview",
        "gryph/overview"                      // ★ Gryph — audit trail for AI coding agents
      ]},
      { "group": "Endpoint Sync", "pages": [
        "cloud/endpoint-hub/package-guard"    // canonical home; cross-linked from Govern & Manage
      ]}
    ]
  },
  {
    "tab": "Scan & Analyze",
    "groups": [
      { "group": "Overview", "pages": [ "scan/overview" ] }, // ★
      { "group": "Repository Scanning (vet)", "pages": [
        "vet/concepts/why-vet",
        "vet/guides/code-analysis",
        "vet/guides/dependency-inventory",
        "vet/guides/dependency-usage-identification"
      ]},
      { "group": "Bill of Materials (xBom)", "pages": [
        "xbom/concepts/why-xbom", "xbom/quickstart", "vet/guides/cyclonedx-sbom"
      ]},
      { "group": "AI Governance", "pages": [
        "vet/guides/ai-governance",
        "vet/guides/shadow-ai-detection",
        "vet/guides/ai-tools-discovery"
      ]},
      { "group": "CI/CD & Platform Integrations", "pages": [
        "apps/overview",
        "apps/github/overview", "vet/guides/github-code-scanning",
        "apps/gitlab/overview", "apps/bitbucket/bitbucket-pipes", "apps/jfrog/overview",
        "vet/guides/defect-dojo-integration",
        "vet/guides/terraform-supply-chain-audit"
      ]}
    ]
  },
  {
    "tab": "Govern & Manage",
    "groups": [
      { "group": "SafeDep Cloud", "pages": [
        "cloud/overview", "cloud/sync"
      ]},
      { "group": "Endpoint Hub", "pages": [
        "cloud/endpoint-hub/overview",
        "cloud/endpoint-hub/inventory",
        "cloud/endpoint-hub/inventory-catalog"
      ]},
      { "group": "Policy & Risk", "pages": [
        "cloud/malware-analysis",
        "cloud/package-exclusions"
      ]},
      { "group": "Access & Identity", "pages": [
        "cloud/authentication",
        "govern/tenants-access-control"       // ★
      ]}
    ]
  },
  {
    "tab": "Reference",
    "groups": [
      { "group": "vet Query & Policy", "pages": [
        "vet/advanced/filtering",
        "vet/advanced/build-your-own-queries",
        "vet/advanced/policy-as-code",        // reference half (CEL syntax, examples)
        "vet/advanced/exceptions",
        "vet/advanced/path-exclusion"
      ]},
      { "group": "API & Automation", "pages": [
        "api-reference/introduction",
        "vet/guides/insights-api-using-typescript"
      ]},
      { "group": "SafeDep CLI", "pages": [ "reference/cli" ] } // ★ placeholder; tracks CLI Experience doc
    ]
  },
  {
    "tab": "Community & Support",
    "groups": [
      { "group": "Community", "pages": [ "community" ] },
      { "group": "Support", "pages": [ "faq" ] }   // cloud/faq merged in
    ]
  }
]
```

### Per-section documentation

| Section | Purpose (1 line) | Primary audience | Content types | Moves here from |
|---------|------------------|------------------|---------------|-----------------|
| **Get Started** | Answer "what is SafeDep?", route by persona, define the vocabulary. | All | Primer, Quickstart, Concept | `introduction`, `vet/quickstart`, `cloud/quickstart`, concept halves of existing pages |
| **Protect Developers** | Block threats on the developer's machine and in AI coding tools. | Developer | Concept, Quickstart, How-to | `pmg/*`, `apps/mcp/overview`, `cloud/endpoint-hub/package-guard` |
| **Scan & Analyze** | Find supply-chain risk in code, dependencies, SBOMs, and CI/CD. | Developer / DevOps | Concept, How-to | `vet/concepts`, `vet/guides/*`, `xbom/*`, `apps/{github,gitlab,bitbucket,jfrog}` |
| **Govern & Manage** | Operate SafeDep Cloud: visibility, policy, access. | Security Engineer | Concept, How-to | `cloud/*`, `cloud/endpoint-hub/*` |
| **Reference** | Look up exact syntax, APIs, flags. | Sec Eng / Developer | Reference | `vet/advanced/*`, `api-reference/*`, `vet/guides/insights-api-using-typescript` |
| **Community & Support** | Get help, join the community. | All | Landing, FAQ | `community`, `faq`, `cloud/faq` |

### AI-agent consumability (R6) — concrete actions

- **Publish `llms.txt` + `llms-full.txt`.** Mintlify generates these automatically; ensure it is enabled and that the primer + concept pages are well-formed. Direct parallel to Talos's documentation index.
- **Atomic concept pages (R4) double as agent-ingestible units** — one concept, predictable headings, stable URL. This is the single biggest lever for both human linking and Agent-Skill grounding.
- **Add a "Use SafeDep from your AI agent" page** (under Protect Developers › AI Coding Protection & Audit) — mirrors Talos's "AI Agent Integration" page; documents the MCP server as the agent entry point and links the future SafeDep Agent Skill.
- **Stable URLs + redirects.** Every move in §7 must ship a redirect so existing links (and any agent that has already indexed them) don't break.

---

## 7. Migration map

Action key: **Move** · **Move+rename** · **Split** · **Merge** · **Delete** · **New**.

| Current path | Proposed location | Action |
|--------------|-------------------|--------|
| `introduction` | Get Started › Introduction › "What is SafeDep?" | Move+rename (rework into primer; trim CTAs) |
| `vet/quickstart` | Get Started › Quickstarts | Move |
| `cloud/quickstart` | Get Started › Quickstarts | Move |
| `pmg/quickstart` | Protect Developers › pmg (+ feeds ★ `protect-ai-coding`) | Move |
| `vet/concepts/why-vet` | Scan & Analyze › Repository Scanning | Move |
| `pmg/concepts/why-pmg` | Protect Developers › pmg | Move |
| `xbom/concepts/why-xbom` | Scan & Analyze › Bill of Materials | Move |
| `xbom/quickstart` | Scan & Analyze › Bill of Materials | Move |
| `pmg/updates` | Protect Developers › pmg | Move |
| `vet/guides/code-analysis` | Scan & Analyze › Repository Scanning | Move |
| `vet/guides/dependency-inventory` | Scan & Analyze › Repository Scanning | Move |
| `vet/guides/dependency-usage-identification` | Scan & Analyze › Repository Scanning | Move |
| `vet/guides/cyclonedx-sbom` | Scan & Analyze › Bill of Materials | Move |
| `vet/guides/ai-governance` | Scan & Analyze › AI Governance | Move |
| `vet/guides/shadow-ai-detection` | Scan & Analyze › AI Governance | Move |
| `vet/guides/ai-tools-discovery` | Scan & Analyze › AI Governance | Move |
| `apps/overview` | Scan & Analyze › CI/CD & Platform Integrations | Move |
| `apps/github/overview` | Scan & Analyze › CI/CD & Platform Integrations | Move |
| `vet/guides/github-code-scanning` | Scan & Analyze › CI/CD & Platform Integrations | Move (co-locate with GitHub App) |
| `apps/gitlab/overview` | Scan & Analyze › CI/CD & Platform Integrations | Move |
| `apps/bitbucket/bitbucket-pipes` | Scan & Analyze › CI/CD & Platform Integrations | Move |
| `apps/jfrog/overview` | Scan & Analyze › CI/CD & Platform Integrations | Move |
| `vet/guides/defect-dojo-integration` | Scan & Analyze › CI/CD & Platform Integrations | Move |
| `vet/guides/terraform-supply-chain-audit` | Scan & Analyze › CI/CD & Platform Integrations | Move |
| `apps/mcp/overview` | Protect Developers › AI Coding Protection & Audit | Move |
| `cloud/endpoint-hub/package-guard` | Protect Developers › Endpoint Sync (canonical); cross-link from Govern | Move |
| `cloud/overview` | Govern & Manage › SafeDep Cloud | Move |
| `cloud/sync` | Govern & Manage › SafeDep Cloud | Move |
| `cloud/endpoint-hub/overview` | Govern & Manage › Endpoint Hub | Move |
| `cloud/endpoint-hub/inventory` | Govern & Manage › Endpoint Hub | Move |
| `cloud/endpoint-hub/inventory-catalog` | Govern & Manage › Endpoint Hub | Move |
| `cloud/malware-analysis` | Govern & Manage › Policy & Risk (concept → ★ `concepts/malicious-package-protection`) | Split |
| `cloud/package-exclusions` | Govern & Manage › Policy & Risk | Move |
| `cloud/authentication` | Govern & Manage › Access & Identity | Move |
| `vet/advanced/filtering` | Reference › vet Query & Policy | Move |
| `vet/advanced/build-your-own-queries` | Reference › vet Query & Policy | Move |
| `vet/advanced/policy-as-code` | Split: concept → Get Started › Core Concepts; syntax → Reference | Split |
| `vet/advanced/exceptions` | Reference › vet Query & Policy | Move |
| `vet/advanced/path-exclusion` | Reference › vet Query & Policy | Move |
| `api-reference/introduction` | Reference › API & Automation | Move |
| `vet/guides/insights-api-using-typescript` | Reference › API & Automation | Move |
| `community` | Community & Support › Community | Keep |
| `faq` | Community & Support › Support | Keep |
| `cloud/faq` | Community & Support › Support | Merge into `faq` |
| `essentials/*`, `development`, `snippets/snippet-intro` | — | Delete from repo or move to `/docs-internal` (not user docs) |

### Gaps flagged `New` (noted, not written here)

| New page | Section | Why it must exist |
|----------|---------|-------------------|
| `get-started/choose-your-path` | Get Started | R1/R2 persona on-ramp; the missing "start here" decision |
| `get-started/protect-ai-coding` | Get Started › Quickstarts | The Bob-persona 5-min path (pmg + MCP) from the CLI Experience doc |
| `concepts/malicious-package-protection` | Core Concepts | Central definition of **Malysis** + **Malbase** (today: inline only) |
| `concepts/policy` | Core Concepts | R4 — "Policy" used everywhere, defined nowhere central |
| `concepts/endpoint` | Core Concepts | R4 — "Endpoint" defined only inside Endpoint Hub |
| `concepts/tenant` | Core Concepts | R4 — multi-tenancy assumed, never explained |
| `concepts/sbom` | Core Concepts | R4 — anchors xBom + CycloneDX content |
| `concepts/policy-as-code` | Core Concepts | Concept half split out of `vet/advanced/policy-as-code` |
| `gryph/overview` | Protect Developers › AI Coding Protection & Audit | Advertised on the homepage with **zero** docs. *Note: Gryph is an audit/observability tool, not a blocking/protection one (per the CLI Experience doc, "hooks is about observability"). The group is named "Protection & Audit" to hold both honestly; if the audit story grows, Gryph may warrant its own goal section.* |
| *Use SafeDep from your AI agent* | Protect Developers › AI Coding Protection & Audit | R6 — Talos-style AI-integration page |
| `govern/tenants-access-control` | Govern & Manage › Access & Identity | R4/R2 — tenant + RBAC operations |
| `protect/overview`, `scan/overview` | section landings | Goal-section on-ramps |
| `reference/cli` | Reference › SafeDep CLI | Tracks the CLI Experience doc; placeholder until CLI ships |
| `llms.txt` / `llms-full.txt` | site root | R6 — agent-ingestible documentation index (Mintlify auto-gen) |

---

## 8. What this proposal deliberately does **not** do

- It does not rewrite page content — only relocates and flags gaps.
- It does not invent content for Gryph or the concept pages — those are `New` gaps for a follow-up.
- It does not change the Mintlify platform or theme.
- It does not pick the CLI's auth/command details — that lives in the CLI Experience doc; this only reserves a Reference home for it.

## 9. Suggested execution order (follow-up, not this task)

1. Land the **concept pages** (R4) — highest leverage, unblocks linking and R6.
2. Restructure `docs.json` to the §6 tabs + add **redirects** for every §7 move.
3. Write the **persona routing** + reworked primer (R1/R2).
4. Fill remaining `New` gaps (Gryph, AI-agent page, tenants).
5. Enable/verify **`llms.txt`** and the AI-agent page (R6).
