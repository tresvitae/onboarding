#!/usr/bin/env bash
set -euo pipefail

# Post-hook is designed for lightweight sanity checks after tool actions.
if [[ -f README.md && -f CHANGELOG.md ]]; then
  echo "Post-hook documentation presence check passed."
else
  echo "Post-hook failed: docs are missing."
  exit 1
fi
