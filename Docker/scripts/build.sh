#!/bin/bash
#
# Build the Docker image for the application.
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

# DOCKER FILE
APP_DOCKER_FILE="${PROJECT_DIR}/Docker/Dockerfile"

# Function to display usage information
usage() {
    echo "Usage: $0 [OPTIONS]"
    echo "Options:"
    echo "  --name NAME             Set custom name for the image (default: python-app)"
    echo "  --tag TAG               Set custom tag for the image (default: latest)"
    echo "  --no-cache              Build image without using cache"
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
        docker build $no_cache $quiet -t "${name}:${tag}" -f "$docker_file" "$PROJECT_DIR" >/dev/null
        return 0
    fi
    echo "Error: Dockerfile $docker_file not found."
    exit 1
}

# Default values
app_name="python-app"
app_tag="latest"

# Options
no_cache=""
no_output=""

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
    --name)
        app_name="$2"
        shift 2
        ;;
    --tag)
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

# Build the image
build_image "$APP_DOCKER_FILE" "$app_name" "$app_tag" "$no_cache" "$no_output"

# Display the list of images
echo -e "\nList of Docker images:"
docker images | grep -E "REPOSITORY|${app_name}"

echo -e "\nBuild process completed."
