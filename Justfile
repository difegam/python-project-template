set windows-shell := ["powershell.exe", "-NoLogo", "-Command"]
set dotenv-load := true

# Available recipes
_default:
    @just --list --unsorted --list-prefix "    > " --justfile {{justfile()}}

# 📦 Create a requirements.txt from pyproject.toml
export-requirements:
    @echo "Exporting requirements"
    uv pip compile pyproject.toml -o requirements.txt

# 🐳 Build python base image
docker-build-base *ARGS:
    @echo "Building python base image"
    @./Docker/scripts/build.sh --base {{ARGS}}

# 🐳 Build app image
docker-build-app *ARGS:
    @echo "Building app image"
    @./Docker/scripts/build.sh --app {{ARGS}}

# 🐳 Build docker images
docker-build *ARGS:
    @echo "Building docker images"
    @./Docker/scripts/build.sh {{ARGS}}
