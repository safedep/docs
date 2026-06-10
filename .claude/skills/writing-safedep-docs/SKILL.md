---
name: writing-safedep-docs
description: Use when writing, reviewing, refactoring, or planning a page in the SafeDep documentation site (safedep-docs repo), or when adding docs for a SafeDep product (vet, pmg, gryph, Cloud / Endpoint Hub, MCP, xBom). Triggers on phrases like "add a docs page for…", "document this feature", "where should this page go", "review this doc", and any edit under safedep-docs/.
---

# Writing SafeDep Docs

## Overview

The SafeDep docs are governed by a fixed set of rules — solution-shaped navigation, Diátaxis-pure pages, one home per page, persona-blind structure. This skill is the **entry point** for any docs work: it tells you which canonical doc to read for which decision, summarizes the non-negotiable rules, and maps each SafeDep product to its docs home.

**Canonical sources (read these — don't paraphrase from memory):**
- `docs-ia.md` — full IA, governing rules R1–R9, page map, backlog. **Single source of truth.**
- `CLAUDE.md` — condensed operational copy auto-loaded into the repo's Claude sessions.
- `products.md` (in this skill) — one-paragraph card per product: source repo, docs home, stable concepts.

If `docs-ia.md` and this skill disagree, **`docs-ia.md` wins** — and the skill is stale; fix it.

## The non-negotiable rules (verbatim from R1–R9)

You may not work around these without updating `docs-ia.md` first.

| # | Rule | What it forbids |
|---|------|-----------------|
| R1 | One primary entry point | A landing page that just lists tools instead of explaining SafeDep |
| R2 | Capability ladder, not persona gate | Splitting nav by "individual / team / org" or "free / paid" |
| R3 | Organize by solution, not by tool | A new tab named after a product (e.g. "vet", "pmg") |
| R4 | Concepts are first-class, atomic, linkable | Re-defining CEL / Policy / SBOM inside a guide |
| R5 | Progressive disclosure | Splitting a tab because it has many pages (groups handle that) |
| R6 | docs.safedep.io is the guide layer | Adding exhaustive CLI flag tables here (those live in product repos) |
| R7 | AI-agent consumability is first-class | Mixing two concepts on one page; unstable URLs |
| R8 | Every product has a landing page | Linking straight to a setup step without an overview |
| R9 | Personas inform voice and priority, not structure | A persona router, "choose your role" page, or job-title nav split |

**Test for any new page:** *What security outcome does this serve?* If the answer is "it documents tool X" rather than "it helps someone achieve Y," the page is in the wrong place.

## Where does a new page go?

**Always consult the placement table in `docs-ia.md` §3.** Summary:

| If the page… | Tab |
|---|---|
| Defines a concept used across docs | Get Started › Core Concepts |
| Onboards a new user | Get Started › Introduction / Quickstarts |
| Covers malicious package blocking (local OR CI/CD) | Package Security |
| Covers AI agent discovery, audit, or control | AI Agent Security |
| Covers scanning repos / SBOMs / CI/CD for risk | Visibility & Governance |
| Covers cloud policy, endpoint inventory, org access | Visibility & Governance |
| Is pure lookup (syntax, flags, API specs) | Reference |
| Is community/support | Community & Support |

**One page = one sidebar slot.** To surface a page from a second tab, add an in-body `<Card>` — never a second nav entry.

**vet-action / GitHub Actions split:** a page about *blocking malicious packages in CI/CD* goes in **Package Security**. A page about *scanning repos / generating SBOMs / enforcing policy in CI/CD* goes in **Visibility & Governance**. Write one page per outcome, not one combined page.

## Pick the Diátaxis mode — one per page

| Mode | Style | Where it lives |
|---|---|---|
| **Tutorial** | Learning-oriented, hands-on, safe to fail | Get Started › Quickstarts |
| **How-to** | Problem-oriented, goal-phrased ("Find dependencies with X") | The relevant solution tab |
| **Reference** | Comprehensive, dry, minimal explanation | Reference tab only |
| **Explanation** | Conceptual "what / why / how it works" | Get Started › Core Concepts |

**Never mix modes on one page.** The most common violation: a Reference page that grows How-to recipes, or a How-to that grows a long Explanation preamble. Split it. The pilot in `concepts/cel.mdx` + `scan/filtering-recipes.mdx` + `vet/advanced/filtering.mdx` is the template.

## File path convention

| Path prefix | Tab |
|---|---|
| `get-started/` | Get Started |
| `concepts/` | Get Started › Core Concepts |
| `package-security/` | Package Security |
| `ai-security/` | AI Agent Security |
| `governance/` | Visibility & Governance |
| `reference/` | Reference |

Legacy paths (`vet/`, `pmg/`, `xbom/`, `cloud/`, `apps/`, `scan/`) are **grandfathered** — don't move files without a `redirects` entry in `docs.json`. New pages use the solution-aligned prefixes above.

## Page voice — who is this page written for?

R9 forbids persona structure but *requires* persona-aware voice:

- A **tutorial** assumes a beginner — explain vocabulary, hand-hold, no jargon.
- A **how-to** assumes a competent user with a goal — skip prereqs, get to the recipe.
- A **reference** assumes a working practitioner — be terse and complete.
- An **explanation** assumes curiosity — connect ideas, give the "why."

Pitch each page at one assumed reader. Never write "if you're a developer, do X; if you're a security engineer, do Y" — that's persona structure smuggling itself into the page body.

## Product map (the stable facts)

See `products.md` in this skill for: per-product one-liner, source repo path, docs home, key concepts, where to fetch up-to-date CLI/API details.

**Quick map:**
- **vet** — repository scanning + filtering / queries → Visibility & Governance
- **pmg** — install-time malicious package blocking → Package Security
- **gryph** — AI coding agent runtime sandbox → AI Agent Security
- **xBom** — SBOM generation (lives inside vet) → Visibility & Governance › Bill of Materials
- **MCP** — SafeDep MCP server for AI coding tools → AI Agent Security › AI Coding Protection
- **vet-action** — GitHub Action; split by use-case (blocking → Package Security; scanning → Visibility & Governance)
- **SafeDep Cloud / Endpoint Hub** — hosted control plane (closed-source) → Visibility & Governance. Public API surface: [`buf.build/safedep/api`](https://buf.build/safedep/api) — canonical schemas + generated SDKs; link to it, don't restate it (R6)
- **Malysis** — intelligence layer; **never a product tab or sidebar group** (R4)

## Workflow: writing a new page

1. **Identify the security outcome.** Apply the R3 test ("What security outcome does this serve?"). If the answer is tool-shaped, reframe.
2. **Pick the Diátaxis mode.** One per page.
3. **Look up tab + group + path prefix** in the placement table above (and verify against `docs-ia.md` §3–§4).
4. **Check the page map (`docs-ia.md` §7)** to see what already exists in that group — don't duplicate.
5. **Check `products.md` and the product's repo README** for up-to-date facts. Don't paraphrase from memory; CLI flags and feature lists drift.
6. **Write the page** in the right voice for the mode. Add frontmatter (`title`, `description` < 160 chars). No H1 — Mintlify renders the title.
7. **Update `docs.json`** under the correct tab/group.
8. **Verify:** `node_modules/.bin/mintlify broken-links` from the repo root must not add new failures.
9. **If you added a concept page**, also update `docs-ia.md` §7 and the Notion mirror.

## Workflow: reviewing / refactoring an existing page

1. **Classify it.** Which Diátaxis modes are present in the body? Use the rubric in `docs-ia-content-audit.md`.
2. **Decide: keep / trim-in-place / split / merge / move-tab.** The audit doc has the prioritized worklist.
3. **If splitting:** the pilot pattern is `vet/advanced/filtering.mdx` → kept Reference at original URL + new `scan/filtering-recipes.mdx` (how-to) + new `concepts/cel.mdx` (explanation). Preserve the original URL of the dominant mode to avoid redirects.
4. **No content loss check.** Map every H2/H3 of the original page to one of: kept / moved-to-X / intentionally-deleted. Write that map into the commit message.

## Workflow: adding docs for a new product / feature area

1. **R8 first:** the product needs a landing page. Decide its docs home from the product map.
2. **R3 sanity:** does this product create a new security outcome the current tabs don't cover? Almost always **no** — file it under the matching solution tab. A new tab is a `docs-ia.md` change, not a page-add.
3. **Concepts come first.** If the product introduces a new term used across the docs, write the concept page under `concepts/` *before* the how-tos.
4. **Update `docs-ia.md` §7 page map** (add new pages under the right group).
5. **Update `products.md` in this skill** if the product map shifts (stable facts only — name, source repo, tab, one-line purpose).

## Common mistakes

| Mistake | Why it's wrong | Fix |
|---|---|---|
| New tab named after a tool ("vet docs", "pmg docs") | Violates R3 | File under the matching solution tab |
| "Choose your path" / "I'm a developer / security engineer" router | Violates R9 (marketing pattern) | Use concrete use-case cards, not roles |
| One page documents Tutorial + How-to + Reference | Violates Diátaxis | Split per the filtering pilot |
| Repeating CEL syntax in three guides | Violates R4 | One canonical page in `concepts/`; others link |
| Long CLI flag table on docs.safedep.io | Violates R6 | Lives in the product repo's README/manual |
| Adding a page to two sidebar groups | One slot per page | Pick the primary home; cross-surface with `<Card>` |
| Paraphrasing vet/pmg flags from memory | Drifts from product reality | Read the product's README; cite the version |
| Skipping the product landing page | Violates R8 | Write the overview before linking setup steps |

## Red flags — STOP and re-read `docs-ia.md`

- You're about to add a new tab.
- You're about to write "if you're an X, do Y; if you're a Z, do W."
- You're about to duplicate a concept across two guides.
- You're about to put a comprehensive flag reference on docs.safedep.io.
- You're about to add a page under two groups in `docs.json`.
- You're about to copy CLI behavior from training data instead of reading the product README.

All of these mean: pause, re-read the relevant rule, reconsider.

## When the skill itself is wrong

`docs-ia.md` is canonical. If you find a conflict between this skill and `docs-ia.md`, the skill is stale. Update the skill **in the same change** that you act on `docs-ia.md` — never let them diverge.
