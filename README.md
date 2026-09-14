# Python Project Template 🐍

A batteries-included starting point for Python 3.12+ projects with a curated
toolchain: [uv](https://docs.astral.sh/uv/) for package management,
[ruff](https://docs.astral.sh/ruff/) for linting and formatting,
[pyrefly](https://pyrefly.org/) for type-checking,
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

Defaults are wired in the Justfile and hooks. Each can be swapped —
snippets below.

### Git hooks

| Option          | Runner                                | Config                         | Setup                                   | Run                          |
| --------------- | ------------------------------------- | ------------------------------ | --------------------------------------- | ---------------------------- |
| **A (default)** | [prek](https://prek.j178.dev/)        | `prek.toml`                    | `just init`                             | `just check`                 |
| **B**           | [pre-commit](https://pre-commit.com/) | `docs/.pre-commit-config.yaml` | copy to root, then `pre-commit install` | `pre-commit run --all-files` |

> **Both runners can read either file:**
> `uv run prek run --config docs/.pre-commit-config.yaml --all-files`

Keep whichever file you choose in sync when bumping hook revisions.

### Type checker

Default: [pyrefly](https://pyrefly.org/) — `just type-check`,
pre-push hook via `prek.toml`.

| Tool                  | Config         | Recipe                 | Hooks    |
| --------------------- | -------------- | ---------------------- | -------- |
| **pyrefly (default)** | `pyrefly.toml` | `just type-check`      | pre-push |
| mypy                  | `mypy.ini`     | `just type-check-mypy` | pre-push |
| ty                    | `ty.toml`      | `just type-check-ty`   | pre-push |

**Swap to mypy** — replace the recipe and hook:

```toml
# Justfile
type-check:
    uv run mypy src/python_project_template/
```

```toml
# prek.toml (local hook)
id = "mypy"
entry = "uv run mypy"
args = [
  "--config-file=./mypy.ini",
  "--install-types",
  "--non-interactive",
  "src/",
]
```

**Swap to ty** — same pattern:

```toml
# Justfile
type-check:
    uv run ty check
```

```toml
# prek.toml (local hook)
id = "ty"
entry = "uv run ty check"
```

Remove the tools you don't use from `pyproject.toml` dev-dependencies.

### Spell checker

Default: [typos](https://github.com/crate-ci/typos) — runs on every commit.

**Swap to codespell** — replace the hook block in `prek.toml`:

```toml
[[repos]]
repo = "https://github.com/codespell-project/codespell"
rev = "v2.4.3"

[[repos.hooks]]
id = "codespell"
name = "detect common misspellings"
files = "^.*\\.(py|c|h|md|rst|ya?ml|toml)$"
additional_dependencies = ["tomli"]
```

## Development

Run `just` (no arguments) to list all available recipes.

| Recipe              | Description                                                           |
| ------------------- | --------------------------------------------------------------------- |
| `just init`         | Install dependencies and prek hooks                                   |
| `just run`          | Run the application locally                                           |
| `just test`         | Run the test suite                                                    |
| `just lint`         | Auto-fix lint issues and format code with ruff                        |
| `just check`        | Run all prek hooks on every file                                      |
| `just type-check`   | Type-check with pyrefly (see [type checker choice](#type-checker))    |
| `just hooks-update` | Update hook revisions with a 7-day cooldown                           |
| `just update`       | Upgrade and re-lock all dependencies                                  |
| `just clean`        | Remove `.venv`, caches, and `__pycache__` directories                 |
| `just fresh`        | Full clean slate: `clean` + `init` + prek cache reset                 |
| `just docker *`     | Delegate to Docker recipes (see [Docker/README.md](Docker/README.md)) |

## Testing and code quality

```bash
just test       # pytest
just lint       # ruff check --fix + ruff format
just check      # prek run --all-files (ruff, shellcheck, typos, detect-secrets, …)
just type-check # pyrefly check
```

See [Choices and defaults](#choices-and-defaults) for swap-in instructions
for mypy, ty, or codespell.

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
