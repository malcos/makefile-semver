# Changelog

This file mostly follows the recommendations by [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

Project [makefile-semver](https://github.com/malcos/makefile-semver) by [malcos](https://github.com/malcos)

## [Unreleased]

### Added

- Support for build metadata added to both implementations (issue #2)

### Changed

- Renamed implementation files to better reflect the implementations (basic / complete)
- Variable `VERSION_CYCLE_STEP` now starts counting from `1` instead of `0`

## [0.0.2] - 2021-09-19

### Added

- Support configurable release cycles suffixes (issue #1)
- Version debug output in separate file `Make.semver-debug`

### Changed

- Reduce the depth of target names, breaking compatibility with release `0.0.1`

### Fixed

- Output variables now show proper zero values even if the data file is empty or non existent

## [0.0.1] - 2021-09-05

### Added

- First version of documentation and experimental change log
- Example `Makefile` including the semantic versioning file
- First SemVer implementation supporting the simple format `MAJOR.MINOR.PATCH`

[Unreleased]: https://github.com/malcos/makefile-semver/tree/develop
[0.0.2]: https://github.com/malcos/makefile-semver/tree/0.0.2
[0.0.1]: https://github.com/malcos/makefile-semver/tree/0.0.1
