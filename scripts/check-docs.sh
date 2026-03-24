#!/usr/bin/env bash
set -euo pipefail

required_files=("README.md" "CHANGELOG.md")
for f in "${required_files[@]}"; do
  if [[ ! -f "$f" ]]; then
    echo "Missing required documentation file: $f"
    exit 1
  fi
done

if ! grep -q "## \[Unreleased\]" CHANGELOG.md; then
  echo "CHANGELOG.md must contain an '## [Unreleased]' section."
  exit 1
fi

if ! grep -q "## Quick start" README.md; then
  echo "README.md must contain a '## Quick start' section."
  exit 1
fi

echo "Documentation checks passed."
