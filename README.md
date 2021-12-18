# makefile-semver (0.3.2-alpha.1)

:: **Semantic Versioning (SemVer) implemented in GNU make** ::

![makefile-semver](./support/assets/makefile-semver-logo.png "makefile-semver logo")

This is a pure [GNU make](https://www.gnu.org/software/make/manual/) implementation of the [SemVer specification](https://semver.org/). It is intended to work on most operating systems without additional dependencies.

For a better command line experience enable auto completion support for `make` in your favorite terminal shell.

## The implementation ([Makefile.semver](./Makefile.semver))

The file [Makefile.semver](./Makefile.semver) contains the main implementation supporting the three technical topics of the semver specification.

Numeric versions formatted as `MAJOR.MINOR.PATCH` (SemVer [#6](https://semver.org/#spec-item-6), [#7](https://semver.org/#spec-item-7) and [#8](https://semver.org/#spec-item-8)):

- `3.14.15`

Optional user-defined pre-release cycles using numeric steps (SemVer [#9](https://semver.org/#spec-item-9)):

- `3.14.15-rc.2`

 Optional arbitrarily user defined build metadata (SemVer [#10](https://semver.org/#spec-item-10)):

- `3.14.15+git:cf34d2a`
- `3.14.15-rc.2+git:cf34d2a`

## Integration

You have at least three options on how to integrate the logic of this project into your own `Makefile`:

- **Option 1 / Copy Paste**: Paste the contents of the file [Makefile.semver](./Makefile.semver) at the end of your own `Makefile`.

- **Option 2 / Download and include**: Download the file [Makefile.semver](./Makefile.semver) and [include](https://www.gnu.org/software/make/manual/html_node/Include.html) it from your `Makefile`

- **Option 3 / Automatic download and include**: This method requires an Internet connection and `curl` pre installed. Detailed information is available in the document: [Transparently including the SemVer implementation](./support/docs/auto-include.md).

### Release Version [0.3.1](https://github.com/malcos/makefile-semver/tree/0.3.1)

[Makefile.semver](https://github.com/malcos/makefile-semver/blob/0.3.1/Makefile.semver):

```Makefile
_:=$(or $(wildcard Makefile.semver), $(shell curl -sO https://raw.githubusercontent.com/malcos/makefile-semver/0.3.1/Makefile.semver))
include Makefile.semver
```

## Testing

The implementation got unit tests in place, which are in turn also written in pure `Makefile` format. To run the tests execute from the root folder of this project:

```shell
make runtests
```

## Configuration Variables

You can override the default values of the configuration variables at the beginning of your `Makefile`.

| Name | Default value | Description |
| :-- | :-- | :-- |
| `VERSION_FILE` | `VERSION.data` | Filename used to store and retrieve the version data. The contents are in plain semantic versioning format |
| `VERSION_CYCLES` | `alpha beta rc`| The pre release cycle names to be supported under the `version.tocycle.*` target. Using dashes (`-`) and dots (`.`) in the names will cause problems |
| `VERSION_METADATA` | | A user defined variable providing **volatile** and **non persistent** build metadata for inclusion in the version string. |

## Initialization

Once the semver logic is integrated into your makefile there is actually no need to perform any initialization. The file `$(VERSION_FILE)` will be automatically created when you call your makefile, even without a build target.

The default value stored into `$(VERSION_FILE)` will be the zero version, and if defined then the first element of `$(VERSION_CYCLES)` will become the current active cycle:

| Value of `$(VERSION_CYCLES)` | Initial version in `$(VERSION_FILE)` |
| :-- | :-- |
| (empty) | `0.0.0` |
| `alpha beta rc` | `0.0.0-alpha.1` |

## Output Variables

These variables are intended to be read and utilized by the user creating a `Makefile` (you).

| Name | example | Description |
| :-- | :-- | :-- |
| `VERSION` | `3.14.15-rc.2+git:cf34d2a` | The full and most complete version string as the implementation can provide. It is comprised of `$(VERSION_DATA)` and `$(VERSION_METADATA)` |
| `VERSION_DATA` | `3.14.15-rc.2` | The persistent version data as stored in `$(VERSION_FILE)`. It's the combination of `$(VERSION_NUMBER)` and the optional `$(VERSION_CYCLE)` |
| `VERSION_METADATA` | `git:cf34d2a` | See [Configuration Variables](#configuration-variables) |
| `VERSION_NUMBER` | `3.14.15` | The numeric part of the version formatted as `MAJOR`.`MINOR`.`PATCH` |
| `VERSION_MAJOR` | `3` | The major version number from `$(VERSION_NUMBER)` |
| `VERSION_MINOR` | `14` | The minor version number from `$(VERSION_NUMBER)`
| `VERSION_PATCH` | `15` | The patch version number from `$(VERSION_NUMBER)` |
| `VERSION_CYCLE` | `rc.2` | The version pre release cycle name and the stepping formatted as `CYCLE_NAME.STEP` |
| `VERSION_CYCLE_NAME` | `rc` | The version pre release cycle name from `$(VERSION_CYCLE)` |
| `VERSION_CYCLE_STEP` | `2` | The numeric step from `$(VERSION_CYCLE)`. Notice that this value will always be set and it will default to `1` even if `$(VERSION_CYCLE_NAME)` is empty |

## Make Targets: Base Actions

All targets with the exception of `version.print` will output `$(VERSION_DATA)` after modifying the version data.

| Name | Description |
| :-- | :-- |
| `version.print` | Print `$(VERSION)` to the standard output. |
| `version.nextmajor` | Increment `$(VERSION_MAJOR)` by one and update `$(VERSION_FILE)` |
| `version.nextminor` | Increment `$(VERSION_MINOR)` by one and update `$(VERSION_FILE)` |
| `version.nextpatch` | Increment `$(VERSION_PATCH)` by one and update `$(VERSION_FILE)` |
| `version.tocycle.*` | Set `${VERSION_CYCLE_NAME}` and update `$(VERSION_FILE)`. The placeholder `*` is one of the names declared in `$(VERSION_CYCLES)`. Selecting the same value as currently active will have no effect on `$(VERSION_CYCLE_STEP)`, otherwise `$(VERSION_CYCLE_STEP)` will be reset to `1` |
| `version.nextcyclestep` | Increment `$(VERSION_CYCLE_STEP)` by one and update `$(VERSION_FILE)` |
| `version.clearcycle` | Clear `$(VERSION_CYCLE_NAME)` and update `$(VERSION_FILE)`, effectively removing the pre release cycle name and stepping from the version data |

## Make Targets: Aliases

| Name | Description |
| :-- | :-- |
| `version.release` | Alias for `version.clearcycle` |
| `version.next` | If `$(VERSION_CYCLE_NAME)` is defined it will call `version.nextcyclestep`, otherwise `version.nextpatch` |

## Limitations

All numeric values managed by the logic are limited to a range between `0` (zero) and `100000` (one hundred thousand). Which implies:

- Lowest possible numeric version: `0.0.0`
- Highest possible numeric version `100000.100000.100000`

This affects the variables `$(VERSION_MAJOR)`, `$(VERSION_MINOR)`, `$(VERSION_PATCH)` and `$(VERSION_CYCLE_STEP)`.

## Other documents

- [Transparently including the SemVer implementation](./support/docs/auto-include.md).
- [The release procedure and tagging](./support/docs/release-procedure.md).
- [Change log for this project](./CHANGELOG.md)

## Credits

The project logo at the top of this page is a creation of mine and uses the following assets:

- The Semver 2.0.0 logo from the [semver.org assets](https://github.com/semver/semver.org/tree/gh-pages/assets) repository page
- Alternative stylized GNU logo from [Wikimedia commons](https://commons.wikimedia.org/wiki/File:Logo_Gnu.svg) created by [Alvaro Ojeda](https://es.wikipedia.org/wiki/Usuario:Alvarojedab).

## Contributing

This is a pet project. I'm not expecting contributions.

Feel free to open an issue to report bugs, propose enhancements or ask for new features. Or simply to say hello and have a chat.
