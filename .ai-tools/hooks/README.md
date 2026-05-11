# Automation Hooks

Workflow automation scripts that enable contextual capability activation, file tracking, and quality validation.

---

## What Are Hooks?

Hooks are scripts that run at specific points in an AI assistant's workflow:
- **UserPromptSubmit**: When user submits a prompt
- **PreToolUse**: Before a tool executes
- **PostToolUse**: After a tool completes
- **Stop**: When user requests to stop

**Key insight:** Hooks modify prompts, validate actions, and track state — enabling proactive automation that AI assistants cannot achieve independently.

---

## Essential Hooks (Start Here)

### skill-activation-prompt (UserPromptSubmit)

**Purpose:** Automatically suggests relevant skills based on user prompts and file context

**How it works:**
1. Reads `skill-rules.json`
2. Matches user prompt against trigger patterns
3. Checks which files user is working with
4. Injects skill suggestions into the AI assistant's context

**Why it's essential:** This is THE hook that makes skills auto-activate.

**Integration:**
```bash
# Copy both files
cp skill-activation-prompt.sh your-project/.ai-tools/hooks/
cp skill-activation-prompt.ts your-project/.ai-tools/hooks/

# Make executable
chmod +x your-project/.ai-tools/hooks/skill-activation-prompt.sh

# Install dependencies
cd your-project/.ai-tools/hooks
npm install
```

**Add to settings.json:**
```json
{
  "hooks": {
    "UserPromptSubmit": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "$AI_PROJECT_DIR/.ai-tools/hooks/skill-activation-prompt.sh"
          }
        ]
      }
    ]
  }
}
```

**Customization:** ✅ None needed - reads skill-rules.json automatically

---

### post-tool-use-tracker (PostToolUse)

**Purpose:** Tracks file changes to maintain context across sessions

**How it works:**
1. Monitors Edit/Write/MultiEdit tool calls
2. Records which files were modified
3. Creates cache for context management
4. Auto-detects project structure (frontend, backend, packages, etc.)

**Why it's essential:** Helps the AI assistant understand what parts of your codebase are active.

**Integration:**
```bash
# Copy file
cp post-tool-use-tracker.sh your-project/.ai-tools/hooks/

# Make executable
chmod +x your-project/.ai-tools/hooks/post-tool-use-tracker.sh
```

**Add to settings.json:**
```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|MultiEdit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "$AI_PROJECT_DIR/.ai-tools/hooks/post-tool-use-tracker.sh"
          }
        ]
      }
    ]
  }
}
```

**Customization:** ✅ None needed - auto-detects structure

---

## Optional Hooks (Require Customization)

### tsc-check (Stop)

**Purpose:** TypeScript compilation check when user stops

**⚠️ WARNING:** Configured for multi-service monorepo structure

**Integration:**

**First, determine if this is right for you:**
- ✅ Use if: Multi-service TypeScript monorepo
- ❌ Skip if: Single-service project or different build setup

**If using:**
1. Copy tsc-check.sh
2. **EDIT the service detection (line ~28):**
   ```bash
   # Replace example services with YOUR services:
   case "$repo" in
       api|web|auth|payments|...)  # ← Your actual services
   ```
3. Test manually before adding to settings.json

**Customization:** ⚠️⚠️⚠️ Heavy

---

### trigger-build-resolver (Stop)

**Purpose:** Auto-launches build-error-resolver agent when compilation fails

**Depends on:** tsc-check hook working correctly

**Customization:** ✅ None (but tsc-check must work first)

---

## For AI Assistants

**When setting up hooks for a user:**

1. **Read [AI_INTEGRATION_GUIDE.md](../../AI_INTEGRATION_GUIDE.md)** first
2. **Always start with the two essential hooks**
3. **Ask before adding Stop hooks** - they can block if misconfigured  
4. **Verify after setup:**
   ```bash
   ls -la .ai-tools/hooks/*.sh | grep rwx
   ```

**Questions?** See [AI_INTEGRATION_GUIDE.md](../../AI_INTEGRATION_GUIDE.md)
