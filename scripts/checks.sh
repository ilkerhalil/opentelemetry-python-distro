#!/usr/bin/env bash
set -eo pipefail

# pre-commit
pre-commit run -a

# run u.t
pushd src/test/
pytest ci
pytest unit
popd

# branch name validation
if [[ -n "$CIRCLECI" ]]
then
    # Check if branch contains RD ticket value.
    echo "$CIRCLE_BRANCH" | grep -E "[RDrd]-[0-9]+|master|version-testing-[0-9]{4}[0-9]{2}[0-9]{2}|dependabot/" || { echo "Please create a relevent ticket in Jira and connect it to this branch. Use jiranch." ; exit 1; }
fi
