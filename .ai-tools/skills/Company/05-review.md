---
name: review
description: Conducts multi-axis code review. Use before merging any change. Use when reviewing code written by yourself, another agent, or a human. Use when you need to assess code quality across multiple dimensions before it enters the main branch.
---

# Code Review and Quality

Multi-dimensional code review with quality gates. Every change gets reviewed before merge — no exceptions.

## Overview

Review code to improve quality, catch bugs, and ensure consistency. Every change gets reviewed before merge — no exceptions. Review covers five axes: correctness, readability, architecture, security, and performance.

**The approval standard:** Approve a change when it definitely improves overall code health, even if it isn't perfect. Perfect code doesn't exist — the goal is continuous improvement. Don't block a change because it isn't exactly how you would have written it. If it improves the codebase and follows the project's conventions, approve it.

## When to Use

- Before merging any PR or change
- After completing a feature implementation
- When another agent or model produced code you need to evaluate
- When refactoring existing code
- After any bug fix (review both the fix and the regression test)

## The Five-Axis Review

Every review evaluates code across these dimensions:

### 1. Correctness

Does the code do what it claims to do?

- Does it match the spec or task requirements?
- Are edge cases handled (null, empty, boundary values)?
- Are error paths handled (not just the happy path)?
- Does it pass all tests? Are the tests actually testing the right things?
- Are there off-by-one errors, race conditions, or state inconsistencies?

### 2. Readability & Simplicity

Can another engineer (or agent) understand this code without the author explaining it?

- Are names descriptive and consistent with project conventions? (No `temp`, `data`, `result` without context)
- Is the control flow straightforward (avoid nested ternaries, deep callbacks)?
- Is the code organized logically (related code grouped, clear module boundaries)?
- Are there any "clever" tricks that should be simplified?
- **Could this be done in fewer lines?** (1000 lines where 100 suffice is a failure)
- **Are abstractions earning their complexity?** (Don't generalize until the third use case)
- Would comments help clarify non-obvious intent? (But don't comment obvious code.)
- Are there dead code artifacts: no-op variables (`_unused`), backwards-compat shims, or `// removed` comments?

### 3. Architecture

Does the change fit the system's design?

- Does it follow existing patterns or introduce a new one? If new, is it justified?
- Does it maintain clean module boundaries?
- Is there code duplication that should be shared?
- Are dependencies flowing in the right direction (no circular dependencies)?
- Is the abstraction level appropriate (not over-engineered, not too coupled)?

### 4. Security

Does the change introduce vulnerabilities?

- Is user input validated and sanitized?
- Are secrets kept out of code, logs, and version control?
- Is authentication/authorization checked where needed?
- Are SQL queries parameterized (no string concatenation)?
- Are outputs encoded to prevent XSS?
- Are dependencies from trusted sources with no known vulnerabilities?
- Is data from external sources (APIs, logs, user content, config files) treated as untrusted?
- Are external data flows validated at system boundaries before use in logic or rendering?

### 5. Performance

Does the change introduce performance problems?

- Any N+1 query patterns?
- Any unbounded loops or unconstrained data fetching?
- Any synchronous operations that should be async?
- Any unnecessary re-renders in UI components?
- Any missing pagination on list endpoints?
- Any large objects created in hot paths?

## Change Sizing

| Size | Lines | Files | Example |
|------|-------|-------|---------|
| **XS** | <50 | 1 | Fix a typo, add a validation rule |
| **S** | 50-200 | 1-2 | Add a new API endpoint, refactor one function |
| **M** | 200-500 | 3-5 | Add a feature slice, refactor a module |
| **L** | 500-1000 | 5-10 | Add a multi-component feature, major refactor |
| **XL** | >1000 | >10 | **Too large — break into smaller PRs** |

If a change is XL or larger, request it be broken into smaller PRs. Large PRs are harder to review, harder to test, and harder to roll back.

## Change Descriptions

Every PR should have a clear description:

```markdown
## Summary
One paragraph explaining what this change does and why.

## Changes
- File A: Added X feature
- File B: Fixed Y bug
- File C: Refactored for clarity

## Testing
- Added tests for X
- Manual testing steps for Y
```

## Review Process

### Step 1: Understand the Context

Read the PR description, the issue/ticket it addresses, and any linked specs. Understand the problem being solved before looking at code.

### Step 2: Review the Tests First

Tests are the best way to understand what the code is supposed to do. Review tests for:
- Coverage of happy path
- Coverage of edge cases
- Clarity of what's being tested

If tests are missing or inadequate, request them be added before approving.

### Step 3: Review the Implementation

Apply the five-axis review framework. Focus on:
- Does it solve the problem?
- Is it readable and maintainable?
- Does it fit the architecture?
- Is it secure?
- Is it performant?

### Step 4: Categorize Findings

Label each finding:

- **Must Fix** — Blocking issues (security bugs, broken functionality, missing tests)
- **Should Fix** — Important but not blocking (readability, minor performance)
- **Nice to Have** — Suggestions for future improvement

### Step 5: Verify the Verification

Confirm the author actually verified their changes:
- Tests pass locally
- Build succeeds
- Manual testing was done if applicable

## The Review Checklist

### Correctness
- [ ] Matches spec or requirements
- [ ] Edge cases handled
- [ ] Error paths covered
- [ ] Tests pass and are meaningful

### Readability
- [ ] Names are descriptive
- [ ] Control flow is straightforward
- [ ] Code is organized logically
- [ ] No unnecessary cleverness
- [ ] Comments clarify non-obvious intent
- [ ] No dead code artifacts

### Architecture
- [ ] Follows existing patterns
- [ ] Maintains module boundaries
- [ ] No code duplication
- [ ] Dependencies flow correctly
- [ ] Abstraction level appropriate

### Security
- [ ] Input validation present
- [ ] No secrets in code/logs
- [ ] Auth/authz checked where needed
- [ ] SQL queries parameterized
- [ ] Outputs encoded
- [ ] Dependencies are trusted
- [ ] External data validated at boundaries

### Performance
- [ ] No N+1 queries
- [ ] No unbounded loops
- [ ] Async where appropriate
- [ ] No unnecessary re-renders
- [ ] Pagination on lists
- [ ] No large objects in hot paths

## Common Rationalizations

| Rationalization | Reality |
|---|---|
| "It's just a small change, no need for review" | Small changes can introduce big bugs. Review all changes. |
| "The author is senior, I don't need to review closely" | Even senior engineers make mistakes. Review everyone's code. |
| "I'll trust the tests" | Tests can be wrong. Review the code, not just the test results. |
| "This is just a refactor, no behavior change" | Refactors can introduce bugs. Review refactors carefully. |
| "I don't want to slow them down" | Blocking a bug now saves time later. Quality is speed. |

## Red Flags

- No tests for new functionality
- Tests that only test happy paths
- Missing error handling
- Hardcoded secrets or credentials
- SQL injection vulnerabilities
- XSS vulnerabilities
- N+1 query patterns
- Unbounded loops or data fetching
- Dead code artifacts
- Inconsistent naming
- Over-engineering for hypothetical future requirements

## Verification

After completing a code review:

- [ ] All five axes have been evaluated
- [ ] Findings are categorized as Must Fix, Should Fix, or Nice to Have
- [ ] Tests have been reviewed
- [ ] The PR description is clear
- [ ] Approval or request for changes is justified
- [ ] Comments are specific and actionable
