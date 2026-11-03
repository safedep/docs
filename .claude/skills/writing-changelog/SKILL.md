---
name: writing-changelog
description: Use when someone asks to write, update, backfill or review the SafeDep changelog (changelog/<year>.mdx), or asks "what did we ship", "write the changelog for October", "add the latest changelog entry" or "release notes for the last two weeks". The skill reads what shipped in the SafeDep Cloud repositories and the open source tool releases, keeps only user-facing changes, and adds one entry for each half month.
---

# Writing the SafeDep changelog

The changelog tells users what SafeDep shipped. It tells one platform story: the open source
tools are the core, and SafeDep Cloud runs them across a team. Write it for a person who uses
SafeDep, not for an engineer who reads the commit log.

Read `CLAUDE.md` first. Its writing rules (ASD-STE100, no em-dashes) apply to every line here.

## Scope

Two product lines. Every entry lists Open Source first, because it is the core.

| Product line | Section | Repository | Shipped when |
|---|---|---|---|
| Open Source | PMG | `safedep/pmg` | A stable GitHub release (not `-edge`) is published |
| Open Source | vet v2 | `safedep/vet`, branch `v2` | A `v2.0.0-alpha.*` (later beta or stable) release is published. v1 is out of scope |
| Open Source | Gryph | `safedep/gryph` | A GitHub release is published |
| SafeDep Cloud | Endpoint Hub, Threat Intel, Web app | `safedep/control-tower`, `safedep/app.safedep.io`, `safedep/malysis` | The pull request is merged into `main` |
| SafeDep Cloud | SafeDep CLI | `safedep/cli` | A GitHub release is published |

Rules for the scope:

- A tool is in scope only when it works with SafeDep Cloud now or will later. That keeps one
  platform story. Today that is vet v2, PMG and Gryph. xBom is out: vet v2 replaces it.
- The SafeDep CLI is open source, but it is the command line of SafeDep Cloud. It goes under
  SafeDep Cloud.
- Malysis and Malbase are internal names. Never write them. A Malysis change goes in only when a
  user sees it, as a detection or a Threat Intel Feed change, under "Threat Intel". Malbase is the
  internal review tool: its changes never go in.
- Merged work in an open source tool with no release waits for the period of its release.

## Pages

One page for each year: `changelog/2026.mdx`, `changelog/2027.mdx`. A year page has at most 24
entries, and an entry never moves to another page, so a link such as
`/changelog/2026#2026-10-31` stays valid. `/changelog` is a redirect in `docs.json` to the page of
the current year. The navbar links to `/changelog`.

The first entry of a new year starts a new page:

1. Create `changelog/<year>.mdx` with the frontmatter and intro of the previous year page. Change
   the year in `title`, `sidebarTitle` and `description`.
2. In `docs.json`, put `changelog/<year>` first in the pages of the Updates group, and change the
   destination of the `/changelog` redirect to `/changelog/<year>`.
3. At the end of the intro of the new page, link the previous year page.
4. Tell the user that the RSS feed of the new page is a new URL (`/changelog/<year>/rss.xml`).

## Cadence and labels

One entry for each calendar half month: the 1st to the 15th, and the 16th to the last day. The
`label` is the ISO date of the last day (`2026-10-15`, `2026-10-31`). The label is the anchor, so
never change it after you publish it. A period with no user-facing change gets no entry.

## Steps

1. **Find the period.** Read the newest `<Update label>` in the page of the current year. The next period is
   the half month after it. Stop if that period has not ended yet, unless the user asks for a
   partial entry. To backfill, do each period in order, oldest first.
2. **Collect.** Run `scripts/collect.sh SINCE UNTIL` from this skill folder. It prints the merged
   pull requests of the Cloud repositories and, for each release in the period, the commits since
   the release before it. Read the sources comment of the previous entry to confirm that nothing
   falls in a gap.
3. **Sort.** Drop each change that a user cannot see (see "Leave out"). Conventional commit types
   help: drop `ci`, `test`, `chore`, `refactor`, `deps`, `docs`, `docs(specs)` and `*(skills)`. vet
   uses `[FOU-123]` subjects with no type, so read the pull request for each.
