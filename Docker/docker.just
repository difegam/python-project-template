set windows-shell := ["powershell.exe", "-NoLogo", "-Command"]
set dotenv-load := true

# Available recipes
[private]
default:
    just --list

[doc("Build python base image")]
[group("build")]
build-base *ARGS:
    @echo "Building python base image"
    @./Docker/scripts/build.sh --base {{ ARGS }}

[doc("Build app image")]
[group("build")]
build-app *ARGS:
    @echo "Building app image"
    @./Docker/scripts/build.sh --app {{ ARGS }}

[doc("Build docker images")]
[group("build")]
build *ARGS:
    @echo "Building docker images"
    @./Docker/scripts/build.sh {{ ARGS }}

[doc("Explore docker image with Dive")]
[group("operations")]
dive *ARGS:
    @echo "Exploring docker image"
    @docker run -ti --rm  -v /var/run/docker.sock:/var/run/docker.sock wagoodman/dive {{ ARGS }}
