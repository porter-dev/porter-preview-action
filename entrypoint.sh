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
export PORTER_REPO_OWNER=${INPUT_REPO_OWNER:?input \"repo_owner\" not set or empty}
export PORTER_PR_NAME=${INPUT_PR_NAME:?input \"pr_name\" not set or empty}

: "${INPUT_FILE:?input \"file\" not set or empty}"

# Work around https://github.com/actions/checkout/issues/760
git config --global --add safe.directory $PWD

subdomains_log="/tmp/subdomains.log"
subdomains=()

porter apply -f "$INPUT_FILE" | tee /dev/tty | egrep "Your web application is ready at: " >> "$subdomains_log"

while read -r line; do
    if [[ "${line}" =~ ^"Your web application is ready at: ".* ]]; then
        subdomains+=("${line#Your web application is ready at\: }")
    fi
done < "${subdomains_log}"

output="{\"subdomains\": ["

if (( ${#subdomains[@]} != 0 )); then
    for (( i=0; i<${#subdomains[@]}-1; i++ ));
    do
        output="${output}\"${subdomains[$i]}\", "
    done

    output="${output}\"${subdomains[${#subdomains[@]}-1]}\""
fi

output="${output}]}"

echo "domains=${output}" >> "$GITHUB_OUTPUT"
