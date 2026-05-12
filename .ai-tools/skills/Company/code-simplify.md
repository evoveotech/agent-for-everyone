---
name: code-simplify
description: Simplifies code for clarity. Use when refactoring code for clarity without changing behavior. Use when code works but is harder to read, maintain, or extend than it should be. Use when reviewing code that has accumulated unnecessary complexity.
---

# Code Simplification

Simplifies code for clarity without changing behavior. Clarity over cleverness always.

## Overview

Prioritize clarity over cleverness. Simple code is easier to understand, maintain, and debug. Code works but is harder to read, maintain, or extend than it should be.

## When to Use

- Refactoring code for clarity without changing behavior
- Code works but is harder to read, maintain, or extend than it should be
- Reviewing code that has accumulated unnecessary complexity
- Before merging a PR that has complex logic
- When code has accumulated technical debt

**When NOT to use:** When you don't understand what the code does, or when the change is too risky without comprehensive tests.

## The Five Principles

### 1. Preserve Behavior Exactly

Simplification must not change what the code does. The only acceptable change is making it clearer while producing identical output for all inputs.

- Run tests before and after
- Verify edge cases still work
- If behavior changes, it's not simplification — it's a bug

### 2. Follow Project Conventions

Don't introduce your own style. Follow the existing patterns in the codebase:

- Use the same naming conventions
- Follow the same code organization
- Use the same abstractions the project uses
- Don't introduce new patterns unless they're clearly better

### 3. Prefer Clarity Over Cleverness

Clever code is a maintenance burden. Clear code is a gift to future maintainers:

```typescript
// Bad: Clever but confusing
const result = arr.reduce((acc, val, i) => (i % 2 ? { ...acc, [val]: arr[i-1] } : acc), {});

// Good: Clear and explicit
const result = {};
for (let i = 1; i < arr.length; i += 2) {
  result[arr[i]] = arr[i - 1];
}
```

### 4. Maintain Balance

Don't oversimplify to the point of losing important context. Sometimes a few extra lines of code make the intent clearer:

```typescript
// Too terse
const f = (a, b) => a.filter(x => x.id === b.id)[0];

// Better: Clear intent
const findItemById = (items, target) => items.find(item => item.id === target.id);
```

### 5. Scope to What Changed

Don't simplify code outside the scope of your change. If you notice something that could be improved elsewhere, note it separately:

```typescript
NOTICED BUT NOT TOUCHING:
- src/utils/format.ts has complex date formatting logic (separate task)
- The auth middleware could be simplified (separate task)
→ Want me to create tasks for these?
```

## The Simplification Process

### Step 1: Understand Before Touching (Chesterton's Fence)

Before simplifying code, understand why it's written that way:

- Read the git history — was there a specific reason for this complexity?
- Check for comments explaining edge cases
- Look for related tests that reveal hidden requirements
- If you can't explain why the code is complex, don't change it

**Chesterton's Fence:** If you see a fence in the middle of nowhere, don't remove it until you understand why it was put there.

### Step 2: Identify Simplification Opportunities

Look for:

- Deeply nested conditionals (use guard clauses)
- Long functions (extract smaller functions)
- Cryptic variable names (rename for clarity)
- Magic numbers/strings (extract constants)
- Duplicate code (extract shared logic)
- Complex boolean expressions (extract predicates)
- Overly clever one-liners (expand for clarity)

### Step 3: Apply Changes Incrementally

Make one simplification at a time, testing after each:

1. Make the change
2. Run tests
3. Verify the behavior is identical
4. Commit if tests pass
5. Move to the next simplification

This makes it easy to identify which change broke something.

### Step 4: Verify the Result

After simplification:

- All tests still pass
- The code is easier to understand
- No behavior has changed
- Performance is not significantly worse

## Language-Specific Guidance

### TypeScript / JavaScript

- Use meaningful variable and function names
- Avoid nested ternary operators
- Prefer explicit returns over implicit returns in complex functions
- Use guard clauses to reduce nesting
- Extract complex boolean expressions into named functions
- Use const/let appropriately
- Avoid unnecessary abstraction

### Python

- Use list comprehensions when they improve readability
- Avoid nested list comprehensions
- Use descriptive variable names
- Prefer explicit over implicit
- Extract complex logic into functions
- Use type hints when helpful

### React / JSX

- Extract complex components into smaller ones
- Use custom hooks for shared logic
- Avoid deeply nested JSX
- Use meaningful prop names
- Prefer functional components over class components
- Extract inline functions when they become complex

## Common Rationalizations

| Rationalization | Reality |
|---|---|
| "It's clever, so it's good" | Clever code is a maintenance burden. Clear code is better. |
| "It's shorter, so it's better" | Shorter is not always simpler. Clarity trumps brevity. |
| "Performance matters here" | Profile first. Most "performance" code isn't actually hot. |
| "I'll add a comment to explain it" | Comments are a code smell. Make the code self-explanatory. |
| "The original author is gone, so I can change it" | Respect the original design unless you understand why it exists. |

## Red Flags

- Changing behavior while "simplifying"
- Introducing new abstractions that aren't used elsewhere
- Making code shorter but harder to understand
- Changing code you don't fully understand
- Not running tests after simplification
- Simplifying code outside your task scope
- Removing error handling or edge case logic
- Changing the API surface of functions

## Verification

After completing simplification:

- [ ] All tests pass
- [ ] Behavior is identical to before
- [ ] Code is easier to understand
- [ ] No new abstractions were introduced unnecessarily
- [ ] Project conventions were followed
- [ ] Changes were made incrementally with testing between each
