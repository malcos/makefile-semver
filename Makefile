info:
	@echo Makefile-SemVer demonstration, use autocomplete to see available commands.

# unit testing
runtests:
	@$(MAKE) --no-print-directory --directory=./support/testing --makefile=testing-main.mak runtests

# demo version.*
include Makefile.semver
include Makefile.semver-debug
