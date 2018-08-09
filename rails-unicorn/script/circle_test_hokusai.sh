#!/bin/bash

set -x

SPEC_FILES=$(circleci tests glob "spec/**/*_spec.rb" | circleci tests split --split-by=timings)
SPEC_FILES=${SPEC_FILES} hokusai test
