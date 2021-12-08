# Changelog

This file mostly follows the recommendations by [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

Project [makefile-semver](https://github.com/malcos/makefile-semver) by [malcos](https://github.com/malcos)

## [Unreleased]

### Added

- `version.clearcycle` replaces `version.release` retaining its original implementation unchanged

### Changed

- `version.release` is now officially an alias to `version.clearcycle`

## [0.3.0] - 2021-12-07

### Changed

- `version.nextcycle` is now `version.nextcyclestep` making clear its intention
- Default initial value will include the first cycle. i.e. the first word in `$(VERSION_CYCLES)`

## [0.2.0] - 2021-11-30

### Added

- Documentation of release procedure for new versions

### Changed

- `Makefile.semver-complete` is now `Makefile.semver` and becomes the only offered implementation
- `$(SEMVER_FILE)` / `$(VERSION_FILE)` now defaults to `VERSION.data`, making it correlate with the variable `$(VERSION_DATA )`
- `$(SEMVER_FILE)` is now `$(VERSION_FILE)`
- `$(SEMVER_CYCLES)` is now `$(VERSION_CYCLES)`

### Removed

- `Makefile.semver-simple` is no more
- Goal `version.next` is now a planned feature for [0.3.2] and will change behavior

## [0.1.0] - 2021-10-01

### Added

- Unit tests written in native Makefile
- Guide for auto including the desired implementation
- The `$(SEMVER_FILE)` is now initialized and created transparently before first use

### Removed

- Target `version.init` removed since file are now created automatically

## [0.0.3] - 2021-09-21

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

[Unreleased]: https://github.com/malcos/makefile-semver/tree/master
[0.3.0]: https://github.com/malcos/makefile-semver/tree/0.3.0
[0.2.0]: https://github.com/malcos/makefile-semver/tree/0.2.0
[0.1.0]: https://github.com/malcos/makefile-semver/tree/0.1.0
[0.0.3]: https://github.com/malcos/makefile-semver/tree/0.0.3
[0.0.2]: https://github.com/malcos/makefile-semver/tree/0.0.2
[0.0.1]: https://github.com/malcos/makefile-semver/tree/0.0.1
