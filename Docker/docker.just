set windows-shell := ["powershell.exe", "-NoLogo", "-Command"]
set dotenv-load := true

# Available recipes
[private]
default:
    just --list

[doc("Build app image")]
[group("build")]
build *ARGS:
    @echo "Building app image"
    @scripts/build.sh {{ ARGS }}

[doc("Explore docker image with Dive")]
[group("operations")]
dive *ARGS:
    @echo "Exploring docker image"
    @docker run -ti --rm  -v /var/run/docker.sock:/var/run/docker.sock wagoodman/dive {{ ARGS }}
