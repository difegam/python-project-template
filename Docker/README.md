## Python Docker Image

Multi-stage Dockerfile using `python:3.12-slim` with Poetry for dependency
management and a non-root runtime user.

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

## Build and Run with Docker Compose

```bash
docker compose build
docker compose up
```

## Reference

- [Poetry documentation](https://python-poetry.org/docs/)
- [Docker ENTRYPOINT vs CMD](https://spacelift.io/blog/docker-entrypoint-vs-cmd)
