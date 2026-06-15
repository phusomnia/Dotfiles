---

name: Testing
description: Guidance for designing, implementing, and maintaining a testing strategy that provides confidence, rapid feedback, and long-term maintainability
-------------------------------------------------------------------------------------------------------------------------------------------------------------

# Testing

## Core Ideology

Testing exists to provide confidence in change.

The purpose of testing is not to prove software is perfect. The purpose is to reduce risk, detect defects early, and ensure the system continues to behave as expected as it evolves.

A successful testing strategy:

* Enables safe refactoring.
* Prevents regressions.
* Documents expected behavior.
* Provides fast feedback.
* Supports continuous delivery.

---

# Testing Philosophy

## Test Behavior, Not Implementation

Focus on:

* Business rules
* User-visible outcomes
* Public contracts
* System behavior

Avoid:

* Testing private methods
* Testing internal implementation details
* Testing framework behavior
* Tests tightly coupled to code structure

A refactor should rarely require rewriting tests if behavior remains unchanged. Community discussions consistently highlight implementation-coupled tests as a maintenance burden.

---

## Confidence Over Coverage

Coverage is a measurement.

Confidence is the goal.

A test suite with 100% coverage can still miss critical defects, while a lower-coverage suite focused on business-critical behavior can provide greater confidence.

Ask:

* What risk does this test reduce?
* What failure would this detect?
* Is this behavior important?

---

## Test What Matters Most

Prioritize:

1. Business-critical workflows
2. Security-sensitive functionality
3. Financial calculations
4. Data integrity
5. High-risk integrations
6. Previously broken functionality

Not all code deserves equal testing investment.

---

## Fast Feedback Wins

Tests should provide feedback as early as possible.

Fast tests:

* Run locally
* Run in CI
* Encourage frequent execution
* Detect defects before deployment

Slow feedback reduces developer productivity and confidence.

---

# Testing Pyramid

Adopt the Testing Pyramid as the default testing strategy.

```
           End-to-End
               ▲
         Integration
               ▲
            Unit
```

The pyramid recommends:

* Many unit tests
* Fewer integration tests
* Very few end-to-end tests

Higher-level tests provide realism but are slower, more expensive, and more fragile. Lower-level tests provide faster and more precise feedback.

---

# Test Types

## Unit Tests

Purpose:

* Verify individual units of logic.
* Validate business rules.
* Provide immediate feedback.

Characteristics:

* Fast
* Deterministic
* Isolated
* Easy to debug

Test:

* Pure functions
* Domain logic
* Validation rules
* Calculations

Avoid:

* Network calls
* Real databases
* External services

---

## Integration Tests

Purpose:

* Verify component interactions.
* Validate contracts between systems.

Test:

* Database integration
* External APIs
* Message queues
* Service boundaries

Characteristics:

* Moderate speed
* Moderate complexity
* High confidence

Integration tests catch failures that unit tests cannot.

---

## End-to-End Tests

Purpose:

* Validate complete user journeys.

Examples:

* User registration
* Checkout flow
* Authentication flow

Characteristics:

* Slow
* Expensive
* High realism
* More fragile

Keep only critical user journeys at this level.

---

## Smoke Tests

Purpose:
* Verify the system is fundamentally operational.
* Validate build and deployment health.
* Detect catastrophic failures early.
* Prevent unstable builds from progressing.

Characteristics:
* Very fast
* High signal
* Low maintenance
* Automated
* Deployment-focused

Test:
* Application startup
* Health endpoints
* Database connectivity
* Authentication flow
* Core business workflow
* Critical external dependencies

Avoid:
* Edge cases
* Full business rule validation
* Performance testing
* Security testing
* Exhaustive user journeys

Example checks:

* Application starts successfully
* Database connection succeeds
* Login succeeds
* Core API endpoint responds
* Core transaction completes

Smoke tests should execute before all other test suites and act as a deployment gate.
```
Build
  ↓
Smoke Tests
  ↓
Unit Tests
  ↓
Integration Tests
  ↓
End-to-End Tests
```
If smoke tests fail:
* Stop deployment.
* Stop regression testing.
* Fix the issue immediately.

A smoke suite should typically complete within a few minutes and validate only the most critical functionality required for the system to operate.

---

# Preferred Testing Patterns

## AAA Pattern

Structure tests as:

### Arrange

Prepare inputs and dependencies.

### Act

Execute behavior under test.

### Assert

Verify expected outcomes.

```text
Arrange
Act
Assert
```

This should be the default structure for most tests.

---

## Given / When / Then

For business scenarios:

```text
Given a user account
When the user submits valid credentials
Then access is granted
```

Use for:

* Acceptance tests
* Integration tests
* Business-rule validation

---

## Table-Driven Testing

Use when validating multiple inputs.

Example:

```text
Input | Expected
------|---------
0     | Invalid
1     | Valid
10    | Valid
```

Reduces duplication while increasing coverage.

---

## Property-Based Testing

When appropriate:

Instead of testing individual examples:

```text
2 + 2 = 4
```

Test properties:

```text
a + b = b + a
```

Useful for:

* Algorithms
* Parsing
* Transformations
* Mathematical logic

---

# Reliability Rules

Tests must be:

## Deterministic

A test should either:

* Always pass
* Always fail

for the same code and environment.

---

## Independent

Tests must not depend on:

* Execution order
* Shared state
* Previous tests

---

## Repeatable

Tests should produce identical results locally and in CI.

---

# Anti-Patterns

## Testing Implementation Details

Bad:

* Verifying private methods
* Mocking everything
* Asserting internal state

Good:

* Verifying observable behavior

---

## Over-Mocking

Mocking excessive dependencies often creates tests that validate mocks rather than software.

Mock external boundaries.

Avoid mocking core business logic.

---

## Flaky Tests

A flaky test is a broken test.

Common causes:

* Timing assumptions
* Race conditions
* Network dependencies
* Shared state

Fix or remove flaky tests immediately.

---

## Ice-Cream Cone Testing

Bad distribution:

* Many E2E tests
* Few unit tests

Results:

* Slow pipelines
* Fragile builds
* Difficult debugging

This is the inverse of the Testing Pyramid and is a common testing anti-pattern.

---

# Test Review Checklist

For every test ask:

* Does it verify behavior?
* Does it reduce risk?
* Is it easy to understand?
* Is it deterministic?
* Is it independent?
* Is it maintainable?
* Is it testing the correct level?

If a test fails, the cause should be obvious.

---

# Definition of Done

A feature is not complete until:

* Critical paths are tested.
* Edge cases are covered.
* Regressions are prevented.
* Tests pass consistently.
* CI validation succeeds.
* Test code is as maintainable as production code.

The ultimate goal of testing is confidence: confidence to deploy, confidence to refactor, and confidence to move quickly without breaking the system.
