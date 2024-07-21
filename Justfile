set windows-shell := ["powershell.exe", "-NoLogo", "-Command"]
set dotenv-load := true

PYMODULE := "project_name"
POETRY_URL := "https://python-poetry.org/docs/#enable-tab-completion-for-bash-fish-or-zsh"

# Available recipes
_default:
    @just --list --unsorted --list-prefix "    > " --justfile {{justfile()}}

# Install dependencies
install:
    #!/usr/bin/env bash
    echo "Installing dependencies manager..."
    # Check if poetry is installed
    if ! command -v poetry &> /dev/null; then
        echo "📦 Installing poetry..."
        # Install poetry
        curl -sSL https://install.python-poetry.org | python3 -
        echo "🌐 Opening browser..."
        python3 -m webbrowser -t {{ POETRY_URL }}
    else
        echo "📦 Poetry is already installed."
    fi
    # Install dependencies
    echo "📦 Installing dependencies..."
    poetry install
    poetry run pre-commit install
    poetry run poetry-dynamic-versioning

# 🐳 Build docker image
docker-build:
    docker build -t pytemplate .
