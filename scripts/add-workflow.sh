#!/usr/bin/env bash
# ~/scripts/add-workflow.sh
set -euo pipefail

WORKFLOW=$1
TARGET_REPO=$2

WORKFLOWS_REPO="$HOME/Development/workflows"

# Look directly in WORKFLOWS_REPO, not in a subdirectory
if [ ! -f "$WORKFLOWS_REPO/$WORKFLOW.yml" ]; then
    echo "Workflow $WORKFLOW not found in library"
    echo "Available workflows:"
    ls -1 "$WORKFLOWS_REPO"/*.yml 2>/dev/null | xargs -n1 basename -s .yml
    exit 1
fi

cd "$TARGET_REPO"

# Create workflows directory
mkdir -p .forgejo/workflows

# Copy workflow
cp "$WORKFLOWS_REPO/$WORKFLOW.yml" .forgejo/workflows/

# Commit
git add .forgejo/workflows/$WORKFLOW.yml
git commit -m "Add $WORKFLOW workflow"

echo "✓ Added $WORKFLOW to $(basename $TARGET_REPO)"
echo "Don't forget to configure secrets if needed"
