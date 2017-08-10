#!/usr/bin/env bash

# Check commit message for !==express to skip test run.
# Need to go two commit messages back because Travis merges PR branch into default branch.
EXPRESS_COMMIT="$(git log -2 --pretty=%B | awk '/./{line=$0} END{print line}' | grep !==express)"
echo "${EXPRESS_COMMIT}"

# If !==express is in the commit message, then don't run Express tests.
if [ "${EXPRESS_COMMIT}" ]; then
  echo "Found !==express keyword."
  echo "Not running Express tests."
else
  echo "No keyword found."
  echo "Running Express tests."
  ./bin/behat --config behat.yml --verbose
fi
