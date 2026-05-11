# Instructions

Setup, configuration, and integration guide for the EvoVeo AI Engineering Infrastructure Reference Framework.

---

## Setup

### Installation

Copy the framework into your project:

```bash
# Clone the reference framework
git clone https://github.com/evoveotech/agent-for-everyone.git

# Copy .ai-tools directory to your project
cp -r agent-for-everyone/.ai-tools your-project/
```

### Dependencies

Install hook dependencies:

```bash
cd your-project/.ai-tools/hooks
npm install
```

Make shell scripts executable:

```bash
chmod +x .ai-tools/hooks/*.sh
```

---

## Hook Configuration

### Essential Hooks

Two hooks are required for skill activation:

1. **skill-activation-prompt** — Contextual skill suggestion
2. **post-tool-use-tracker** — File change tracking

### Configure settings.json

Create or update `.ai-tools/settings.json`:

```json
{
  "hooks": {
    "UserPromptSubmit": [
      {
        "type": "command",
        "command": "$AI_PROJECT_DIR/.ai-tools/hooks/skill-activation-prompt.sh"
      }
    ],
    "PostToolUse": [
      {
        "type": "command",
        "command": "$AI_PROJECT_DIR/.ai-tools/hooks/post-tool-use-tracker.sh"
      }
    ]
  }
}
```

### Environment Variables

Set `AI_PROJECT_DIR` to your project root:

```bash
export AI_PROJECT_DIR=/path/to/your/project
```

---

## Skill Configuration

### Add a Skill

1. Copy the skill directory to `.ai-tools/skills/`
2. Update `.ai-tools/skills/skill-rules.json` with your project paths

### skill-rules.json Structure

```json
{
  "skills": {
    "skill-name": {
      "type": "domain",
      "enforcement": "suggest",
      "priority": "high",
      "description": "Skill description with trigger keywords",
      "promptTriggers": {
        "keywords": ["keyword1", "keyword2"],
        "intentPatterns": ["(create|add).*?(pattern)"]
      },
      "fileTriggers": {
        "pathPatterns": ["src/**/*.ts"],
        "pathExclusions": ["**/*.test.ts"]
      }
    }
  }
}
```

### Customize Path Patterns

Replace example paths with your actual project structure:

```json
"pathPatterns": [
  "api-gateway/src/**/*.ts",
  "order-service/src/**/*.ts",
  "payment-service/src/**/*.ts"
]
```

---

## Agent Usage

Agents are standalone markdown files. Copy them to `.ai-tools/agents/` and invoke them directly through your AI assistant.

### Available Agents

- `code-architecture-reviewer.md` — Architectural consistency validation
- `refactor-planner.md` — Refactoring strategy design
- `auto-error-resolver.md` — TypeScript error correction
- `documentation-architect.md` — Technical documentation generation

---

## Tech Stack Compatibility

### Backend Skills

**backend-dev-guidelines requires:**
- Node.js/Express
- TypeScript
- Prisma ORM
- Sentry

### Frontend Skills

**frontend-dev-guidelines requires:**
- React (18+)
- MUI v7
- TanStack Query
- TanStack Router
- TypeScript

### Tech-Agnostic Skills

These work with any stack:
- `skill-developer` — Meta-skill, no tech requirements
- `route-tester` — Requires JWT cookie auth only
- `error-tracking` — Sentry works with most stacks

---

## Troubleshooting

### Skills Not Activating

**Check:**
1. Hook is registered in `settings.json`
2. `skill-rules.json` path patterns match your file paths
3. Hook dependencies are installed
4. Shell scripts are executable

**Debug:**
```bash
# Test hook manually
echo '{"prompt":"test"}' | npx tsx .ai-tools/hooks/skill-activation-prompt.ts
```

### TypeScript Errors in Hooks

Check that `@types/node` is installed:

```bash
cd .ai-tools/hooks
npm install @types/node
```

---

## Advanced Customization

### Optional Hooks

- `tsc-check.sh` — TypeScript validation on stop (monorepo)
- `error-handling-reminder.sh` — Quality reminders
- `trigger-build-resolver.sh` — Build error resolution

### Stop Hooks

Stop hooks can block commits if validation fails. Configure thresholds in hook scripts.

### Slash Commands

Copy command files to `.ai-tools/commands/` and register in your AI assistant configuration.

---

## Best Practices

### Start Minimal

Begin with the two essential hooks and one skill. Validate activation before adding complexity.

### Customize for Your Domain

Replace example path patterns with your actual service names. Add domain-specific keywords to skill triggers.

### Maintain skill-rules.json

Keep path patterns current as your project structure evolves. Test new keywords before committing.

### Test Hooks Manually

Before relying on hooks in production, test them manually to verify they work with your project structure.

---

## Validation

After setup, verify integration:

1. Edit a file matching a skill path pattern — skill should activate
2. Ask a question with skill keywords — skill should be suggested
3. Check hooks execute without errors
4. Verify `skill-rules.json` syntax: `jq . .ai-tools/skills/skill-rules.json`

---

## Support

For issues or questions:
- Check component documentation in `.ai-tools/` subdirectories
- Verify tech stack compatibility before integrating skills
- Open an issue with your project structure and error details
