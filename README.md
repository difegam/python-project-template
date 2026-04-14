
# Python Project Template

This repository is a Python project scaffold with two package manager variants:
[uv](https://docs.astral.sh/uv/) and [Poetry](https://python-poetry.org/).

## Template Status

- This `main` branch is documentation-first and is not the runnable template.
- Dependency manifests, lockfiles, and application code live on the
  package-manager branches.
- Use `main` for shared documentation updates. Make runnable template changes on
  the `uv` or `poetry` branch.
- If you want a working project immediately, start by selecting a package
  manager branch.

## Prerequisites

- Python 3.12+
- Git
- One package manager:
  - [uv](https://docs.astral.sh/uv/)
  - [Poetry](https://python-poetry.org/)

Both runnable branches currently require Python 3.12 or newer.

## Choose a Package Manager

Use one of these branch workflows:

1. uv

```bash
git fetch origin
git switch --track origin/uv
```

1. Poetry

```bash
git fetch origin
git switch --track origin/poetry
```

After switching, follow the setup instructions on that branch to install
dependencies, hooks, and local tooling.

## Project Structure

- **Main branch:** shared onboarding and repository documentation
- **Runnable branches:** `uv` and `poetry`
- **Source code on runnable branches:** `src/python_project_template/`
- **Tests on runnable branches:** `tests/`
- **Configuration:** branch-specific (`uv` or `poetry`)
- **Optional task runner:** [Justfile](https://just.systems/man/en/) when present
- **Optional pre-commit hooks:** `pre-commit run --all-files` when configured

## Supported Package Managers

| Branch | Description | Package Manager |
| --- | --- | --- |
| `uv` | High-performance package and project management. | [uv](https://docs.astral.sh/uv/) |
| `poetry` | Dependency management and packaging workflow. | [Poetry](https://python-poetry.org/) |

If you are viewing this in a fork, ensure branch names and remote URLs match your
repository.

## Resources

- [uv documentation](https://docs.astral.sh/uv/)
- [Ruff documentation](https://docs.astral.sh/ruff/)
- [Poetry documentation](https://python-poetry.org/)
- [Justfile documentation](https://just.systems/man/en/)
- [Gitignore generator](https://www.toptal.com/developers/gitignore)

## Template Inspirations

This project is inspired by:

- [asmitul/python-package-template](https://github.com/asmitul/python-package-template/tree/main)
- [alvarobartt/python-package-template](https://github.com/alvarobartt/python-package-template)
- [Diapolo10/python-poetry-template](https://github.com/Diapolo10/python-poetry-template/tree/main)
- [smarlhens/python-boilerplate](https://github.com/smarlhens/python-boilerplate/tree/main)
