# Changelog

This file mostly follows the recommendations by [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

Project [makefile-semver](https://github.com/malcos/makefile-semver) by [malcos](https://github.com/malcos)

## [Unreleased]

- Support configurable release cycles suffixes (issue #1)
- Fix output variables to show proper zero values even if the data file is empty or non existent
- Reduce the depth of target names

## [0.0.1] - 2021-09-05

### Added

- First version of documentation and experimental change log
- Example `Makefile` including the semantic versioning file
- First SemVer implementation supporting the simple format `MAJOR.MINOR.PATCH`

[Unreleased]: https://github.com/malcos/makefile-semver/tree/develop
[0.0.1]: https://github.com/malcos/makefile-semver/tree/0.0.1
