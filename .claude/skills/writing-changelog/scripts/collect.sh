#!/usr/bin/env bash
# Lists what each in-scope repository shipped in one changelog period.
#
# Usage: collect.sh SINCE UNTIL
#   SINCE and UNTIL are dates in YYYY-MM-DD form. Both days are included.
#
# Needs: gh (signed in with read access to the safedep repositories) and jq.
#
# The script prints raw material only. It does not decide what is user-facing.
# The skill (SKILL.md) owns that decision.

set -euo pipefail

if [[ $# -ne 2 ]]; then
  echo "usage: collect.sh SINCE UNTIL (YYYY-MM-DD YYYY-MM-DD)" >&2
  exit 2
fi

since="$1"
until="$2"
owner="safedep"
from="${since}T00:00:00Z"
to="${until}T23:59:59Z"

# SafeDep Cloud: a pull request merged into the default branch is shipped.
cloud_repos=(control-tower app.safedep.io malysis)

# Released tools: a published release is shipped.
# Format: repo:channel. Channel "stable" takes releases that are not
# pre-releases. Channel "v2-alpha" takes the vet v2 alpha pre-releases.
released_repos=(cli:stable vet:v2-alpha pmg:stable gryph:stable)

echo "# Changelog sources from ${since} to ${until}"
echo

echo "## SafeDep Cloud: merged pull requests"
for repo in "${cloud_repos[@]}"; do
  echo
  echo "### ${repo}"
  base="$(gh repo view "${owner}/${repo}" --json defaultBranchRef --jq .defaultBranchRef.name)"
  gh pr list --repo "${owner}/${repo}" --base "${base}" --state merged \
    --search "merged:${since}..${until}" --limit 300 \
    --json number,title,mergedAt,labels \
    --jq 'sort_by(.mergedAt) | .[] | "- #\(.number) \(.mergedAt[0:10]) \(.title)\(if (.labels | length) > 0 then " [" + ([.labels[].name] | join(", ")) + "]" else "" end)"'
  echo "- last commit on ${base} in the period: $(gh api "repos/${owner}/${repo}/commits?sha=${base}&until=${to}&per_page=1" --jq '.[0].sha[0:7]')"
done

echo
echo "## Released tools: releases in the period"
for entry in "${released_repos[@]}"; do
  repo="${entry%%:*}"
  channel="${entry#*:}"
  echo
  echo "### ${repo} (${channel})"

  case "${channel}" in
    stable) filter='map(select(.isPrerelease | not))' ;;
    v2-alpha) filter='map(select(.isPrerelease and (.tagName | startswith("v2."))))' ;;
    *) echo "unknown channel ${channel}" >&2; exit 2 ;;
  esac

  # Oldest first, so each release compares with the one before it.
  releases="$(gh release list --repo "${owner}/${repo}" --limit 200 \
    --json tagName,publishedAt,isPrerelease --jq "${filter} | sort_by(.publishedAt)")"

  in_period="$(jq -r --arg from "${from}" --arg to "${to}" \
    '.[] | select(.publishedAt >= $from and .publishedAt <= $to) | .tagName' <<<"${releases}")"

  if [[ -z "${in_period}" ]]; then
    echo "- no release in the period"
    continue
  fi

  while read -r tag; do
    prev="$(jq -r --arg tag "${tag}" \
      '(map(.tagName) | index($tag)) as $i | if $i > 0 then .[$i - 1].tagName else "" end' <<<"${releases}")"
    published="$(jq -r --arg tag "${tag}" '.[] | select(.tagName == $tag) | .publishedAt[0:10]' <<<"${releases}")"
    echo
    echo "#### ${tag} (${published}), https://github.com/${owner}/${repo}/releases/tag/${tag}"
    if [[ -z "${prev}" ]]; then
      echo "- first release of this channel: read the release notes and the README"
      continue
    fi
    echo "- changes since ${prev}:"
    gh api "repos/${owner}/${repo}/compare/${prev}...${tag}" \
      --jq '.commits[] | "  - \(.sha[0:7]) \(.commit.message | split("\n")[0])"'
  done <<<"${in_period}"
done
