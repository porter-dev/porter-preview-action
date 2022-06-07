#!/usr/bin/env bash

# manual validation of required inputs (https://github.com/actions/runner/issues/1070)

export PORTER_HOST=${INPUT_HOST}
export PORTER_BRANCH_FROM=${INPUT_PR_BRANCH_FROM:?input \"pr_branch_from\" not set or empty}
export PORTER_BRANCH_INTO=${INPUT_PR_BRANCH_INTO:?input \"pr_branch_into\" not set or empty}
export PORTER_CLUSTER=${INPUT_CLUSTER:?input \"cluster\" not set or empty}
export PORTER_PROJECT=${INPUT_PROJECT:?input \"project\" not set or empty}
export PORTER_TOKEN=${INPUT_TOKEN:?input \"token\" not set or empty}
export PORTER_NAMESPACE=${INPUT_NAMESPACE:?input \"namespace\" not set or empty}
export PORTER_PULL_REQUEST_ID=${INPUT_PR_ID:?input \"pr_id\" not set or empty}
export PORTER_GIT_INSTALLATION_ID=${INPUT_INSTALLATION_ID:?input \"installation_id\" not set or empty}
export PORTER_ACTION_ID=${INPUT_ACTION_ID:?input \"action_id\" not set or empty}
export PORTER_REPO_NAME=${INPUT_REPO_NAME:?input \"repo_name\" not set or empty}
export PORTER_REPO_NAME=${$(echo INPUT_REPO_NAME | awk '{print tolower($0)}'):?input \"repo_name\" not set or empty}
export PORTER_REPO_OWNER=${INPUT_REPO_OWNER:?input \"repo_owner\" not set or empty}
export PORTER_PR_NAME=${INPUT_PR_NAME:?input \"pr_name\" not set or empty}

: "${INPUT_FILE:?input \"file\" not set or empty}"

# Work around https://github.com/actions/checkout/issues/760
git config --global --add safe.directory $PWD

porter apply -f "$INPUT_FILE"
