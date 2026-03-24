# SDLC Baseline

## Stages

1. Plan: define scope, acceptance criteria, and risks.
2. Build: implement changes with tests and docs updates.
3. Validate: run `npm run check` and CI checks.
4. Release: update changelog and publish with release notes.
5. Operate: monitor, fix regressions, and track follow-up work.

## Quality gates

- Documentation updated for user-facing changes
- Changelog updated for shipped behavior
- CI passing on pull request and default branch
- Hooks passing locally
