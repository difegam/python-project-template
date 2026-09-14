# Python Project Template 🐍

A batteries-included starting point for Python 3.12+ projects with a curated
toolchain: [uv](https://docs.astral.sh/uv/) for package management,
[ruff](https://docs.astral.sh/ruff/) for linting and formatting,
[mypy](https://mypy.readthedocs.io/), [ty](https://docs.astral.sh/ty/), or
[pyrefly](https://pyrefly.org/) for type-checking (choose one),
[pytest](https://docs.pytest.org/) for testing, and
[prek](https://prek.j178.dev/) for Git hooks — all wired together with
[just](https://just.systems/) recipes.

## Prerequisites

Install the following tools before cloning:

| Tool                             | Purpose         | Install                                                                          |
| -------------------------------- | --------------- | -------------------------------------------------------------------------------- |
| Python 3.12+                     | Runtime         | [python.org](https://www.python.org/downloads/) or `uv python install 3.12`      |
| [uv](https://docs.astral.sh/uv/) | Package manager | [uv docs](https://docs.astral.sh/uv/getting-started/installation/)               |
| [just](https://just.systems/)    | Task runner     | `brew install just` / [other options](https://just.systems/man/en/packages.html) |

> **Windows:** `just` is fully supported via PowerShell — the
> `justfile` sets `windows-shell` automatically.

## Quickstart

```bash
git clone https://github.com/difegam/python-project-template
cd python-project-template
rm -rf .git      # optional: remove git history for a clean slate
just init        # install deps + prek hooks
just run         # run the application
```

## Choices and defaults

This template includes two optional tools that require a decision:

### Git hooks

**prek** (default) is the active hook runner — configured in `prek.toml`.
An alternative **pre-commit** config is maintained in
[`docs/.pre-commit-config.yaml`](docs/.pre-commit-config.yaml) for reference
or if you prefer pre-commit over prek.

### Type checker

Pick **one** — running multiple type checkers on the same codebase produces
conflicting noise:

| Tool | Config | Recipe | Notes |
| --- | --- | --- | --- |
| [mypy](https://mypy.readthedocs.io/) | `mypy.ini` | `just type-check-mypy` | Runs automatically as a pre-push hook |
| [ty](https://docs.astral.sh/ty/) | `ty.toml` | `just type-check-ty` | |
| [pyrefly](https://pyrefly.org/) | `pyrefly.toml` | `just type-check-pyrefly` | |

All three are installed as dev dependencies so the choice is which one to
**run**, not which one to install.

## Development

Run `just` (no arguments) to list all available recipes.

| Recipe              | Description                                                           |
| ------------------- | --------------------------------------------------------------------- |
| `just init`         | Install dependencies and prek hooks                                   |
| `just run`          | Run the application locally                                           |
| `just test`         | Run the test suite                                                    |
| `just lint`         | Auto-fix lint issues and format code with ruff                        |
| `just check`        | Run all prek hooks on every file                                      |
| `just type-check-pyrefly` | Type-check with pyrefly (see [type checker choice](#type-checker)) |
| `just hooks-update` | Update hook revisions with a 7-day cooldown                           |
| `just update`       | Upgrade and re-lock all dependencies                                  |
| `just clean`        | Remove `.venv`, caches, and `__pycache__` directories                 |
| `just fresh`        | Full clean slate: `clean` + `init` + prek cache reset                 |
| `just docker *`     | Delegate to Docker recipes (see [Docker/README.md](Docker/README.md)) |

## Testing and code quality

```bash
just test     # pytest
just lint     # ruff check --fix + ruff format
just check    # prek run --all-files (ruff, shellcheck, detect-secrets, …)
```

### Type-checking

Type-checking is provided by three tools — choose **one**:

- **mypy** (configured in `mypy.ini`): runs as a pre-push hook via
    `just type-check-mypy`.
- **ty** (configured in `ty.toml`): run with `just type-check-ty`.
- **pyrefly** (configured in `pyrefly.toml`): run with `just type-check-pyrefly`.

Running more than one produces conflicting noise — stick with the one you
prefer and remove the others from `pyproject.toml` dev-dependencies if you
want a cleaner install.

## Docker

See [Docker/README.md](Docker/README.md) for full build and run instructions.
Quick reference:

```bash
just docker build                          # build image
docker run --rm python-app:latest          # run with defaults
docker run --rm python-app:latest --limit 5
docker compose up                          # build + run via Compose
```

## Package management

This project uses [uv](https://docs.astral.sh/uv/) as a package manager.

This template intentionally sets `exclude-newer = "P7D"` under `[tool.uv]` in
`pyproject.toml` as a dependency cooldown to reduce exposure to newly published
supply-chain attacks. See
[ADR 0001](docs/architecture/0001-adopt-uv-dependency-cooldowns-with-exclude-newer.md)
for the rationale and trade-offs, including the related
[PyPI incident report](https://blog.pypi.org/posts/2026-04-02-incident-report-litellm-telnyx-supply-chain-attack/).

### Install a Python version

```bash
uv python install <version>
```

### Create a virtual environment

```bash
uv venv
```

### Add a dependency

```bash
uv add <package>
```

### Remove a dependency

```bash
uv remove <package>
```

### Add a development dependency

```bash
uv add <package> --dev
```

See the [uv documentation](https://docs.astral.sh/uv/) for more information.

## Resources

- [python-package-template by asmitul](https://github.com/asmitul/python-package-template/tree/main)
- [python-package-template by alvarobartt](https://github.com/alvarobartt/python-package-template)
- [python-poetry-template by Diapolo10](https://github.com/Diapolo10/python-poetry-template/tree/main)
- [python-boilerplate by smarlhens](https://github.com/smarlhens/python-boilerplate/tree/main)
