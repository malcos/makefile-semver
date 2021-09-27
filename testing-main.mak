# main target calling all test suites
runtests:
	@$(MAKE) --no-print-directory --makefile=testing-basic-numbers.mak runtests
	@$(MAKE) --no-print-directory --makefile=testing-complete-numbers.mak runtests
	@$(MAKE) --no-print-directory --makefile=testing-complete-cycles.mak runtests
