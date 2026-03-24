#!/usr/bin/env bash
set -euo pipefail

# Pre-hook is designed for fast deterministic checks before tool actions.
bash scripts/check-docs.sh

echo "Pre-hook checks passed."
