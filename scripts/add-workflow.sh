#!/usr/bin/env bash
# ~/scripts/add-workflow.sh

set -euo pipefail

WORKFLOW=$1
TARGET_REPO=$2

WORKFLOWS_REPO="$HOME/projects/forgejo-workflows"

if [ ! -f "$WORKFLOWS_REPO/workflows/$WORKFLOW.yml" ]; then
    echo "Workflow $WORKFLOW not found in library"
    exit 1
fi

cd "$TARGET_REPO"

# Create workflows directory
mkdir -p .forgejo/workflows

# Copy workflow
cp "$WORKFLOWS_REPO/workflows/$WORKFLOW.yml" .forgejo/workflows/

# Commit
git add .forgejo/workflows/$WORKFLOW.yml
git commit -m "Add $WORKFLOW workflow"

echo "✓ Added $WORKFLOW to $(basename $TARGET_REPO)"
echo "Don't forget to configure secrets if needed"
