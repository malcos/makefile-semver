# makefile-semver

:: **Semantic Versioning (SemVer) implemented in GNU make** ::

![makefile-semver](logo.png "makefile-semver logo")

This is a pure GNU make implementation of the SemVer specification. It is intended work on most operating systems without additional dependencies.

## Integration

You can either paste the SemVer logic at the bottom of your own `Makefile`, or you may download the file from this repository and [include](https://www.gnu.org/software/make/manual/html_node/Include.html) it.

## Input variables

| Name | Default value | Description |
| :-- | :-- | :-- |
| `SEMVER_FILE` |  `SEMVER.data` | Filename where the implementation will store and retrieve version data top from. The contents are in plain semantic versioning format |

## Output variables

| Name | Example | Description |
| :-- | :-- | :-- |
| `VERSION` | `3.14.15` | The full version string as stored in `$(SEMVER_FILE)`, currently an alias to `$(VERSION_NUMBER)` |
| `VERSION_NUMBER` | `3.14.15` | The numeric part of the version, it should be in the format `MAJOR`.`MINOR`.`PATCH` |
| `VERSION_MAJOR` | `3` | The major version number from `$(VERSION)` |
| `VERSION_MINOR` | `14` | The minor version number from `$(VERSION)`
| `VERSION_PATCH` | `15` | The patch version number from `$(VERSION)` |

## Make Commands

| Name | Description |
| :-- | :-- |
| `version.setup` | Idempotent and non destructive action which will write the `$(SEMVER_FILE)` with all available data. If the file does not exists then it will be effectively initialized with the value `0.0.0`
| `version.print` | Print `$(VERSION)` to the standard output. |
| `version.increment.major` | Increment the `$(VERSION_MAJOR)` by one and stores the resulting version to  `$(SEMVER_FILE)` |
| `version.increment.minor` | Increment the `$(VERSION_MINOR)` by one and stores the resulting version to  `$(SEMVER_FILE)` |
| `version.increment.patch` | Increment the `$(VERSION_PATCH)` by one and stores the resulting version to  `$(SEMVER_FILE)` |
| `version.next` | placeholder for planned "smart function". The current implementation just aliases to  `version.increment.patch` |

## Limitations

Al numeric values managed by the logic are limited to a range between `0` (zero) and `100000` (one hundred thousand). Which implies:

- Lowest possible numeric version: `0.0.0`
- Highest possible numeric version `100000.100000.100000`

## Branching

- `develop` is the latest stable unreleased version
- `master` is used for release versions which are additionally tagged as such

## Credits

The project logo at the top of this page uses the following assets:

- The Semver 2.0.0 logo from the [semver.org assets](https://github.com/semver/semver.org/tree/gh-pages/assets) repository page
- Alternative stylized GNU logo from [Wikimedia commons](https://commons.wikimedia.org/wiki/File:Logo_Gnu.svg) created by [Alvaro Ojeda](https://es.wikipedia.org/wiki/Usuario:Alvarojedab).
