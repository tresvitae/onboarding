.PHONY: bootstrap check docs-check hooks-pre hooks-post cli-setup

bootstrap:
	npm run bootstrap

check:
	npm run check

docs-check:
	npm run docs:check

hooks-pre:
	npm run hooks:pre

hooks-post:
	npm run hooks:post

cli-setup:
	npm run cli:setup
