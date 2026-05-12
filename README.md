# EvoVeo AI Engineering Infrastructure Reference Framework

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

A reference collection of modular patterns, automation hooks, and AI capability systems for AI-assisted software engineering.

---

## Overview

This framework provides production-tested patterns and configuration templates that engineering teams can adapt, extend, and integrate into their own projects. It is not a working application — it is a reference library of infrastructure components.

### Core Components

- **Skills** — Context-aware modules that automatically activate based on file changes and prompt patterns
- **Hooks** — Event-driven scripts that inject contextual awareness and validate code quality
- **Agents** — Autonomous sub-agents for architecture review, refactoring planning, and documentation
- **Persistent Context** — Documentation patterns that preserve project state across AI sessions

---

## Philosophy

- **Modular architecture** — Components are composable and independent
- **Maintainability first** — Code is written for the engineer reading it in six months
- **Automation-first** — Prefer automated validation over manual checklists
- **Scalable workflows** — Patterns work for single services and multi-service architectures
- **Production-grade standards** — Error handling, observability, and validation are mandatory

---

## Quick Start

### Installation

```bash
git clone https://github.com/evoveotech/agent-for-everyone.git
cd agent-for-everyone
```

### Bootstrap

1. Copy `skill-activation-prompt` and `post-tool-use-tracker` hooks to your project
2. Configure `.ai-tools/settings.json`
3. Install dependencies: `cd .ai-tools/hooks && npm install`
4. Make shell scripts executable: `chmod +x *.sh`

### Activate a Skill

1. Copy a skill directory to `.ai-tools/skills/`
2. Update `skill-rules.json` with your project paths
3. Edit a matching file — the skill activates automatically

See [INSTRUCTIONS.md](INSTRUCTIONS.md) for detailed setup and configuration.

---

## Repository Structure

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

---

## Key Features

### Contextual Skill Activation

Skills activate automatically when you edit relevant files or mention specific keywords. No manual invocation required.

### Progressive Disclosure

Each skill follows the 500-line rule — main files stay under 500 lines, with deep-dive content in separate resource files loaded on-demand.

### Persistent Context Documentation

A three-file pattern preserves project state, decisions, and progress across AI assistant session boundaries.

---

## Design Principles

- **Readable over clever** — Explicit code wins over one-liners
- **Typed interfaces** — Untyped code is a bug
- **Defensive programming** — Validate inputs, handle edge cases explicitly
- **Enterprise error handling** — Every async boundary has error capture
- **Reusable abstractions** — Extract repeated logic, document contracts

---

## Credits & Inspiration

This framework is maintained by EvoVeo Tech as a community reference resource. It is inspired by production-tested AI engineering workflows and designed for learning and reference purposes.

Attribution to original patterns and workflows is preserved in relevant component documentation.

---

## Supported AI Agents
Agent Skills work with these AI coding agents:

| Agent | Support | Location |
|:------|:--------|:---------|
| **GitHub Copilot** | ✅ Full Support | `.github/skills/` or `~/.copilot/skills/` |
| **Claude Code** | ✅ Full Support | `.claude/skills/` or `~/.claude/skills/` |
| **Cursor** | ✅ Full Support | `.cursor/rules/` |
| **Windsurf** | ✅ Full Support | `.windsurf/rules/` |
| **VS Code Insiders** | ✅ Full Support | Agent mode with skills |
| **VS Code (Stable)** | ⏳ Coming Soon | Support coming in future release |

---

## Documentation

- [AGENTS.md](AGENTS.md) — AI agent instruction manual and project context
- [INSTRUCTIONS.md](INSTRUCTIONS.md) — Setup, configuration, and integration guide
- [.ai-tools/skills/README.md](.ai-tools/skills/README.md) — Capability system documentation
- [.ai-tools/hooks/README.md](.ai-tools/hooks/README.md) — Automation hook configuration
- [.ai-tools/agents/README.md](.ai-tools/agents/README.md) — Autonomous agent reference
- [dev/README.md](dev/README.md) — Persistent context methodology

---

[EvoVeo Tech](https://www.evoveo.com)
