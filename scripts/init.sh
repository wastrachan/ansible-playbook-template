#!/usr/bin/env bash
#
# Initialize the project for first-time use:
#
#   1) Check for dependencies
#   2) Register git hooks

# Check Dependencies
echo ""
echo "Checking dependencies...................................................."
if [[ -z "$(command -v ansible-playbook)" ]]; then
  echo "Error: Ansible is not installed. It's not possible to run the project without this."
  exit 1
fi
if [[ -z "$(command -v git-secret)" ]]; then
  echo "Error: Git secret is not installed. It's not possible to lock up secrets without this."
  exit 1
fi

# Register git hooks (symlink into place)
echo ""
echo "Copying git hooks into .git/hooks........................................"
HOOK_SOURCE="$(git rev-parse --show-toplevel)/scripts/git-hooks"
HOOK_DIR="$(git rev-parse --show-toplevel)/.git/hooks"
HOOK_NAMES="pre-commit post-update"
for hook in $HOOK_NAMES; do
  rm -rf $HOOK_DIR/$hook
  ln -s -f $HOOK_SOURCE/$hook $HOOK_DIR/$hook
done
