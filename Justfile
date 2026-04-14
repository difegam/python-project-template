set windows-shell := ["powershell.exe", "-NoLogo", "-Command"]
set dotenv-load := true

mod docker "Docker/docker.just"

[doc("Available recipes")]
[private]
default:
    @just --list --list-submodules

[doc("Initialize the project")]
[group("development")]
init:
    @echo "Initializing the project..."
    @poetry install --all-groups
    @poetry run pre-commit install --install-hooks --hook-type pre-commit --hook-type pre-push
    @echo "Project initialized successfully!"

[doc("Run the application locally")]
[group("application")]
run:
    poetry run app

[doc("Run linter and formatter")]
[group("code-quality")]
lint:
    poetry run ruff check --fix
    poetry run ruff format

[doc("Run pre-commit hooks on all files")]
[group("code-quality")]
check:
    @echo "Running pre-commit hooks on all files"
    @poetry run pre-commit run --all-files

[doc("Run tests")]
[group("code-quality")]
test:
    echo "Testing app..."
    @poetry run pytest --tb=short -s tests/

[doc("Type-check with ty (choose ty OR mypy, not both) - https://docs.astral.sh/ty/")]
[group("code-quality")]
type-check-ty:
    poetry run ty check

[doc("Type-check with mypy (choose mypy OR ty, not both) - https://mypy.readthedocs.io/")]
[group("code-quality")]
type-check-mypy:
    poetry run mypy src/python_project_template/

[doc("Update project dependencies")]
[group("development")]
update:
    poetry lock --regenerate && poetry install --all-groups
    @echo "Dependencies updated successfully"

[doc("Remove temporary files")]
[group("development")]
clean:
    rm -rf .venv .pytest_cache .mypy_cache .ty_cache .ruff_cache .coverage htmlcov
    find . -type d -name "__pycache__" -exec rm -r {} +

[doc("Recreate the virtual environment from scratch")]
[group("development")]
fresh: clean init
    poetry run pre-commit clean
    @echo "Fresh setup complete, ready to code"
