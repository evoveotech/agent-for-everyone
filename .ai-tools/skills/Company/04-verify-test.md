---
name: test
description: Drives development with tests. Use when implementing any logic, fixing any bug, or changing any behavior. Use when you need to prove that code works, when a bug report arrives, or when you're about to modify existing functionality.
---

# Test-Driven Development

Write a failing test before writing the code that makes it pass. For bug fixes, reproduce the bug with a test before attempting a fix. Tests are proof — "seems right" is not done.

## Overview

Write tests to prove code works correctly. A codebase with good tests is an AI agent's superpower; a codebase without tests is a liability. Tests are the definition of correctness.

## When to Use

- Implementing any new logic or behavior
- Fixing any bug (the Prove-It Pattern)
- Modifying existing functionality
- Adding edge case handling
- Any change that could break existing behavior

**When NOT to use:** Pure configuration changes, documentation updates, or static content changes that have no behavioral impact.

## The TDD Cycle

```
    RED                GREEN              REFACTOR
 Write a test    Write minimal code    Clean up the
 that fails  ──→  to make it pass  ──→  implementation  ──→  (repeat)
      │                  │                    │
      ▼                  ▼                    ▼
   Test FAILS        Test PASSES         Tests still PASS
```

### Step 1: RED — Write a Failing Test

Write the test first. It must fail. A test that passes immediately proves nothing.

```typescript
// RED: This test fails because createTask doesn't exist yet
describe('TaskService', () => {
  it('creates a task with title and default status', async () => {
    const task = await taskService.createTask({ title: 'Buy groceries' });

    expect(task.id).toBeDefined();
    expect(task.title).toBe('Buy groceries');
    expect(task.status).toBe('pending');
    expect(task.createdAt).toBeInstanceOf(Date);
  });
});
```

### Step 2: GREEN — Make It Pass

Write the minimum code to make the test pass. Don't over-engineer:

```typescript
// GREEN: Minimal implementation
export async function createTask(input: { title: string }): Promise<Task> {
  const task = {
    id: generateId(),
    title: input.title,
    status: 'pending' as const,
    createdAt: new Date(),
  };
  await db.tasks.insert(task);
  return task;
}
```

### Step 3: REFACTOR — Clean Up

With tests green, improve the code without changing behavior:

- Extract shared logic
- Improve naming
- Remove duplication
- Optimize if necessary

Run tests after every refactor step to confirm nothing broke.

## The Prove-It Pattern (Bug Fixes)

When a bug is reported, **do not start by trying to fix it.** Start by writing a test that reproduces it.

```
Bug report arrives
       │
       ▼
  Write a test that demonstrates the bug
       │
       ▼
  Test FAILS (confirming the bug exists)
       │
       ▼
  Implement the fix
       │
       ▼
  Test PASSES (proving the fix works)
       │
       ▼
  Run full test suite (no regressions)
```

**Example:**

```typescript
// Bug: "Completing a task doesn't update the completedAt timestamp"

// Step 1: Write the reproduction test (it should FAIL)
it('sets completedAt when task is completed', async () => {
  const task = await taskService.createTask({ title: 'Test' });
  const completed = await taskService.completeTask(task.id);

  expect(completed.status).toBe('completed');
  expect(completed.completedAt).toBeInstanceOf(Date);  // This fails → bug confirmed
});

// Step 2: Fix the bug
export async function completeTask(id: string): Promise<Task> {
  return db.tasks.update(id, {
    status: 'completed',
    completedAt: new Date(),  // This was missing
  });
}

// Step 3: Test passes → bug fixed, regression guarded
```

## The Test Pyramid

Invest testing effort according to the pyramid — most tests should be small and fast, with progressively fewer tests at higher levels:

```
          ╱╲
         ╱  ╲         E2E Tests (~5%)
        ╱    ╲        Full user flows, real browser
       ╱──────╲
      ╱        ╲      Integration Tests (~15%)
     ╱          ╲     Component interactions, API boundaries
    ╱────────────╲
   ╱              ╲   Unit Tests (~80%)
  ╱                ╲  Pure logic, isolated, milliseconds each
 ╱──────────────────╲
```

**The Beyonce Rule:** If you liked it, you should have put a test on it. Infrastructure changes, refactoring, and migrations are not responsible for catching your bugs — your tests are.

### Test Sizes (Resource Model)

Beyond the pyramid levels, classify tests by what resources they consume:

