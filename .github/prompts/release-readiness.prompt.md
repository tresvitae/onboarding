---
description: "Run a release-readiness sweep: changelog completeness, README freshness, workflow health, and risk summary."
---

# Release Readiness Sweep

Validate this repository before release.

## Checklist

1. Verify `CHANGELOG.md` has user-visible changes and release notes quality.
2. Verify `README.md` reflects current setup and commands.
3. Verify `.github/workflows/` pipelines are coherent and current.
4. Run `npm run check` and summarize results.
5. Produce a final go/no-go recommendation with risks.
