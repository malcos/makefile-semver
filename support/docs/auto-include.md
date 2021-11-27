# Transparently including the SemVer implementation

It is possible to automatically download and import the desired `makefile-server` implementation into your `Makefile`. This also implies that the file can be `.gitignore`d.

Beware that using this technique may render your `Makefile` non portable to other platforms depending on the availability of the used command for downloading files.

## Basic Template

The idea is to automatically and transparently download a copy of the implementation file only if it's not yet present in the local file system. Without the need of additional commands or actions from the side of the user.

```makefile
_:=$(or $(wildcard $(THE_FILE)), $(shell $(FETCH_FILE_COMMAND)))
include $(THE_FILE)
```

## Well Known Download Tools

The `$(FETCH_FILE_COMMAND)` can be anything able to download a file over HTTP/HTTPS, two of the most popular commands being `curl` and `wget`

```Bash
# curl example with silent download
curl -sO {URL}

# wget example with quiet download
wget -q {URL}
```

This document will use `curl` since it is a common tool found under Linux, Darwin and Windows 10.

## Downloading specific versions

It is recommended to put these lines at the very end of your `Makefile`

### Latest Version from [master](https://github.com/malcos/makefile-semver/tree/master) branch (it will eventually break)

[Makefile.semver](https://github.com/malcos/makefile-semver/blob/master/Makefile.semver):

```Makefile
_:=$(or $(wildcard Makefile.semver), $(shell curl -sO https://raw.githubusercontent.com/malcos/makefile-semver/master/Makefile.semver))
include Makefile.semver
```

### Latest Release Version [0.1.0](https://github.com/malcos/makefile-semver/tree/0.1.0)

[Makefile.semver-complete](https://github.com/malcos/makefile-semver/blob/0.1.0/Makefile.semver-complete):

```Makefile
_:=$(or $(wildcard Makefile.semver-complete), $(shell curl -sO https://raw.githubusercontent.com/malcos/makefile-semver/0.1.0/Makefile.semver-complete))
include Makefile.semver-complete
```

[Makefile.semver-basic](https://github.com/malcos/makefile-semver/blob/0.1.0/Makefile.semver-basic):

```Makefile
_:=$(or $(wildcard Makefile.semver-basic), $(shell curl -sO https://raw.githubusercontent.com/malcos/makefile-semver/0.1.0/Makefile.semver-basic))
include Makefile.semver-basic
```

### Release Version [0.0.3](https://github.com/malcos/makefile-semver/tree/0.0.3)

[Makefile.semver-complete](https://github.com/malcos/makefile-semver/blob/0.0.3/Makefile.semver-complete):

```Makefile
_:=$(or $(wildcard Makefile.semver-complete), $(shell curl -sO https://raw.githubusercontent.com/malcos/makefile-semver/0.0.3/Makefile.semver-complete))
include Makefile.semver-complete
```

[Makefile.semver-basic](https://github.com/malcos/makefile-semver/blob/0.0.3/Makefile.semver-basic):

```Makefile
_:=$(or $(wildcard Makefile.semver-basic), $(shell curl -sO https://raw.githubusercontent.com/malcos/makefile-semver/0.0.3/Makefile.semver-basic))
include Makefile.semver-basic
```

### Release Version [0.0.2](https://github.com/malcos/makefile-semver/tree/0.0.2)

[Make.semver-cycles](https://github.com/malcos/makefile-semver/blob/0.0.2/Make.semver-cycles):

```Makefile
_:=$(or $(wildcard Make.semver-cycles), $(shell curl -sO https://raw.githubusercontent.com/malcos/makefile-semver/0.0.2/Make.semver-cycles))
include Make.semver-cycles
```

[Make.semver-simple](https://github.com/malcos/makefile-semver/blob/0.0.2/Make.semver-simple):

```Makefile
_:=$(or $(wildcard Make.semver-simple), $(shell curl -sO https://raw.githubusercontent.com/malcos/makefile-semver/0.0.2/Make.semver-simple))
include Make.semver-simple
```

### Release Version [0.0.1](https://github.com/malcos/makefile-semver/tree/0.0.1)

[Make.semver-simple](https://github.com/malcos/makefile-semver/blob/0.0.1/Make.semver-simple):

```Makefile
_:=$(or $(wildcard Make.semver-simple), $(shell curl -sO https://raw.githubusercontent.com/malcos/makefile-semver/0.0.1/Make.semver-simple))
include Make.semver-simple
```
