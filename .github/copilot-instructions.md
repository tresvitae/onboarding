# Copilot Instructions

## Primary objective

Operate this repository as a workflow baseline for any project, with strict documentation and SDLC hygiene.

## Always do

- Run `npm run docs:check` when modifying `README.md` or `CHANGELOG.md`.
- Keep `CHANGELOG.md` in Keep a Changelog style with an `[Unreleased]` section.
- Prefer minimal, deterministic script changes in `scripts/`.
- Keep CI workflows readable and explicit.

## Agent workflow

- Use `.github/agents/sdlc-orchestrator.agent.md` for project setup and release process tasks.
- Use `.github/agents/docs-guardian.agent.md` for documentation quality checks.
- Use `.github/prompts/release-readiness.prompt.md` before release tagging.

## Guardrails

- Do not remove docs checks from CI.
- Do not skip changelog updates for behavior changes.
- Keep hooks lightweight and deterministic.
