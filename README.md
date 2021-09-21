# makefile-semver (0.0.3)

:: **Semantic Versioning (SemVer) implemented in GNU make** ::

![makefile-semver](logo.png "makefile-semver logo")

This is a pure [GNU make](https://www.gnu.org/software/make/manual/) implementation of the [SemVer specification](https://semver.org/). It is intended to work on most operating systems without additional dependencies.

For a better command line experience enable auto completion support for `make` in your favorite terminal shell.

## Implementations

Two different implementation flavors are available

### [Makefile.semver-basic](./Makefile.semver-basic)

Basic implementation for numeric versions formatted as `MAJOR.MINOR.PATCH` (SemVer [#6](https://semver.org/#spec-item-6), [#7](https://semver.org/#spec-item-7) and [#8](https://semver.org/#spec-item-8)) with additional support for arbitrarily user defined build metadata (SemVer [#10](https://semver.org/#spec-item-10)). Examples:

- `3.14.15`
- `3.14.15+git:cf34d2a`

### [Makefile.semver-complete](Makefile.semver-complete)

Extends the functionality of `Makefile.semver-basic` with additional support for optional user-defined pre-release cycles using numeric steps (SemVer [#9](https://semver.org/#spec-item-9)). Examples:

- `3.14.15-alpha.42`
- `3.14.15-alpha.42+git:cf34d2a`

## Integration

Options:

- Paste the desired SemVer logic into your own `Makefile`
- Download one of the implementation files listed above and [include](https://www.gnu.org/software/make/manual/html_node/Include.html) it.

Optionally you can override and customize the values of the configuration variables at the beginning of your `Makefile`.

## Configuration Variables

| Name | Default value | Description |
| :-- | :-- | :-- |
| `SEMVER_FILE` |  `SEMVER.data` | Filename used to store and retrieve the version data. The contents are in plain semantic versioning format |
| `VERSION_METADATA` | | A user defined variable providing **volatile** and **non persistent** build metadata for inclusion in the version string. |

### Additional Configuration Variables For `Makefile.semver-complete`

| Name | Default value | Description |
| :-- | :-- | :-- |
| `SEMVER_CYCLES` | `alpha beta rc`| The pre release cycle names to be supported under the `version.tocycle.*` target. Using dashes (`-`) and dots (`.`) in the names will cause problems |

## Output Variables

These variables are intended to be read and utilized by the user creating a `Makefile` (you).

| Name | basic | complete | Description |
| :-- | :-- | :-- | :-- |
| `VERSION` | `3.14.15+git:cf34d2a` | `3.14.15-alpha.42+git:cf34d2a` | The full and most complete version string as implementation can provide. It is comprised of `$(VERSION_DATA)` and `$(VERSION_METADATA)`|
| `VERSION_DATA` | `3.14.15` | `3.14.15-alpha.42` | The persistent version data as stored in `$(SEMVER_FILE)`. It's combination of `$(VERSION_NUMBER)` and the optional `$(VERSION_CYCLE)`|
| `VERSION_METADATA` | `git:cf34d2a` | `git:cf34d2a` | See [Configuration Variables](#configuration-variables)|
| `VERSION_NUMBER` | `3.14.15`  | `3.14.15` | The numeric part of the version formatted as `MAJOR`.`MINOR`.`PATCH` |
| `VERSION_MAJOR` | `3` | `3` | The major version number from `$(VERSION_NUMBER)` |
| `VERSION_MINOR` | `14` | `14` | The minor version number from `$(VERSION_NUMBER)`
| `VERSION_PATCH` | `15` | `15` | The patch version number from `$(VERSION_NUMBER)` |
| `VERSION_CYCLE` | | `alpha.42` | The version pre release cycle name and the stepping formatted as `CYCLE.STEP` |
| `VERSION_CYCLE_NAME` | | `alpha` | The version pre release cycle name from `$(VERSION_CYCLE)` |
| `VERSION_CYCLE_STEP` | | `42` | The numeric step from `$(VERSION_CYCLE)`. Notice that this value will always be set and it will default to 1 even if `$(VERSION_CYCLE_NAME)` is empty |

## Make Targets

| Name | Description |
| :-- | :-- |
| `version.init` | Idempotent and non-destructive action which will create the `$(SEMVER_FILE)`. If the file does not exists then it will be effectively initialized with the value `0.0.0`. The use of this method is **not** mandatory since `$(SEMVER_FILE)` will be automatically created when invoking any action that modifies the version. |
| `version.print` | Print `$(VERSION)` to the standard output. |
| `version.nextmajor` | Increment `$(VERSION_MAJOR)` by one and update `$(SEMVER_FILE)` |
| `version.nextminor` | Increment `$(VERSION_MINOR)` by one and update `$(SEMVER_FILE)` |
| `version.nextpatch` | Increment `$(VERSION_PATCH)` by one and update `$(SEMVER_FILE)` |
| `version.next` | Alias for  `version.nextpatch` |

### Additional Make Targets For `Makefile.semver-complete`

| Name | Description |
| :-- | :-- |
| `version.tocycle.*` | Set `${VERSION_CYCLE_NAME}` and update `$(SEMVER_FILE)`. The placeholder `*` is one of the names declared in `$(SEMVER_CYCLES)`. Selecting the same value as currently active will have no effect on  `$(VERSION_CYCLE_STEP)`, otherwise `$(VERSION_CYCLE_STEP)` will be reset to `1` |
| `version.nextcycle` | Increment `$(VERSION_CYCLE_STEP)` by one and update `$(SEMVER_FILE)` |
| `version.release` | Clear `$(VERSION_CYCLE_NAME)` and update `$(SEMVER_FILE)`, effectively removing the pre release cycle name and stepping from the version data |

## Limitations

All numeric values managed by the logic are limited to a range between `0` (zero) and `100000` (one hundred thousand). Which implies:

- Lowest possible numeric version: `0.0.0`
- Highest possible numeric version `100000.100000.100000`

## Credits

The project logo at the top of this page uses the following assets:

- The Semver 2.0.0 logo from the [semver.org assets](https://github.com/semver/semver.org/tree/gh-pages/assets) repository page
- Alternative stylized GNU logo from [Wikimedia commons](https://commons.wikimedia.org/wiki/File:Logo_Gnu.svg) created by [Alvaro Ojeda](https://es.wikipedia.org/wiki/Usuario:Alvarojedab).
