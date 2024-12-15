set windows-shell := ["powershell.exe", "-NoLogo", "-Command"]
set dotenv-load := true

# Available recipes
_default:
    @just --list --unsorted --list-prefix "    > " --justfile {{justfile()}}

# 🏃🏽‍♂️‍➡️ Run pre-commit hooks manually
[group('dev-tools')]
pre-commit-check:
    @echo "Running pre-commit hooks on all files"
    @pre-commit run --all-files

# Format in all files
[group('dev-tools')]
docstring-format:
    @echo "Checking docstring format, add '--in-place' to fix"
    @uv run docformatter -r src
    @echo "Done"

# 📦 Create a requirements.txt from pyproject.toml
[group('requirements')]
export-requirements:
    @echo "Exporting requirements"
    uv pip compile pyproject.toml -o requirements.txt

# 🐳 Build python base image
[group('docker')]
build-base *ARGS:
    @echo "Building python base image"
    @./Docker/scripts/build.sh --base {{ARGS}}

# 🐳 Build app image
[group('docker')]
build-app *ARGS:
    @echo "Building app image"
    @./Docker/scripts/build.sh --app {{ARGS}}

# 🐳 Build docker images
[group('docker')]
build *ARGS:
    @echo "Building docker images"
    @./Docker/scripts/build.sh {{ARGS}}

# 🐳 “Dive” is a tool that helps you explore a Docker image, examine its layers, and find ways to reduce its size.
[group('docker')]
dive *ARGS:
    @echo "Exploring docker image"
    @docker run -ti --rm  -v /var/run/docker.sock:/var/run/docker.sock wagoodman/dive {{ARGS}}
