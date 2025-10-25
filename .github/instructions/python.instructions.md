---
description: "Python coding conventions, best practices, and Copilot prompts for this repository."
applyTo: "**/*.py"
---

# Python Coding Conventions & Best Practices

## Global Copilot Directives
- Target **Python 3.11+**; write code compatible with **`pyproject.toml`** workflows (uv/Poetry).
- Prefer the **standard library** first; only add deps when they make code **simpler, safer, or faster**.
- Generate code that is **typed, documented, and testable** by default.
- Produce **small, single-responsibility** functions; keep classes lean and focused.
- Use **f-strings**, **`pathlib.Path`**, **`logging`** (never `print`), and **context managers** for resources.
- Prefer **comprehensions** to `map`/`filter`; never use wildcard imports.

**Copilot prompt tip:** “Write a typed, small function that accepts `Path` inputs, uses only the stdlib (unless clearly justified), raises specific exceptions, and includes a short docstring.”

---

## Typing & Interfaces (modern style)
- Add **explicit type hints** for parameters and returns.
- Use **built-in generics** (`list[str]`, `dict[str, int]`, `set[Path]`), and the **union operator** (`A | B`, `str | None`).
- Handle forward references with **`from __future__ import annotations`**.
- Use **`Protocol`** for structural typing; prefer **dependency injection** over concrete coupling.
- Use **`TypeVar`/`ParamSpec/Concatenate`** when generics or decorator signatures benefit readability.
- Avoid `Any`; if unavoidable, scope it narrowly and document the rationale.
- Prefer `dataclasses` for data containers; choose immutability (`frozen=True`) when possible.

---

## Standard Library First (priorities)
- **`pathlib`** for all filesystem work; **`shutil`** for safe file operations.
- **`contextlib`** for deterministic cleanup (incl. `AsyncExitStack`).
- **`functools`** for caching and partials; **`itertools`** for iteration tools.
- **`collections`** for counters, deques, and default dict patterns.
- **`argparse`** for CLI; parse paths directly into `Path`.
- **`typing`** utilities for clarity; **`dataclasses`** for readable records.

---

## Code Structure & Design
- **Prefer functions** for stateless operations; **use classes** when you truly need state, invariants, or polymorphism.
- **Composition over inheritance**; keep inheritance shallow and purposeful.
- Separate **pure computation** from **I/O** for testability.
- Keep public APIs small, explicit (`__all__`) and documented.

**Quick decision guide (classes vs functions):**
- Use a **class** when: persistent state, multiple related methods, lifecycle/cleanup, or polymorphic behavior.
- Use a **function** when: single small task, no stored state, simple transformation, or convenience wrapper.

---

## Resource Management & Asynchrony
- Always use `with` (or async `with`) for files, sockets, locks, and sessions.
- Prefer **`asyncio`** with `async`/`await` for I/O-bound concurrency; **do not** add async if it doesn’t simplify or speed up I/O paths.
- For task sets: gather as a group, propagate exceptions, and apply explicit timeouts.
- For HTTP client code, prefer **`httpx`** (sync or async) when stdlib is insufficient.

---

## Errors, Exceptions & Logging
- Raise **specific exceptions**; never use bare `except`.
- Preserve tracebacks with exception chaining; add context to error messages.
- Configure logging once at app entry; use module-level loggers elsewhere.
- Use `contextlib.suppress` only for a **specific, explained** exception.

---

## Performance & Robustness
- Pick the right data structure (list/set/dict/deque/tuple).
- Use `functools.lru_cache` for deterministic, expensive computations; document invalidation policy.
- Favor clear loops unless vectorization or libraries demonstrably improve clarity and speed.
- Measure first (profilers, high-res timers) before optimizing.

---

## Security & Configuration (essentials)
- **Never** commit secrets; read via env vars or a secret manager.
- Use **`secrets`** for tokens/secure randomness (not `random`).
- **Validate and sanitize** all external inputs.
- Build file paths with `Path` joins, not string concatenation.
- **Subprocess:** default to `shell=False` and pass **argument lists**; avoid `shell=True`. If forced, strictly validate/allowlist inputs and quote defensively.

---

## Tooling Expectations
- **Ruff** = **primary linter & formatter** (target Py 3.11, 100-char lines). Enable rules for errors, formatting, imports, modernization, best practices, annotations, comprehensions, simplifications, and Ruff-specific checks. Allow missing `self`/`cls` annotations where intentional.
- **Mypy** in **strict** mode. Disallow untyped defs, show error codes, report redundant casts/ignores, avoid implicit `Optional`.
- Project uses **`pyproject.toml`** with **uv** (primary) or **Poetry** (alt). Prefer `uv run`/`poetry run` for tool execution.

**Copilot negative prompts:** Don’t use `print`; don’t use wildcard imports; don’t introduce new deps if stdlib suffices; don’t write untyped public APIs; don’t use mutable default args.
