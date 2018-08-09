#!/bin/bash
# Retry failed RSpec specs up to $RSPEC_RETRY times. If no meaningful $RSPEC_RETRY
# provided, it will just exit.

set -x

if [[ $RSPEC_RETRY -gt 0 ]]; then
  FAILED=0
  until [[ $FAILED -eq $RSPEC_RETRY ]] || bundle exec rspec --format progress --only-failure; do
    ((FAILED++))
  done
  [[ $FAILED -ne $RSPEC_RETRY ]]
fi
