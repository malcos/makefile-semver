# Release procedure and tagging

This document is a small cheat sheet to be used as reference when releasing a new version of this project

Notice that when linking to the new version you will need to create links against a not yet existing tag. Use other existing links as reference.

## Update the documentation

- edit `VERSION.data`
  - remove the cycle information with `make version.release`
- edit `support/docs/auto-include.md`
  - append new version snippets after the latest one from `master`
- edit `README.md`
  - update the version in the title of the document
  - update the auto include snipplet to use the next tag
- edit `CHANGELOG.md`
  - add new section link at the very bottom
  - rename the `Unreleased` to the current release version
  - append a new `Unreleased` section, set `(empty)` text as content

## Publish

- create a release commit `releasing MAJOR.MINOR.PATCH` and push into `master`
- tag the latest commit with the version `MAJOR.MINOR.PATCH`

## Verify the links

- auto include examples in `README.md`
- auto include examples in `support/docs/auto-include.md`
- section link in `CHANGELOG.md`
