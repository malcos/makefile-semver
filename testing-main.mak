# main target calling all test suites
runtests:
	@$(MAKE) --no-print-directory --makefile=testing-basic-numbers.mak testsuite
	@$(MAKE) --no-print-directory --makefile=testing-complete-numbers.mak testsuite
