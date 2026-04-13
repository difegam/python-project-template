# =============================================================================
# Stage 1: Build
# =============================================================================
FROM python:3.12-slim AS build

# Set the default shell
SHELL ["sh", "-exc"]

ENV PYTHON_VERSION=python3.12 \
    DEBIAN_FRONTEND=noninteractive \
    TZ=UTC

# Install build dependencies
RUN apt-get update -qy && apt-get upgrade -y && \
    apt-get install -qyy --no-install-recommends \
    curl \
    gcc \
    python3-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /usr/local/bin/uv

# Set environment variables for uv
ENV UV_LINK_MODE=copy \
    UV_COMPILE_BYTECODE=1 \
    UV_PYTHON_DOWNLOADS=never \
    UV_PYTHON=${PYTHON_VERSION} \
    UV_PROJECT_ENVIRONMENT=/app

# Copy dependency files first for layer caching
COPY pyproject.toml uv.lock ./

# Install dependencies (without the project itself)
RUN --mount=type=cache,target=/root/.cache \
    uv sync \
    --locked \
    --no-install-project

# Copy the full source code
COPY . /app
WORKDIR /app

# Install the project (production deps only, no editable install)
RUN --mount=type=cache,target=/root/.cache \
    uv sync \
    --locked \
    --no-dev \
    --no-editable

# =============================================================================
# Stage 2: Runtime
# =============================================================================
FROM python:3.12-slim AS runtime

# Set the default shell
SHELL ["sh", "-exc"]

# Install minimal runtime dependencies
RUN apt-get update -qy && apt-get upgrade -y && \
    apt-get install -qyy --no-install-recommends \
    curl \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV PATH="/app/bin:$PATH" \
    APP_USER=appuser \
    APP_GROUP=appuser \
    APP_ID=1001

# Create non-root user
RUN groupadd -g ${APP_ID} ${APP_GROUP} && \
    useradd -u ${APP_ID} -g ${APP_GROUP} \
    -m -d /home/${APP_USER} \
    -s /bin/bash ${APP_USER}

# Copy the application from the build stage
COPY --from=build --chown=${APP_USER}:${APP_GROUP} /app /app

# Set the working directory
WORKDIR /app

# Switch to non-root user
USER ${APP_USER}

# Run the application
ENTRYPOINT ["app"]
CMD ["--limit", "10"]
