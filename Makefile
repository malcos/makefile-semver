info:
	@echo Makefile-SemVer demonstration, use autocomplete to see available commands.

# demo version.*
include Makefile.semver-complete
include Makefile.semver-debug

# unit testing
runtests:
	@$(MAKE) --no-print-directory --directory=./support/testing --makefile=testing-main.mak runtests
