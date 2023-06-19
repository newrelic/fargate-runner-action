#!/bin/bash

set -e 

if [ -z "${REPO_NAME}" ]; then
    printf "Repository name not specified, REPO_NAME env variable is empty\n" >&2
    exit 1
fi

echo "$SSH_KEY" | base64 --decode > ~/.ssh/caos-dev-arm.cer
chmod 600  ~/.ssh/caos-dev-arm.cer
cp ~/.ssh/caos-dev-arm.cer ~/.ssh/id_rsa

git clone https://github.com/"${REPO_NAME}".git /srv/"${REPO_NAME}"

pushd "/srv/$REPO_NAME"

git fetch origin
git checkout "${REF}"
git pull origin "${REF}"
mkdir -p "${ANSIBLE_INVENTORY_FOLDER}"

make "${@}"