4. **Check each change you keep.** Read the pull request body or the diff. Write what the user
   gets, not what the code does. Check every command, flag and config key against the source at
   the release tag. For a Cloud change that needs a tool change, find the first tool release that
   has it and add "Needs PMG v0.33.0 or later". Search the docs for a page to link.
5. **Ask the user.** Show one table for each period: every change you kept and every change you
   dropped that a reader could argue about, each with one reason. Ask about each change that is
   behind a feature flag, needs a plan or an add-on, is not announced, or names a data source or a
   customer. Do not write the entry before the user answers.
6. **Write.** Add the entry at the top of the year page, after the intro, with the template
   below. Newest entry first. Start a new year page when the entry is the first of a year.
7. **Verify.** Run `bunx -b mintlify broken-links` from the repository root, and
   `grep -n '—' changelog/*.mdx` (no output expected). Read the diff. Commit with the period in the
   subject, for example `docs(changelog): add October 16 to 31, 2026`.

## Entry template

```mdx
<Update label="2026-10-31" description="October 16 to 31, 2026" tags={["Open Source", "SafeDep Cloud", "PMG", "vet", "Threat Intel"]}>

{/* sources: pmg@v0.33.0 vet@v2.0.0-alpha.20261023182239 control-tower@8232a67 app.safedep.io@684e8bd malysis@656baf5 */}

## Open Source

### PMG [v0.33.0](https://github.com/safedep/pmg/releases/tag/v0.33.0)

- **New:** ...

## SafeDep Cloud

### Endpoint Hub

- **New:** ... Needs PMG v0.33.0 or later.

</Update>
```

- **Tags:** `Open Source` and `SafeDep Cloud` for each product line in the entry, then one tag for
  each section: `PMG`, `vet`, `Gryph`, `Endpoint Hub`, `Threat Intel`, `Web app`, `SafeDep CLI`.
  Use no other tags.
- **Sources comment:** the last tag or commit that the entry covers in each repository. The next
  run starts after it.
- **Section order:** PMG, vet v2, Gryph, then Endpoint Hub, Threat Intel, Web app, SafeDep CLI.
  Leave out a section with no change.
- **Section heading of a tool:** the tool and each release in the period. Each version links to
  its GitHub release, as `### PMG [v0.30.0](…), [v0.31.0](…)`. The link lets the entry leave out
  small changes. A release with only fixes still gets its heading. vet v2 alpha tags are
  timestamps, so write the date: `### vet v2 [alpha of October 23](…)`.

## Items

- **Twelve items or fewer in each entry.** Keep the items that change what a user can do: new
  capability, Breaking, Deprecated, and security fixes. Leave out small fixes and small
  improvements. The release link in the heading covers them. A Cloud change has no release notes,
  so keep a small Cloud change only when a user would ask about it.
- One line for each item. Start with **New**, **Improved**, **Fixed**, **Breaking** or
  **Deprecated**, in that order inside a section.
- Say what the user can do now, in present tense and active voice. Name the command, flag or page
  the user touches. Add a link to the docs page when one exists.
- A **Breaking** item says what stops working and the one step that fixes it.
- Merge an API pull request and a web app pull request of one feature into one item.
- A Cloud item that needs a plan or an add-on says so: "Needs the Threat Intel Feed add-on". Never
  write plan words in the Open Source section. Every open source feature is free.
- Do not explain why the change was made, do not thank anyone, do not add hype words.

| Do | Do not |
|---|---|
| **New:** `pmg sandbox profile propose` builds a network profile from the hosts that a run reached. | feat(sandbox): pmg sandbox profile propose builds the network block from a run (#555) |
| **Fixed:** A revoked invitation can no longer give access to a tenant. | Fixed a race condition in AcceptInvitation that bypassed the transaction. |
| **Improved:** Detection flags npm packages that hide a loader in a prebuilt native addon. | Malysis threat monitor now runs a YARA pass over bundled executables. |

## Leave out

Refactors, tests, CI, dependency and toolchain bumps, lint, logging, metrics, specs, internal
docs, agent skills, seed data and local development tools, Malbase, data migrations, and
performance work that a user cannot see. Leave out a fix for a bug that no release had. Keep a
security fix that a user can see or must act on.
