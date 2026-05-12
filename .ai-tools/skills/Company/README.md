# Company Skills

Production-grade engineering lifecycle skills for AI coding agents. These skills encode workflows, quality gates, and best practices for software development.

## Lifecycle Phases

```
DEFINE          PLAN           BUILD          VERIFY         REVIEW          SHIP
┌──────┐      ┌──────┐      ┌──────┐      ┌──────┐      ┌──────┐      ┌──────┐
│ Idea │ ───▶ │ Spec │ ───▶ │ Code │ ───▶ │ Test │ ───▶ │  QA  │ ───▶ │  Go  │
│Refine│      │  PRD │      │ Impl │      │Debug │      │ Gate │      │ Live │
└──────┘      └──────┘      └──────┘      └──────┘      └──────┘      └──────┘
  /spec          /plan          /build        /test         /review       /ship
```

## Skills

### 01-define-spec.md (DEFINE)
Refines raw ideas into sharp, actionable specifications worth building through structured divergent and convergent thinking.

**Use when:**
- You have a raw idea and need to clarify what to build
- Requirements are vague or conflicting
- Multiple stakeholders need alignment on scope
- A task feels too large or undefined to start

**Trigger phrases:** "Help me spec out this feature", "Write a specification for [idea]", "Clarify requirements for [feature]"

### 02-plan.md (PLAN)
Breaks work into small, verifiable tasks with explicit acceptance criteria.

**Use when:**
- You have a spec and need to break it into implementable units
- A task feels too large or vague to start
- Work needs to be parallelized across multiple agents
- You need to communicate scope to a human

**Trigger phrases:** "Plan this feature", "Break down this task", "Create an implementation plan"

### 03-build.md (BUILD)
Delivers changes incrementally through thin vertical slices.

**Use when:**
- Implementing any multi-file change
- Building a new feature from a task breakdown
- Refactoring existing code
- Any time you're tempted to write more than ~100 lines before testing

**Trigger phrases:** "Build this feature", "Implement this task", "Code this incrementally"

### 04-verify-test.md (VERIFY)
Drives development with tests as proof of correctness.

**Use when:**
- Implementing any new logic or behavior
- Fixing any bug
- Modifying existing functionality
- Adding edge case handling
- Any change that could break existing behavior

**Trigger phrases:** "Test this", "Verify this works", "Write tests for this"

### 05-review.md (REVIEW)
Conducts multi-dimensional code review with quality gates.

**Use when:**
- Before merging any PR or change
- After completing a feature implementation
- When another agent or model produced code you need to evaluate
- When refactoring existing code
- After any bug fix

**Trigger phrases:** "Review this code", "Code review", "Check this PR"

### 06-ship.md (SHIP)
Prepares production launches with pre-launch checklists, monitoring, and rollback strategies.

**Use when:**
- Preparing to deploy to production
- Need a pre-launch checklist
- Setting up monitoring for a new feature
- Planning a staged rollout
- Need a rollback strategy

**Trigger phrases:** "Ship this feature", "Deploy to production", "Launch this"

### code-simplify.md (REVIEW SUB-SKILL)
Simplifies code for clarity without changing behavior.

**Use when:**
- Refactoring code for clarity without changing behavior
- Code works but is harder to read, maintain, or extend than it should be
- Reviewing code that has accumulated unnecessary complexity

**Trigger phrases:** "Simplify this code", "Refactor for clarity", "Clean up this code"

## How to Use

### Sequential Workflow

Follow the lifecycle phases in order:

1. **DEFINE** (`/spec`) - Clarify what to build before writing code
2. **PLAN** (`/plan`) - Break work into small, atomic tasks
3. **BUILD** (`/build`) - Implement incrementally with one slice at a time
4. **VERIFY** (`/test`) - Prove it works with tests as proof
5. **REVIEW** (`/review`) - Review before merge to improve code health
6. **SHIP** (`/ship`) - Deploy to production with confidence

### Example Prompt

```
I want to implement a user authentication feature for our platform microservice.

Please follow the Company skills lifecycle:

1. Use /spec to define what we're building
2. Use /plan to break it down into tasks
3. Use /build to implement incrementally
4. Use /test to verify with tests
5. Use /review to review the code
6. Use /ship to prepare for production launch
```

### Individual Skill Usage

You can also invoke individual skills as needed:

- "Use /spec to clarify requirements for the payment gateway integration"
- "Use /plan to break down the dashboard refactor into tasks"
- "Use /build to implement the user profile update endpoint"
- "Use /test to verify the order processing logic"
- "Use /review to review the PR for the notification system"
- "Use /ship to prepare the new feature for production launch"

## Skill Activation

These skills are configured in `.ai-tools/skills/skill-rules.json` with:
- **Prompt triggers**: Keywords and intent patterns that activate each skill
- **File triggers**: Path patterns that activate skills when relevant files are edited
- **Enforcement type**: Suggest (provides guidance without blocking)
- **Priority**: High for lifecycle skills, Medium for sub-skills

## Philosophy

These skills encode production-grade engineering practices:

- **Clarity over cleverness** — Simple code is easier to understand, maintain, and debug
- **Incremental delivery** — Build in thin vertical slices, test each slice
- **Test-driven verification** — Tests are proof, not optional
- **Quality gates** — Review before merge, ship with confidence
- **Continuous improvement** — Ship faster is safer through frequent small releases

## Reference

These skills are based on the [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) repository, adapted for the EvoVeo Tech framework.
