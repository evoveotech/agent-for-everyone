#!/bin/bash
set -e

cd "$AI_PROJECT_DIR/.ai-tools/hooks"
cat | npx tsx skill-activation-prompt.ts
