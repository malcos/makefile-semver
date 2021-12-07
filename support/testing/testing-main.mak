# main target calling all test suites
runtests:
	@$(MAKE) --no-print-directory --makefile=testing-semver-numbers.mak runtests
	@$(MAKE) --no-print-directory --makefile=testing-semver-cycles.mak runtests
	@echo
	@echo ALL TESTS PASSED!
	@echo