| Size | Constraints | Speed | Example |
|------|------------|-------|---------|
| **Small** | Single process, no I/O, no network, no database | Milliseconds | Pure function tests, data transforms |
| **Medium** | Multi-process OK, localhost only, no external services | Seconds | API tests with test DB, component tests |
| **Large** | Multi-machine OK, external services allowed | Minutes | E2E tests, performance benchmarks, staging integration |

Small tests should make up the vast majority of your suite.

### Decision Guide

```
Is it pure logic with no side effects?
  → Unit test (small)

Does it cross a boundary (API, database, file system)?
  → Integration test (medium)

Is it a critical user flow that must work end-to-end?
  → E2E test (large) — limit these to critical paths
```

## Writing Good Tests

### Test State, Not Interactions

Test what your code does, not how it does it:

```typescript
// Bad: Tests implementation details
it('calls the database with the right query', () => {
  expect(db.query).toHaveBeenCalledWith('SELECT * FROM tasks');
});

// Good: Tests behavior
it('returns all tasks', async () => {
  const tasks = await taskService.getAll();
  expect(tasks).toHaveLength(3);
});
```

### DAMP Over DRY in Tests

Tests should be Descriptive And Meaningful Phrases (DAMP), not just DRY. Some duplication in tests is fine if it makes the test clearer.

```typescript
// Bad: Too DRY, hard to understand
it('handles edge cases', () => {
  testCases.forEach(({ input, expected }) => {
    expect(calculate(input)).toBe(expected);
  });
});

// Good: Clear and descriptive
it('handles zero', () => expect(calculate(0)).toBe(0));
it('handles negative numbers', () => expect(calculate(-5)).toBe(-5));
it('handles large numbers', () => expect(calculate(10000)).toBe(10000));
```

### Prefer Real Implementations Over Mocks

Mocks make tests fragile. Use real implementations when possible:

```typescript
// Bad: Mocked database
it('creates a task', async () => {
  db.insert = jest.fn().mockResolvedValue({ id: 1 });
  await taskService.createTask({ title: 'Test' });
  expect(db.insert).toHaveBeenCalled();
});

// Good: Real database (in-memory for tests)
it('creates a task', async () => {
  const task = await taskService.createTask({ title: 'Test' });
  const retrieved = await db.tasks.findOne({ id: task.id });
  expect(retrieved.title).toBe('Test');
});
```

### Use the Arrange-Act-Assert Pattern

Structure tests clearly:

```typescript
describe('calculateTotal', () => {
  it('sums item prices', () => {
    // Arrange
    const items = [{ price: 10 }, { price: 20 }];

    // Act
    const total = calculateTotal(items);

    // Assert
    expect(total).toBe(30);
  });
});
```

### One Assertion Per Concept

Each test should verify one logical thing. Multiple assertions for the same concept are fine:

```typescript
// Good: One logical assertion
it('creates a task with correct structure', () => {
  const task = createTask({ title: 'Test' });
  expect(task.id).toBeDefined();
  expect(task.title).toBe('Test');
  expect(task.status).toBe('pending');
  expect(task.createdAt).toBeInstanceOf(Date);
});
```

### Name Tests Descriptively

Test names should read like requirements:

```typescript
// Bad
it('works', () => {});
it('test2', () => {});

// Good
it('creates a task with default pending status', () => {});
it('rejects negative amounts', () => {});
```

## Test Anti-Patterns to Avoid

- Testing implementation details instead of behavior
- Over-mocking — tests become coupled to implementation
- Skipping tests with `skip` or `only` left in the codebase
- Tests that depend on execution order
- Tests with random data that cause flakiness
- Testing private methods — test the public interface
- Test files that are too large (break them up)

## Common Rationalizations

| Rationalization | Reality |
|---|---|
| "I'll add tests later" | Later never comes. Tests are never added later. |
| "This is too simple to test" | Simple code breaks too. Tests prove it stays simple. |
| "Tests slow me down" | Tests speed you up by catching bugs immediately. |
| "I'll just manually test it" | Manual testing doesn't scale. Tests run automatically forever. |
| "Mocks are easier than setting up real dependencies" | Mocks make tests fragile. Real implementations are more reliable. |

## Red Flags

- Tests that are skipped or commented out
- Tests that depend on execution order
- Tests with random data causing flakiness
- More mocking than actual code under test
- Tests that take more than a few seconds to run
- No tests for critical user flows
- Tests that only test happy paths, no error cases

## Verification

After implementing code with TDD:

- [ ] A failing test was written first
- [ ] The minimal code was written to make it pass
- [ ] The code was refactored with tests green
- [ ] All tests still pass after refactoring
- [ ] No uncommitted code remains
- [ ] The test clearly describes the behavior it verifies
