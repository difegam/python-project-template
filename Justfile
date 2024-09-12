set windows-shell := ["powershell.exe", "-NoLogo", "-Command"]
set dotenv-load := true

PYTHON_BASE_IMAGE := "python-base"
APP_IMAGE := "python-app"

# Available recipes
_default:
    @just --list --unsorted --list-prefix "    > " --justfile {{justfile()}}

# 🐳 Build python base image
docker-build-python tag="latest":
    @echo "Building python base image"
    @docker build Docker/pythonbase/ -t {{PYTHON_BASE_IMAGE}}:{{tag}}

# 🐳 Build app image
docker-build-app tag="latest":
    @echo "Building app image"
    @docker build -t {{APP_IMAGE}}:{{tag}} -f Docker/app/Dockerfile .

# 🐳 Build docker images
docker-build tag="latest":
    @just docker-build-python {{tag}}
    @just docker-build-app {{tag}}
