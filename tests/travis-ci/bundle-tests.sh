#!/usr/bin/env bash

# Check commit message for @ to only run tag for bundle.
# Need to go two commit messages back because Travis merges PR branch into default branch.
BUNDLE_COMMIT="$(git log -2 --pretty=%B | awk '/./{line=$0} END{print line}' | cut -f2 -d'@' | cut -f1 -d' ')"
echo "${BUNDLE_COMMIT}"

# If @ is in the commit message, then only run tests with that tag.
if [ "${BUNDLE_COMMIT}" ]; then
  echo "Found @ keyword."
  echo "Only running tagged tests."
  ./bin/behat --config behat.bundle.yml --verbose --tags "@${BUNDLE_COMMIT}"
else
  echo "No keyword found."
  echo "Running all bundle tests."
  ./bin/behat --config behat.bundle.yml --verbose
fi
