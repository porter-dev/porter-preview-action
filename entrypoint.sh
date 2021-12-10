#!/usr/bin/env bash

# manual validation of required inputs (https://github.com/actions/runner/issues/1070)

export PORTER_HOST=${INPUT_HOST}
export PORTER_BRANCH_NAME=${INPUT_HOST:?input \"branch\" not set or empty}
export PORTER_CLUSTER=${INPUT_CLUSTER:?input \"cluster\" not set or empty}
export PORTER_PROJECT=${INPUT_PROJECT:?input \"project\" not set or empty}
export PORTER_TOKEN=${INPUT_TOKEN:?input \"token\" not set or empty}
export PORTER_NAMESPACE=${INPUT_NAMESPACE:?input \"namespace\" not set or empty}
export PORTER_PULL_REQUEST_ID=${INPUT_PR_ID:?input \"pr_id\" not set or empty}
export PORTER_GIT_INSTALLATION_ID=${INPUT_INSTALLATION_ID:?input \"installation_id\" not set or empty}
export PORTER_ACTION_ID=${INPUT_ACTION_ID:?input \"action_id\" not set or empty}

: "${INPUT_FILE:?input \"file\" not set or empty}"

porter apply -f "$INPUT_FILE"