#!/bin/bash
#
# Build Docker images for the Python base and app.
#
# The `docker build` command uses the following options:
#
#   --no-cache          Build images without using cache. Use cache by default.
#   -q                  Suppress the build output and print image ID
#   -t                  Name and optionally a tag in the 'name:tag' format
#   -f                  Name of the Dockerfile
#   .                   Build context (current directory)

# Script directory
SCRIPT_DIR="$(
    cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit 1
    pwd -P
)"

PROJECT_DIR=$(realpath "${SCRIPT_DIR}/../../")

# DOCKER FILES
PYTHON_BASE_DOCKER_FILE="${PROJECT_DIR}/Docker/pythonbase/Dockerfile"
APP_DOCKER_FILE="${PROJECT_DIR}/Docker/app/Dockerfile"

# Function to display usage information
usage() {
    echo "Usage: $0 [OPTIONS]"
    echo "Options:"
    echo "  --base                  Build Docker Python base image"
    echo "  --app                   Build Docker app image"
    echo "  --base-name NAME        Set custom name for base image (default: python-base)"
    echo "  --base-tag TAG          Set custom tag for base image (default: latest)"
    echo "  --app-name NAME         Set custom name for app image (default: python-app)"
    echo "  --app-tag TAG           Set custom tag for app image (default: latest)"
    echo "  --no-cache              Build images without using cache"
    echo "  -q                      Suppress the build output and print image ID"
    echo "  -h, --help              Display this help message"
}

# Function to build Docker image
build_image() {
    local docker_file=$1
    local name=$2
    local tag=${3:-"latest"}
    local no_cache=$4
    local quiet=$5

    if [ -f "$docker_file" ]; then
        echo -e "🐳 Building Docker image ${name}:${tag}..."
        docker build $no_cache $quiet -t "${name}:${tag}" -f "$docker_file" . >/dev/null
        return 0
    fi
    echo "Error: Dockerfile $docker_file not found."
    exit 1
}

# Initialize variables
build_base=false
build_app=false

# Default values
base_name="python-base"
base_tag="latest"
app_name="python-app"
app_tag="latest"

# Option
no_cache=""
no_output=""

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
    --base)
        build_base=true
        shift
        ;;
    --app)
        build_app=true
        shift
        ;;
    --base-name)
        base_name="$2"
        shift 2
        ;;
    --base-tag)
        base_tag="$2"
        shift 2
        ;;
    --app-name)
        app_name="$2"
        shift 2
        ;;
    --app-tag)
        app_tag="$2"
        shift 2
        ;;
    --no-cache)
        no_cache="--no-cache"
        shift
        ;;
    -q)
        no_output="-q"
        shift
        ;;
    -h | --help)
        usage
        exit 0
        ;;
    *)
        echo "Unknown option: $1"
        usage
        exit 1
        ;;
    esac
done

# Check if at least one option is provided
if ! $build_base && ! $build_app; then
    echo -e "↳ No option provided. Building all images. \n"
    build_base=true
    build_app=true
fi

# Build images based on the provided options
if $build_base; then
    build_image "$PYTHON_BASE_DOCKER_FILE" "$base_name" "$base_tag" "$no_cache" "$no_output"
fi

if $build_app; then
    build_image "$APP_DOCKER_FILE" "$app_name" "$app_tag" "$no_cache" "$no_output"
fi

# Display the list of images
echo -e "\nList of Docker images:"
docker images | grep -E "REPOSITORY|${base_name}|${app_name}"

echo -e "\nBuild process completed."
