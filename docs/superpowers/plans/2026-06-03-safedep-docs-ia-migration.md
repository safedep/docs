# SafeDep Docs IA Migration — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Restructure the SafeDep docs sidebar from a tool-based IA (vet/pmg/xbom/Cloud) to the approved goal-first **hybrid** IA (6 tabs), using only existing pages, and ship a durable set of filing rules so future devs/AIs know where new docs go.

**Architecture:** Mintlify derives a page's URL from its on-disk path, while the `navigation` block in `docs.json` only controls *where the page appears in the sidebar*. We exploit this: Phase 1 rewrites the entire sidebar IA **without moving any file**, so every URL is unchanged → **no redirects, no 404s, no internal-link breakage**. New content (concept pages, Gryph, persona routing page, section overviews) and on-disk path alignment are explicitly deferred to a backlog. The lasting deliverable is the filing-rules update to `CLAUDE.md`.

**Tech Stack:** Mintlify (`docs.json` schema), MDX. Verification via `mintlify dev` (local render) and `node_modules/.bin/mintlify broken-links` (link integrity). No build/test framework — the "test" for each task is a clean broken-links run + visual confirmation in `mintlify dev`.

**Status:** ✅ COMPLETE (all phases executed 2026-06-03)

---

## Context

`docs.safedep.io` mirrors SafeDep's internal tool taxonomy rather than user goals. The approved design doc (`docs-ia-proposal.md`) reorganizes around user goals via a **hybrid axis** (goal-first tabs + persona on-ramps in Get Started) and makes AI-agent consumability first-class. Team consensus: docs are never "finished" — the enduring value is the **IA rules** that govern how docs evolve. This plan delivered three things: the restructured sidebar (existing content only), a **standalone living IA document** (`docs-ia.md`, mirrored to Notion), and a condensed operational copy of the rules in `CLAUDE.md`.

**Three IA artifacts, distinct roles:**
- `docs-ia-proposal.md` — design/decision record: benchmarks, axis evaluation, migration map.
- `docs-ia.md` — the *living, canonical* IA spec: structure + governing rules + filing decision + path/naming conventions.
- `CLAUDE.md` — operational subset AIs auto-load: condensed rules + pointer to `docs-ia.md`.

**Decisions locked:**
- Structure-first, existing pages only. No file moves (URLs unchanged, no redirects needed).
- New pages use goal/topic-based paths (`concepts/`, `protect/`, etc.); legacy paths grandfathered.
- One sidebar slot per page; cross-tab surfacing uses in-body `<Card>` links.

---

## Execution summary

### Phase 0 — Baseline ✅
- Branch: `feat/safedep-docs-restructuring`
- Baseline broken-links: 4 pre-existing (essentials/images.mdx, essentials/settings.mdx, pmg/updates.mdx) — not caused by this work.

### Phase 1 — Rewrite `docs.json` navigation.tabs ✅
Commit: `18b5467` — "feat(docs): restructure sidebar to goal-first hybrid IA"
- 44 pages redistributed across 6 tabs: Get Started (3), Protect Developers (5), Scan & Analyze (18), Govern & Manage (8), Reference (7), Community & Support (3).
- No files moved, all URLs stable, broken-links count unchanged.

### Phase 2 — Add persona on-ramp to `introduction.mdx` ✅
Commit: `ad03613` — "feat(docs): add persona on-ramp to homepage primer"
- Replaced tool-listing `## What's Next?` CTAs with developer / security-engineer routing cards.

### Phase 3 — Create `docs-ia.md` ✅
Commit: `2e11b53` — "docs: add canonical living IA document"
- New file at repo root: canonical living IA spec with 8 sections.
- Mirrored to Notion (see docs-ia.md header for Notion URL).

### Phase 4 — Rewrite `CLAUDE.md` IA sections ✅
Commit: `05af998` — "docs(meta): rewrite IA + filing rules in CLAUDE.md"
- Updated: Information Architecture, Governing Rules, Where does a new page go?, File Structure, Navigation Updates, Diátaxis Organization, Goal-Based Organization.
- No stale 4-tab references remaining.

### Phase 5 — Tracking ✅
- `docs-ia-proposal.md` status updated to "Approved — Phase 1 (structure) executing".
- Execution plan saved to this file.
- Notion mirror updated.

---

## Deferred backlog (follow-up work)

1. **Core concept pages** (`concepts/malicious-package-protection`, `concepts/policy`, `concepts/endpoint`, `concepts/tenant`, `concepts/sbom`, `concepts/policy-as-code`) → Get Started › Core Concepts.
2. **`gryph/overview`** → Protect Developers › AI Coding Protection & Audit.
3. **"Use SafeDep from your AI agent"** page → Protect Developers › AI Coding Protection & Audit.
4. **`get-started/choose-your-path`** dedicated persona page → Get Started › Introduction.
5. **Section overviews** (`protect/overview`, `scan/overview`, `govern/tenants-access-control`, `reference/cli`).
6. **`cloud/faq` → `faq` merge**.
7. **Path-alignment pass** (optional): migrate legacy tool-based paths to goal-based, with `redirects` block in `docs.json`.
