
## Python Project Template 🐍

This repository provides a modern Python project structure with support for two package managers: [uv](https://docs.astral.sh/uv/) and [Poetry](https://python-poetry.org/). It is designed for rapid prototyping, clean organization, and developer productivity.

### Project Structure
- **Source code:** `src/python_project_template/`
- **Tests:** `tests/`
- **Configuration:** Managed by either `uv` or `Poetry` (see branch)
- **Task runner:** Uses [Justfile](https://just.systems/man/en/) for automation
- **Pre-commit hooks:** Run with `pre-commit run --all-files`

### Supported Package Managers

|   Branch | Description | Package Manager |
| --- | --- | --- |
| [uv branch](https://github.com/difegam/python-project-template/tree/uv) | High-performance Python package/project manager written in Rust. Replaces pip, poetry, pyenv, and virtualenv. | [uv](https://docs.astral.sh/uv/) |
| [poetry branch](https://github.com/difegam/python-project-template/tree/poetry) | Dependency management and packaging for Python projects. | [Poetry](https://python-poetry.org/) |

### Resources

- [uv documentation](https://docs.astral.sh/uv/)
- [Ruff documentation](https://docs.astral.sh/ruff/)
- [Poetry documentation](https://python-poetry.org/)
- [Justfile documentation](https://just.systems/man/en/)
- [Gitignore generator](https://www.toptal.com/developers/gitignore)

### Template Inspirations

This project is inspired by:
- https://github.com/asmitul/python-package-template/tree/main
- https://github.com/alvarobartt/python-package-template
- https://github.com/Diapolo10/python-poetry-template/tree/main
- https://github.com/smarlhens/python-boilerplate/tree/main
- https://github.com/smarlhens/python-boilerplate/tree/main
