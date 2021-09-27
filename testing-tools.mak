#
# RECOMMENDATION: import this file at the very top of the test suite file.
#
# This file provide the basic tools for writting tests for this specific project
#

# place to store test resutls, aliased to the SEMVER_FILE variable
TESTFILE := testing.out
SEMVER_FILE := $(TESTFILE)

# default overrides
SEMVER_CYCLES = alphabase betatest

# variable which reads the contents of TESTFILE when referenced
GOT = $(file < $(TESTFILE))

# make command boostraped with main test suite file, RUN is a natural command with echo, DO is suppressing the echo
RUN := $(MAKE) --no-print-directory --always-make --makefile=$(firstword $(MAKEFILE_LIST)) VERSION_METADATA=$(VERSION_METADATA)
DO := @$(RUN)

#
# default: defined for preventing recursive calls when RUN and DO are not used correclty
#
default:
	@echo default target in testing-tools.mak. You should never see this.

#
# print TEXT as title for a test suite
#
title:
	@echo
	@echo /////////////////////////////////////////////////////////////////////
	@echo //
	@echo //
	@echo // $(TEXT)
	@echo //
	@echo //
	@echo /////////////////////////////////////////////////////////////////////

#
# print TEXT as header for a set of tests
#
header:
	@echo
	@echo //
	@echo // $(TEXT)
	@echo //

#
# setup mock data for a test, write VALUE into the TESTFILE
#
setup:
	@echo "   setup value $(VALUE)$(file > $(TESTFILE),$(VALUE))"

#
# execute the ACTION target and generate propper logging, suppressing the original output
#
execute:
	$(eval result := $(shell $(RUN) $(ACTION)))
	@echo "   execute $(ACTION), output was $(result)"

#
# executes the ACTION target and captures the output into TESTFILE
#
capture:
	$(eval result := $(shell $(RUN) $(ACTION)))
	@echo "   capture $(ACTION), output was $(result)$(file > $(TESTFILE),$(result))"

#
# compare EXPECTED with the contents of TESTFILE, if the values differ then the test fails
#
verify:
	@echo $(if $(filter-out X$(EXPECTED), X$(GOT)), $(error !! Test Failed: Expected $(EXPECTED) but got $(GOT)), ___Test Passed: $(EXPECTED))

#
# peek into version variables
#

version.debug.VERSION:
	@echo $(VERSION)

version.debug.VERSION_DATA:
	@echo $(VERSION_DATA)

version.debug.VERSION_NUMBER:
	@echo $(VERSION_NUMBER)

version.debug.VERSION_MAJOR:
	@echo $(VERSION_MAJOR)

version.debug.VERSION_MINOR:
	@echo $(VERSION_MINOR)

version.debug.VERSION_PATCH:
	@echo $(VERSION_PATCH)

version.debug.VERSION_CYCLE:
	@echo $(VERSION_CYCLE)

version.debug.VERSION_CYCLE_NAME:
	@echo $(VERSION_CYCLE_NAME)

version.debug.VERSION_CYCLE_STEP:
	@echo $(VERSION_CYCLE_STEP)

version.debug.VERSION_METADATA:
	@echo $(VERSION_METADATA)
