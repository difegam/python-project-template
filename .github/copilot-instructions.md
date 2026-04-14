# Copilot Instructions for AI Coding Agents

## Project Overview

This repository uses `main` as a documentation-first branch. It is not the
runnable Python template.
Use [README.md](../README.md) as the canonical source for onboarding, branch
selection, and setup.

## Branch Model

- `main`: shared documentation and repository guidance
- `uv`: runnable template using uv-based tooling
- `poetry`: runnable template using Poetry-based tooling

Choose the branch that matches the package manager you are changing.

## Architecture & Structure

- **Python version:** 3.12+
- **Runnable branch source code:** `src/python_project_template/`
- **Runnable branch tests:** `tests/`
- **Package entry point:** `src/python_project_template/app.py`
- **Shared exports:** `src/python_project_template/__init__.py`
- **Project configuration:** branch-specific
- **Task runner:** Optional [Justfile](https://just.systems/man/en/) when present
- **Pre-commit hooks:** Optional; run with `pre-commit run --all-files` when
  configured

## Agent Workflow

- Start with [README.md](../README.md) for branch selection and setup.
- Do not treat `main` as the runnable template branch.
- On `uv`, prefer `just` recipes when a Justfile is present.
- On `poetry`, use direct commands such as `poetry install`, `pytest`,
  `ruff check --fix`, `ruff format`, and
  `mypy src/python_project_template/`.
- Use `pre-commit run --all-files` only when pre-commit is configured.

## Conventions & Patterns

- **Formatting:** Ruff enforces a 100-character line length.
- **Style:** Use 4-space indentation and double quotes.
- **Naming:** Use `snake_case` for modules, functions, and tests; use
  `PascalCase` for classes.
- **Imports:** Keep imports absolute from `python_project_template`.

## Integration Points

- **External tools:**
  - uv, Poetry, Ruff, Just
- **VS Code tasks:**
  - "Run pre-commit hook" task available

## Examples

- Choose branch first: see [README.md](../README.md)
- Run all pre-commit hooks (if configured): `pre-commit run --all-files`
- Run tests on `uv`: `just test`
- Run tests on `poetry`: `pytest tests/`

## References

- See [README.md](../README.md) for onboarding details and resource links
- Key directories: `src/`, `tests/`, `.github/`

---

If any conventions or workflows are unclear, please ask for clarification or request examples from the codebase.
