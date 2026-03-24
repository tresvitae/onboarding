#!/usr/bin/env bash
set -euo pipefail

if ! command -v node >/dev/null 2>&1; then
  echo "Node.js is required. Install Node.js 20+ and rerun."
  exit 1
fi

if ! command -v npm >/dev/null 2>&1; then
  echo "npm is required. Install npm and rerun."
  exit 1
fi

echo "CLI prerequisites satisfied."
node --version
npm --version
