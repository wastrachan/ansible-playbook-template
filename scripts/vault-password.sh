#!/usr/bin/env bash
#
# Read ansible-vault password from git secret encrtpyted file

if [[ -z "$(command -v git-secret)" ]]; then
  echo "Error: Git secret is not installed. It's not possible to lock up secrets without this."
  exit 1
fi

git secret cat .vault_password.secret
