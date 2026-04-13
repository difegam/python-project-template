#!/bin/bash
#
# Run the application inside a Docker container.
#
# Checks whether the target image exists locally and builds it automatically
# if it does not. Passes all arguments through to the container entrypoint.
#
# Requirements:
#   - docker installed and available on PATH
#
# Usage: run.sh [ARGS...]

set -euo pipefail

# Script directory
SCRIPT_DIR="$(
    cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit 1
    pwd -P
)"

PROJECT_DIR="$(cd "${SCRIPT_DIR}/../../" && pwd -P)"

# DOCKER FILE
APP_DOCKER_FILE="${PROJECT_DIR}/Docker/Dockerfile"

# Docker image
PYTHON_APP_IMAGE="python-app:latest"

# Check for docker
if ! command -v docker &>/dev/null; then
    echo "Error: docker is not installed or not in PATH."
    exit 1
fi

# Check if the app image exists and build it if it doesn't.
if [ -z "$(docker images -q "$PYTHON_APP_IMAGE" 2>/dev/null)" ]; then
    docker build \
        -q \
        -t "$PYTHON_APP_IMAGE" \
        -f "${APP_DOCKER_FILE}" "$PROJECT_DIR"
fi

# Run the app and pass any arguments.
docker run --rm "$PYTHON_APP_IMAGE" "$@"
