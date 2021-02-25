#!/usr/bin/env bash

echo "======="
echo "BASH CI"
echo "======="

echo "Environment"
echo "  WORKDIR: ${PWD}"
echo "  GITLAB_DEPLOY_KEY: ${GITLAB_DEPLOY_KEY}"

git config --global user.name "BASH CI"
git config --global user.email "${GITLAB_USER_EMAIL}"

[[ -n "${GITLAB_DEPLOY_KEY}" ]] && GITLAB_DEPLOY_KEY=${CI_PROJECT_DIR}/${GITLAB_DEPLOY_KEY}

if [[ -f "${GITLAB_DEPLOY_KEY}" ]]; then
    echo "Found deploy key: ${GITLAB_DEPLOY_KEY}"
    cp ${GITLAB_DEPLOY_KEY} /root/.ssh/deploy_key
    chmod 400 /root/.ssh/deploy_key
fi

exec docker-entrypoint.sh "$@"
