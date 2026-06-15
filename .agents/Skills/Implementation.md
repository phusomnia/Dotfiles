---
name: Implementation
description: Guidance for implementing features, writing production-quality code, and making technical design decisions
---

# Implementation

## Core Ideology

Write code for the next developer, not just for the compiler.

Prioritize:

1. Correctness before optimization.
2. Simplicity before abstraction.
3. Maintainability before cleverness.
4. Readability before brevity.
5. Explicitness over implicit behavior.
6. Composition over inheritance.
7. Pragmatic solutions over dogmatic rules.

Clean, maintainable code reduces cognitive load, improves testability, and makes future changes safer. Apply principles such as SOLID, DRY, and KISS when they improve clarity, not as rigid rules.

---

# Design Principles

## SOLID

### Single Responsibility Principle (SRP)

* Modules should have one reason to change.
* Separate business logic, infrastructure, and presentation concerns.

### Open/Closed Principle (OCP)

* Extend behavior without modifying existing code.
* Prefer interfaces and strategy implementations.

### Liskov Substitution Principle (LSP)

* Derived types must behave as expected by their contracts.

### Interface Segregation Principle (ISP)

* Prefer small focused interfaces over large generic ones.

### Dependency Inversion Principle (DIP)

* Depend on abstractions rather than concrete implementations.

These principles improve flexibility, maintainability, and testability.

---

# Preferred Patterns

## Architectural Patterns

Apply when appropriate:

* Layered Architecture
* Clean Architecture
* Hexagonal Architecture (Ports & Adapters)
* CQRS (when complexity justifies it)
* Event-Driven Architecture

## Object-Oriented Patterns

Use proven patterns when they solve a real problem:

* Strategy
* Factory
* Adapter
* Observer
* Builder
* Repository

Avoid introducing patterns prematurely.

---

# Implementation Standards

## Functions

* Keep functions focused on a single responsibility.
* Prefer descriptive names.
* Avoid deep nesting.
* Extract reusable logic when it improves readability.

## Classes

* Model a single concept.
* Hide implementation details.
* Expose minimal public APIs.
* Favor composition over inheritance.

## Error Handling

* Fail fast.
* Use meaningful error messages.
* Never silently ignore exceptions.
* Handle errors at appropriate boundaries.

## State Management

* Minimize mutable state.
* Prefer immutable data structures when practical.
* Keep side effects explicit.

---

# Code Quality Rules

## DO

* Write self-documenting code.
* Keep modules cohesive.
* Remove dead code.
* Refactor continuously.
* Add tests alongside features.
* Document non-obvious decisions.

## DON'T

* Over-engineer.
* Create abstractions without demonstrated need.
* Introduce unnecessary dependencies.
* Duplicate business logic.
* Optimize without measurement.
* Hide complexity behind misleading abstractions.

---

# Performance Philosophy

* Make it work.
* Make it correct.
* Make it maintainable.
* Then optimize based on evidence.

Do not sacrifice readability for hypothetical performance gains.

---

# Security Considerations

Always:

* Validate external input.
* Sanitize user-controlled data.
* Follow least-privilege principles.
* Protect secrets and credentials.
* Avoid logging sensitive information.

---

# Definition of Done

Implementation is complete when:

* Feature requirements are satisfied.
* Tests pass.
* Edge cases are handled.
* Code review concerns are addressed.
* Documentation is updated.
* No known critical defects remain.
* The solution is understandable without additional explanation.
