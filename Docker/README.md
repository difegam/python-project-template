# Python Docker Image


## Build

### Python Base Image
first build the base image for python
```bash
docker build Docker/pythonbase/ -t python-base:latest
```

### Application Image
From the root directory, build the application image running the following command:

```bash
docker build -t {{APP_IMAGE}}:{{tag}} -f Docker/app/Dockerfile .
```
The `{{APP_IMAGE}}` is the name of the image and `{{tag}}` is the version of the image.

Command explanation:
- `-t` is the tag of the image
- `-f` is the path to the Dockerfile
- `.` is the context of the build (root directory)

It is important the command from the root directory because the Dockerfile uses the `COPY` command to copy the application files to the image from `src/python_project_template` directory.

### Run the image
To run the image, use the following command:

```bash
docker run --rm python-app -l 10
```
The `--rm` flag removes the container after it stops running. The `-l 10` is an argument to the application that prints the first 10 pokemon's from the API. See [entrypoint][entrypoint-vs-cmd] in the Dockerfile for more information.

[entrypoint-vs-cmd]: https://spacelift.io/blog/docker-entrypoint-vs-cmd

## Build image with Docker Compose
To build the image using Docker Compose, run the following command:

```bash
docker compose -f docker-compose.yml build
```
You can test the image by running `docker compose -f docker-compose.yml up`



## Reference
- [Using uv in Docker](https://docs.astral.sh/uv/guides/integration/docker/)
- [Docker images using uv's python](https://mkennedy.codes/posts/python-docker-images-using-uv-s-new-python-features/?featured_on=pythonbytes)
- [Production-ready Python Docker Containers with uv](https://hynek.me/articles/docker-uv/)
