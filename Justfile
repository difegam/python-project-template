set windows-shell := ["powershell.exe", "-NoLogo", "-Command"]
set dotenv-load := true

# Available recipes
@_:
    echo "Led Controller\n"
    just --list

# Run the application locally
[group("run")]
run:
    uv run app

# Run linter and formatter
[group("qa")]
lint:
    uv run ruff check
    uv run ruff format

# Run pre-commit hooks on all files
[group('qa')]
check:
    @echo "Running pre-commit hooks on all files"
    @uv run pre-commit run --all-files

# Format in all files
[group('qa')]
docstring-format *ARGS:
    @echo "Running docstring formatter"
    @echo "To fix docstring format, add '--in-place' to the command"

# Run Tests
[group('qa')]
test:
    echo "🧪 Testing app...! "
    @uv run pytest -vv --tb=short -s tests/

# Create a requirements.txt from pyproject.toml
[group('development')]
export-requirements:
    @echo "Exporting requirements"
    uv pip compile pyproject.toml -o requirements.txt

# Build python base image
[group('docker')]
build-base *ARGS:
    @echo "Building python base image"
    @./Docker/scripts/build.sh --base {{ARGS}}

# Build app image
[group('docker')]
build-app *ARGS:
    @echo "Building app image"
    @./Docker/scripts/build.sh --app {{ARGS}}

# Build docker images
[group('docker')]
build *ARGS:
    @echo "Building docker images"
    @./Docker/scripts/build.sh {{ARGS}}

# 🐳 “Dive” is a tool that helps you explore a Docker image, examine its layers, and find ways to reduce its size.
[group('docker')]
dive *ARGS:
    @echo "Exploring docker image"
    @docker run -ti --rm  -v /var/run/docker.sock:/var/run/docker.sock wagoodman/dive {{ARGS}}

# Ensure project virtualenv is up to date
[group("development")]
install:
    @echo "📦 Installing the application for development"
    uv sync --all-groups
    uv run pre-commit install
    @echo "\n✅ Setup complete, ready to code 🚀"

# Update dependencies
[group("development")]
update:
    uv sync --all-groups

# Remove temporary files
[group("development")]
clean:
    rm -rf .venv .pytest_cache .mypy_cache .ruff_cache .coverage htmlcov
    find . -type d -name "__pycache__" -exec rm -r {} +

# Recreate project virtualenv from nothing
[group("development")]
fresh: clean install
    @echo "✅ Fresh setup complete, ready to code 🚀"
