#!/usr/bin/env bash
# make-private.sh — Makes the SultanH3/Design repo private on GitHub.
# Run this once from any machine where you have a GitHub Personal Access Token.
#
# Usage:
#   GITHUB_TOKEN=your_token_here bash make-private.sh
#
# Get a token at: github.com/settings/tokens/new
# Required scope: repo (full control of private repositories)

set -euo pipefail

TOKEN="${GITHUB_TOKEN:-}"

if [[ -z "$TOKEN" ]]; then
  echo ""
  echo "ERROR: No GitHub token found."
  echo ""
  echo "  1. Go to: https://github.com/settings/tokens/new"
  echo "  2. Name it: 'Claude Admin'"
  echo "  3. Check the 'repo' scope box"
  echo "  4. Click 'Generate token' and copy it"
  echo "  5. Run: GITHUB_TOKEN=paste_token_here bash make-private.sh"
  echo ""
  exit 1
fi

echo "Making SultanH3/Design private..."

RESPONSE=$(curl -s -w "\n%{http_code}" -X PATCH \
  -H "Authorization: Bearer $TOKEN" \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/SultanH3/Design \
  -d '{"private": true}')

HTTP_CODE=$(echo "$RESPONSE" | tail -1)
BODY=$(echo "$RESPONSE" | head -1)

if [[ "$HTTP_CODE" == "200" ]]; then
  VISIBILITY=$(echo "$BODY" | python3 -c "import sys,json; print(json.load(sys.stdin).get('visibility','unknown'))")
  echo "SUCCESS. Repo is now: $VISIBILITY"
else
  echo "FAILED (HTTP $HTTP_CODE):"
  echo "$BODY" | python3 -m json.tool 2>/dev/null || echo "$BODY"
fi
