# Python Docker Image

Multi-stage Dockerfile using `python:3.12-slim` with [uv](https://docs.astral.sh/uv/) for dependency management and a non-root runtime user.

## Build

From the project root directory, build the application image:

```bash
docker build -t python-app:latest -f Docker/Dockerfile .
```

Or using the build script:

```bash
Docker/scripts/build.sh
```

Or using just:

```bash
just docker build
```

## Run

Run the image with default arguments (`--limit 10`):

```bash
docker run --rm python-app:latest
```

Override the default arguments:

```bash
docker run --rm python-app:latest --limit 5
```

The `--rm` flag removes the container after it stops running. The `--limit` argument controls how many items to fetch from the API. See [ENTRYPOINT vs CMD][entrypoint-vs-cmd] for more information.

[entrypoint-vs-cmd]: https://spacelift.io/blog/docker-entrypoint-vs-cmd

## Build and Run with Docker Compose

```bash
docker compose build
docker compose up
```

## Reference

- [Using uv in Docker](https://docs.astral.sh/uv/guides/integration/docker/)
- [Docker images using uv's python](https://mkennedy.codes/posts/python-docker-images-using-uv-s-new-python-features/?featured_on=pythonbytes)
- [Production-ready Python Docker Containers with uv](https://hynek.me/articles/docker-uv/)
