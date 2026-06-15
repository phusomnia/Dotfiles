---

name: CodeReview
description: Guidance for reviewing code changes with a focus on correctness, maintainability, architecture, and team learning
------------------------------------------------------------------------------------------------------------------------------

# Code Review

## Core Ideology

Code review exists to improve the software, not to judge the developer.

The goal of a review is to:

* Prevent defects from reaching production.
* Preserve architectural integrity.
* Share knowledge across the team.
* Improve maintainability.
* Ensure long-term code ownership.

A good review makes the codebase better.
A great review makes both the codebase and the team better.

---

# Review Priorities

Review in this order:

1. Business Correctness
2. Design & Architecture
3. Reliability & Security
4. Maintainability
5. Test Coverage
6. Readability
7. Style & Formatting

Do not spend 20 minutes discussing formatting while missing a critical bug. Formatting should be automated whenever possible.

---

# What To Review

## 1. Correctness

Ask:

* Does the implementation solve the problem?
* Does it satisfy requirements?
* Are edge cases handled?
* Can it fail unexpectedly?
* Is error handling appropriate?

Nothing else matters if the solution is incorrect.

---

## 2. Design

Verify:

* Architecture boundaries are respected.
* Responsibilities are properly separated.
* Abstractions are justified.
* Dependencies flow correctly.
* The solution fits existing patterns.

Prefer consistency with the system over personal preferences.

---

## 3. Security

Review for:

* Input validation
* Authentication
* Authorization
* Data exposure
* Secrets handling
* Injection vulnerabilities

Security defects are often easier to catch during review than after deployment.

---

## 4. Maintainability

Ask:

* Will this be understandable in 6 months?
* Is complexity justified?
* Are names meaningful?
* Is duplication necessary?
* Can future changes be made safely?

Code is read more often than it is written.

---

## 5. Tests

Verify:

* Critical paths are tested.
* Edge cases are covered.
* Existing behavior is protected.
* Tests are readable and maintainable.

A feature without tests is unfinished.

---

# Review Principles

## Understand Before Suggesting

Always understand:

* Why the change exists.
* Why the implementation was chosen.
* What constraints influenced decisions.

Reviewing without understanding context often leads to incorrect feedback.

---

## Focus On Intent

Review outcomes, not implementation preferences.

Prefer:

> "Does this solve the problem safely?"

Over:

> "Would I have written it differently?"

---

## Prefer Questions Over Commands

Good:

* Could this be extracted into a separate component?
* What happens when the request fails?
* Would a strategy pattern simplify this logic?

Avoid:

* Rewrite this.
* This is wrong.
* Use my approach.

Constructive reviews create collaboration.

---

## Be Objective

Comments should reference:

* Requirements
* Architecture
* Standards
* Performance
* Security
* Maintainability

Not personal taste.

---

# Review Checklist

## Architecture

* Boundaries respected
* Appropriate abstractions
* No unnecessary coupling
* Consistent with system design

## Code Quality

* Clear naming
* Reasonable complexity
* No duplicated logic
* Proper encapsulation

## Reliability

* Error handling
* Retry behavior
* Failure scenarios
* Resource cleanup

## Security

* Validation
* Authorization
* Sensitive data protection

## Performance

* Unnecessary allocations
* Expensive operations
* N+1 queries
* Blocking operations

## Testing

* Happy path covered
* Edge cases covered
* Regression protection

---

# Anti-Patterns

Avoid:

## Rubber Stamp Reviews

* "LGTM" without understanding changes.
* Approval without reading code.

## Nitpick Reviews

* Excessive focus on style.
* Debating subjective preferences.

## Architecture During PR

Major architectural disagreements should be resolved before implementation, not after thousands of lines are written.

## Personal Criticism

Review code.
Never review people.

---

# Reviewer Mindset

A reviewer is:

* A quality guardian.
* A collaborator.
* A mentor.
* A future maintainer.

A reviewer is not:

* A gatekeeper.
* A judge.
* A style enforcer.

---

# Approval Criteria

Approve when:

* Requirements are met.
* Architecture is respected.
* Risks are acceptable.
* Tests are sufficient.
* Code is maintainable.
* Concerns are resolved.

Do not block merges for subjective preferences unless they violate documented standards.

---

# Definition of Successful Review

A successful review:

* Improves the code.
* Teaches something valuable.
* Preserves team trust.
* Leaves a documented decision trail.
* Makes future maintenance easier.

The best review is one where both the author and reviewer leave with a better understanding of the system.
