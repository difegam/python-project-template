# Copilot Instructions for AI Coding Agents

## Project Overview

This is a Python project template supporting two package managers: [uv](https://docs.astral.sh/uv/) and [Poetry](https://python-poetry.org/). The structure is designed for rapid prototyping and clean organization, with a focus on modern Python tooling and developer experience.

## Architecture & Structure

- **Source code:** `src/python_project_template/`
- **Tests:** `tests/`
- **Project configuration:** Managed by either `uv` or `Poetry` (see relevant branch)
- **Task runner:** Uses [Justfile](https://just.systems/man/en/) for common commands
- **Pre-commit hooks:** Run with `pre-commit run --all-files` (see VS Code task)

## Key Workflows

- **Install dependencies:**
  - For uv: `uv pip install -r requirements.txt` or `uv venv`
  - For Poetry: `poetry install`
- **Run pre-commit checks:** Use the VS Code task "Run pre-commit hook" or run manually
- **Run tests:**
  - Place tests in `tests/`
  - Use `pytest` or your preferred test runner
- **Linting & formatting:**
  - [Ruff](https://docs.astral.sh/ruff/) is recommended for linting and formatting
  - Configure Ruff via `pyproject.toml` or `.ruff.toml` if present
- **Task automation:**
  - Use `just` for project-specific tasks (see `Justfile`)

## Conventions & Patterns

- **Branching:**
  - `uv` branch for uv-based setup
  - `poetry` branch for Poetry-based setup
- **Directory layout:**
  - All source code in `src/python_project_template/`
  - Tests in `tests/`
- **.gitignore:**
  - Generate using [gitignore generator](https://www.toptal.com/developers/gitignore)
- **Inspired by:**
  - See README for links to template inspirations

## Integration Points

- **External tools:**
  - uv, Poetry, Ruff, Just
- **VS Code tasks:**
  - "Run pre-commit hook" task available

## Examples

- To run all pre-commit hooks: `pre-commit run --all-files`
- To install dependencies (uv): `uv pip install -r requirements.txt`
- To install dependencies (Poetry): `poetry install`
- To run tests: `pytest tests/`

## References

- See `README.md` for more details and resource links
- Key directories: `src/`, `tests/`, `.github/`

---

If any conventions or workflows are unclear, please ask for clarification or request examples from the codebase.
