#!/bin/bash

# Script directory
SCRIPT_DIR="$(
    cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit 1
    pwd -P
)"

PROJECT_DIR=$(realpath "${SCRIPT_DIR}/../")

# DOCKER FILES
PYTHON_BASE_DOCKER_FILE="${PROJECT_DIR}/Docker/pythonbase/Dockerfile"
APP_DOCKER_FILE="${PROJECT_DIR}/Docker/app/Dockerfile"

# Build Docker images for the Python base and app.
PYTHON_BASE_IMAGE="python-base:latest"
PYTHON_APP_IMAGE="python-app:latest"

# Check if the Python base exists and build it if it doesn't.
if [ -z "$(docker images -q $PYTHON_BASE_IMAGE 2>/dev/null)" ]; then
    docker build \
        -quiet \
        -t python-base:latest \
        -f "${PYTHON_BASE_DOCKER_FILE}" . >/dev/null
fi

# Check if the Python app exists and build it if it doesn't.
if [ -z "$(docker images -q $PYTHON_APP_IMAGE 2>/dev/null)" ]; then
    docker build \
        -quiet \
        -t python-app:latest \
        -f "${APP_DOCKER_FILE}" . >/dev/null
fi

# Run the Python app entrypoint and pass any arguments.
docker run --rm "$PYTHON_APP_IMAGE" "$@"
