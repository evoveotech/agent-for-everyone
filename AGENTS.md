# AGENTS.md

This file provides AI coding agents with essential project context, instructions, and constraints for the EvoVeo AI Engineering Infrastructure Reference Framework.

---

## Project Context

This is a reference framework, not a working application. It provides production-tested patterns and configuration templates that engineering teams adapt, extend, and integrate into their own projects.

### Repository Purpose

- Reference library of AI-assisted engineering infrastructure components
- Modular patterns, automation hooks, and AI capability systems
- Designed for learning and reference purposes

### Key Components

- **Skills** — Context-aware modules that activate automatically based on file changes and prompt patterns
- **Hooks** — Event-driven scripts that inject contextual awareness and validate code quality
- **Agents** — Autonomous sub-agents for architecture review, refactoring planning, and documentation
- **Persistent Context** — Documentation patterns that preserve project state across AI sessions

---

## Architecture

### Directory Structure

```
.ai-tools/
├── skills/                    # AI capability modules
│   ├── backend-dev-guidelines/
│   ├── frontend-dev-guidelines/
│   ├── skill-developer/
│   ├── route-tester/
│   ├── error-tracking/
│   └── skill-rules.json
├── hooks/                     # Workflow automation scripts
│   ├── skill-activation-prompt.*
│   ├── post-tool-use-tracker.sh
│   └── tsc-check.sh
├── agents/                    # Autonomous task handlers
│   ├── code-architecture-reviewer.md
│   ├── refactor-planner.md
│   └── auto-error-resolver.md
└── commands/                  # Slash command definitions
    └── dev-docs.md

dev/
└── README.md                  # Persistent context methodology
```

### Progressive Disclosure Pattern

Skills follow the 500-line rule:
- Main SKILL.md files stay under 500 lines
- Deep-dive content lives in resource files loaded on-demand
- Prevents context window exhaustion

---

## Agent Rules

### Before Making Changes

1. Read the relevant skill documentation in `.ai-tools/skills/`
2. Check existing utilities before creating new ones
3. Follow established naming conventions and patterns
4. Validate that changes do not break existing functionality

### Code Quality Standards

- **Readable over clever** — Explicit code wins over one-liners
- **Typed interfaces** — Untyped code is a bug
- **Defensive programming** — Validate inputs, handle edge cases explicitly
- **Enterprise error handling** — Every async boundary has error capture
- **Reusable abstractions** — Extract repeated logic, document contracts

### Behavioral Constraints

- Never generate fake implementations or mock data
- Never leave TODO placeholders without explanation
- Prefer refactoring over duplication
- Preserve backward compatibility when possible
- Avoid unnecessary dependencies
- Keep functions and classes focused

---

## Workflow Integration

### Skill Activation

Skills activate automatically when:
- Files matching path patterns are edited
- Prompt keywords are mentioned
- Intent patterns match the user's request

### Hook Execution

- `skill-activation-prompt` runs before the AI assistant sees the user's prompt
- `post-tool-use-tracker` runs after tool execution to track file changes
- Hooks read `.ai-tools/settings.json` for configuration

### Persistent Context

Use the three-file pattern in `dev/active/` for complex tasks:
- `[task]-plan.md` — Strategic plan, phases, acceptance criteria
- `[task]-context.md` — Decisions, key files, blockers, quick resume
- `[task]-tasks.md` — Checkbox task tracking

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

- `skill-developer` — Meta-skill, no tech requirements
- `route-tester` — Requires JWT cookie auth only
- `error-tracking` — Sentry works with most stacks

---

## Configuration

### Environment Variables

- `AI_PROJECT_DIR` — Project root path (required for hooks)

### skill-rules.json

Central configuration for skill activation:
- `promptTriggers` — Keywords and intent patterns
- `fileTriggers` — Path patterns and exclusions
- `enforcement` — Suggest, block, or warn
- `priority` — Critical, high, medium, low

### settings.json

Hook registration and command configuration in `.ai-tools/`

---

## Output Expectations

Your output must be:
- Production-ready code (compiles, passes tests, handles edge cases)
- Minimal technical debt (no unexplained TODOs, no dead code)
- Scalable structure (fits existing architecture, supports growth)
- Self-documenting (naming and structure make intent obvious)
- Maintainable (next engineer can understand without help)

---

## Documentation References

- [INSTRUCTIONS.md](INSTRUCTIONS.md) — Setup and configuration for human engineers
- [.ai-tools/skills/README.md](.ai-tools/skills/README.md) — Skill system documentation
- [.ai-tools/hooks/README.md](.ai-tools/hooks/README.md) — Hook configuration
- [.ai-tools/agents/README.md](.ai-tools/agents/README.md) — Agent reference
- [dev/README.md](dev/README.md) — Persistent context methodology
