#!/bin/bash

set -e 

if [ -z "${REPO_NAME}" ]; then
    printf "Repository name not specified, REPO_NAME env variable is empty\n" >&2
    exit 1
fi

echo "$SSH_KEY" | base64 --decode > ~/.ssh/caos-dev-arm.cer
chmod 600  ~/.ssh/caos-dev-arm.cer

# Loading CrowdStrike Ansible Role Key
echo "$CROWDSTRIKE_ANSIBLE_ROLE_KEY" | base64 --decode > ~/.ssh/crowdstrike_ansible_role_key
chmod 600  ~/.ssh/crowdstrike_ansible_role_key

ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts

if [ -z "${GIT_CLONE_URL}" ]; then
    GIT_CLONE_URL=https://github.com/"${REPO_NAME}".git
fi
echo "cloning repo at ${GIT_CLONE_URL}"
git clone --config core.sshCommand="ssh -Tv -i ~/.ssh/caos-dev-arm.cer" "${GIT_CLONE_URL}" /srv/"${REPO_NAME}"

pushd "/srv/$REPO_NAME"

git fetch origin
git checkout "${REF}"
git pull origin "${REF}"
mkdir -p "${ANSIBLE_INVENTORY_FOLDER}"

make "${@}"
