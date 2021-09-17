# makefile-semver

:: **Semantic Versioning (SemVer) implemented in GNU make** ::

![makefile-semver](logo.png "makefile-semver logo")

This is a pure GNU make implementation of the SemVer specification. It is intended to work on most operating systems without additional dependencies.

The best command line experience is achieved when auto completion support for `make` is enabled.

## Integration

Either paste the SemVer logic at the bottom of your own `Makefile`, or download the file from this repository and [include](https://www.gnu.org/software/make/manual/html_node/Include.html) it.

You can choose from two different implementations:

| Filename | Supported format | Example |
| :-- | :-- | :-- |
| `Make.semver-simple` | Basic numeric versions | `3.14.15` |
| `Make.semver-cycles` | With optional pre release cycle steps | `3.14.15-alpha.42` |

## Make.semver-simple

### Input variables (simple)

| Name | Default value | Description |
| :-- | :-- | :-- |
| `SEMVER_FILE` |  `SEMVER.data` | Filename used to store and retrieve the version data. The contents are in plain semantic versioning format |

### Output variables (simple)

| Name | Example | Description |
| :-- | :-- | :-- |
| `VERSION` | `3.14.15` | The full version string. Same as `$(VERSION_NUMBER)` |
| `VERSION_DATA` | `3.14.15` | The persistent version data as stored in `$(SEMVER_FILE)`. Same as `$(VERSION_NUMBER)` |
| `VERSION_NUMBER` | `3.14.15` | The numeric part of the version formatted as `MAJOR`.`MINOR`.`PATCH` |
| `VERSION_MAJOR` | `3` | The major version number from `$(VERSION)` |
| `VERSION_MINOR` | `14` | The minor version number from `$(VERSION)`
| `VERSION_PATCH` | `15` | The patch version number from `$(VERSION)` |

### Make Commands (simple)

| Name | Description |
| :-- | :-- |
| `version.init` | Idempotent and non-destructive action which will create the `$(SEMVER_FILE)`. If the file does not exists then it will be effectively initialized with the value `0.0.0`. The use of this method is **not** mandatory since `$(SEMVER_FILE)` will be automatically created when invoking any action that modifies the version. |
| `version.print` | Print `$(VERSION)` to the standard output. |
| `version.nextmajor` | Increment `$(VERSION_MAJOR)` by one and update `$(SEMVER_FILE)` |
| `version.nextminor` | Increment `$(VERSION_MINOR)` by one and update `$(SEMVER_FILE)` |
| `version.nextpatch` | Increment `$(VERSION_PATCH)` by one and update `$(SEMVER_FILE)` |
| `version.next` | Alias for  `version.nextpatch` |

## Make.semver-cycles

### Input variables (cycles)

| Name | Default value | Description |
| :-- | :-- | :-- |
| `SEMVER_FILE` |  `SEMVER.data` | Filename used to store and retrieve the version data. The contents are in plain semantic versioning format |
| `SEMVER_CYCLES` | `alpha beta rc`| The pre release cycle names to be supported under the `version.tocycle.*` target. Using dashes (`-`) and dots (`.`) in the names will cause problems |

### Output variables (cycles)

| Name | Example | Description |
| :-- | :-- | :-- |
| `VERSION` | `3.14.15-alpha.42` | The full version string. Same as `$(VERSION_DATA)` |
| `VERSION_DATA` | `3.14.15-alpha.42` | The persistent version data as stored in `$(SEMVER_FILE)`. Consisting of `$(VERSION-NUMBER)` and the optional `$(VERSION_CYCLE)` |
| `VERSION_NUMBER` | `3.14.15` | The numeric part of the version formatted as `MAJOR`.`MINOR`.`PATCH` |
| `VERSION_MAJOR` | `3` | The major version number from `$(VERSION)` |
| `VERSION_MINOR` | `14` | The minor version number from `$(VERSION)`
| `VERSION_PATCH` | `15` | The patch version number from `$(VERSION)` |
| `VERSION_CYCLE` | `alpha.42` | The version pre release cycle name and the stepping formatted as `CYCLE.STEP` |
| `VERSION_CYCLE_NAME` | `alpha` | The version pre release cycle name from `$(VERSION_CYCLE)` |
| `VERSION_CYCLE_STEP` | `42` | The numeric step from `$(VERSION_CYCLE)`. Notice that this value will always be set and it will default to 0 even if `$(VERSION_CYCLE_NAME)` is empty |

### Make Commands (cycles)

| Name | Description |
| :-- | :-- |
| `version.init` | Idempotent and non-destructive action which will create the `$(SEMVER_FILE)`. If the file does not exists then it will be effectively initialized with the value `0.0.0`. The use of this method is **not** mandatory since `$(SEMVER_FILE)` will be automatically created when invoking any action that modifies the version. |
| `version.print` | Print `$(VERSION)` to the standard output. |
| `version.nextmajor` | Increment `$(VERSION_MAJOR)` by one and update `$(SEMVER_FILE)` |
| `version.nextminor` | Increment `$(VERSION_MINOR)` by one and update `$(SEMVER_FILE)` |
| `version.nextpatch` | Increment `$(VERSION_PATCH)` by one and update `$(SEMVER_FILE)` |
| `version.next` | Alias for  `version.nextpatch` |
| `version.tocycle.${cycle}` | Set `${VERSION_CYCLE_NAME}` and update `$(SEMVER_FILE)`. The placeholder `${cycle}` is one of the names declared in `$(SEMVER_CYCLES)`. Selecting the same value as currently active will have no effect on  `$(VERSION_CYCLE_STEP)`, otherwise `$(VERSION_CYCLE_STEP)` will be reset to `0` |
| `version.nextcycle` | Increment `$(VERSION_CYCLE_STEP)` by one and update `$(SEMVER_FILE)` |
| `version.release` | Clear `$(VERSION_CYCLE_NAME)` by one and update `$(SEMVER_FILE)`, effectively removing the pre release cycle name and stepping from the version data |

## Limitations

All numeric values managed by the logic are limited to a range between `0` (zero) and `100000` (one hundred thousand). Which implies:

- Lowest possible numeric version: `0.0.0`
- Highest possible numeric version `100000.100000.100000`

## Branching

- branch `master`: latest stable (possibly unreleased) version
- branch `releases`: final release versions
- tags: will be created on branch `releases` and formatted as `MAJOR.MINOR.PATCH`

## Credits

The project logo at the top of this page uses the following assets:

- The Semver 2.0.0 logo from the [semver.org assets](https://github.com/semver/semver.org/tree/gh-pages/assets) repository page
- Alternative stylized GNU logo from [Wikimedia commons](https://commons.wikimedia.org/wiki/File:Logo_Gnu.svg) created by [Alvaro Ojeda](https://es.wikipedia.org/wiki/Usuario:Alvarojedab).
