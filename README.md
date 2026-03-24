# Workflow OS for Projects

A reusable workspace that standardizes SDLC, automation, and AI-assisted development for both new and existing repositories.

## What this provides

- CI baseline with documentation quality gates
- Dedicated Copilot custom agents and prompts
- Pre and post hook scripts for deterministic checks
- SDLC templates for planning, release, and maintenance
- CLI-style commands through `npm run ...` and `make ...`

## Quick start

```bash
npm install
npm run bootstrap
npm run check
```

## Common commands

- `npm run bootstrap`: initialize local tooling and permissions
- `npm run check`: run full validation suite
- `npm run docs:check`: verify `README.md` and `CHANGELOG.md`
- `npm run hooks:pre`: run pre-hook checks
- `npm run hooks:post`: run post-hook checks
- `make check`: same as `npm run check`

## Project workflows

- CI workflow: `.github/workflows/ci.yml`
- Documentation guard: `.github/workflows/docs-guard.yml`
- Copilot policies: `.github/copilot-instructions.md`
- Dedicated agents: `.github/agents/*.agent.md`
- Hook definitions: `.github/hooks/*.json`

## Adopting in existing projects

1. Copy this scaffold into the existing repository root.
2. Update `scripts/check-docs.sh` with project-specific docs rules.
3. Extend `.github/copilot-instructions.md` with domain constraints.
4. Tune CI jobs in `.github/workflows/ci.yml` for stack-specific checks.
5. Add release notes into `CHANGELOG.md` for every shipped version.
