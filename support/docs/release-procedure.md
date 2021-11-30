# Release procedure and tagging

This document is a cheat sheet to be used as reference when releasing a new version of this project

All examples may contain placeholders you need to replace:

- `$(VERSION)` : The version string of the current release
- `$(FILENAME)` : The name of the implementation, currently `Makefile.semver`

## Close development branch

If you are working on a development branch, then first merge it into `master`.

The rest of the document assume you are working on the `master` branch.

## Update version

Remove any active development cycle from the `VERSION.data` file by running:

```bash
make version.release
```

The release version will be printed to the terminal. As mentioned above, this is the value you should use for the `$(VERSION)` placeholder.

## Edit `support/docs/auto-include.md`

Head to the last section named `## Downloading specific versions` and append a new snippet using this template:

````Markdown
### Release Version [$(VERSION)](https://github.com/malcos/makefile-semver/tree/$(VERSION))

[$(FILENAME)](https://github.com/malcos/makefile-semver/blob/$(VERSION)/$(FILENAME)):

```Makefile
_:=$(or $(wildcard $(FILENAME)), $(shell curl -sO https://raw.githubusercontent.com/malcos/makefile-semver/$(VERSION)/$(FILENAME)))
include $(FILENAME)
```
````

## Edit `README.md`

Update the version in the title of the document

```Markdown
# makefile-semver ($(VERSION))
```

And **replace** the auto include example for the new release in the `## Integration` section. Just copy the snippet you created in the previous step. Or create it again using the very same template:

````Markdown
### Release Version [$(VERSION)](https://github.com/malcos/makefile-semver/tree/$(VERSION))

[$(FILENAME)](https://github.com/malcos/makefile-semver/blob/$(VERSION)/$(FILENAME)):

```Makefile
_:=$(or $(wildcard $(FILENAME)), $(shell curl -sO https://raw.githubusercontent.com/malcos/makefile-semver/$(VERSION)/$(FILENAME)))
include $(FILENAME)
```
````

## Edit `CHANGELOG.md`

Add new section link at the very bottom

```Markdown
[$(VERSION)]: https://github.com/malcos/makefile-semver/tree/$(VERSION)
```

Rename the `Unreleased` to the current release version

```Markdown
## [Unreleased]
```

Should become

```Markdown
## [$(VERSION)]
```

Append a new `Unreleased` section at the top again, set `(empty)` as content.

```Markdown

## [Unreleased]

(empty)
```

## Publish

Create a commit with the version

```Bash
git add .
git commit -m "$(VERSION) release"
```

Tag the current commit

```Bash
git tag $(VERSION) master
```

And push the changes and immediately push the new tag

```Bash
git push
git push origin $(VERSION)
```

## Verify the links

- auto include examples in `README.md`
- auto include examples in `support/docs/auto-include.md`
- section link in `CHANGELOG.md`
