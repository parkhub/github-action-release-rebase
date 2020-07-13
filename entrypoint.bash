#!/usr/bin/env bash

# Exit immediately if a pipeline, list, simple or compound command returns a
# non-zero status
set -e

# xtrace: Print a trace of simple commands, `for` commands, `case` commands,
# `select` commands, and arithmetic `for` commands and their arguments or
# associated word lists after they are expanded and before they are executed.
set -x

if [[ -n "${SSH_PRIVATE_KEY}" ]]; then
  echo "Saving SSH_PRIVATE_KEY"

  mkdir -p /root/.ssh
  echo "${SSH_PRIVATE_KEY}" > /root/.ssh/id_rsa
  chmod 600 /root/.ssh/id_rsa

  # Github action changes $HOME to /github at runtime
  # therefore we always copy the SSH key to $HOME (aka. ~)
  mkdir -p ~/.ssh
  cp /root/.ssh/* ~/.ssh/ 2> /dev/null || true
fi

BASE_REF=$1
HEAD_BRANCH=$2

if [[ -z "${BASE_REF}" ]]; then
  echo "Missing \$BASE_REF"
  exit 1
fi

if [[ -z "${HEAD_BRANCH}" ]]; then
  echo "Missing \$HEAD_BRANCH"
  exit 1
fi

if ! git check-ref-format --allow-onelevel --normalize "${BASE_REF}"; then
  echo "BASE_REF is invalid: ${BASE_REF}"
else
  BASE_REF=$(git check-ref-format --allow-onelevel --normalize "${BASE_REF}")
fi

echo "BASE_REF=${BASE_REF}"
echo "HEAD_BRANCH=${HEAD_BRANCH}"

mkdir _tmp && cd _tmp
git init

git config user.name "${GITHUB_ACTOR}"
git config user.email "${GITHUB_ACTOR}@users.noreply.github.com"

git remote add origin "https://x-access-token:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"
git remote set-url origin "https://x-access-token:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"

git remote -v
git remote update

# See https://git-scm.com/docs/git-rebase for options documentation
git rebase --autosquash --autostash -s recursive -X ours "${BASE_REF}" "${HEAD_BRANCH}"
git push --force origin "${HEAD_BRANCH}"
