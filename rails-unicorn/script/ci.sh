#!/bin/bash

set -ex

echo "Node: $CIRCLE_NODE_INDEX running: $SPEC_FILES"

mkdir -p rspec
mkdir -p tmp/capybara
yarn install

case $CIRCLE_NODE_INDEX in
  0*)
    yarn prettier-diff
    ;;
  1*)
    yarn test
    ;;
  2*)
    bundle exec rubocop --parallel
    ;;
  *)
    echo "No need to run extra stuff."
    ;;
esac

echo "Installing the latest stable Chrome"
curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list \
  && apt-get update \
  && apt-get install -y google-chrome-stable

google-chrome --version
chromedriver --version
bundle show selenium-webdriver

set +e
bundle exec rspec --format progress --format RspecJunitFormatter -o ./rspec/rspec-$CIRCLE_NODE_INDEX.xml -- ${SPEC_FILES}
./script/retry_rspec_failure.sh
