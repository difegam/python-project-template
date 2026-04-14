# =============================================================================
# Stage 1: Build
# =============================================================================
FROM python:3.12-slim AS build

SHELL ["sh", "-exc"]

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=UTC \
    POETRY_HOME=/opt/poetry \
    POETRY_VIRTUALENVS_IN_PROJECT=true \
    POETRY_NO_INTERACTION=1 \
    PATH=/opt/poetry/bin:$PATH

RUN apt-get update -qy && apt-get upgrade -y && \
    apt-get install -qyy --no-install-recommends \
    curl \
    gcc \
    python3-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir poetry==2.3.4

WORKDIR /app

# Copy dependency files first for layer caching
COPY pyproject.toml poetry.lock ./

# Install only runtime dependencies first
RUN --mount=type=cache,target=/root/.cache \
    poetry install --only main --no-root --no-ansi

# Copy the full source code
COPY . /app

# Install project package into in-project virtualenv
RUN --mount=type=cache,target=/root/.cache \
    poetry install --only main --no-ansi

# =============================================================================
# Stage 2: Runtime
# =============================================================================
FROM python:3.12-slim AS runtime

SHELL ["sh", "-exc"]

RUN apt-get update -qy && apt-get upgrade -y && \
    apt-get install -qyy --no-install-recommends \
    curl \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

ENV PATH="/app/.venv/bin:$PATH" \
    APP_USER=appuser \
    APP_GROUP=appuser \
    APP_ID=1001

RUN groupadd -g ${APP_ID} ${APP_GROUP} && \
    useradd -u ${APP_ID} -g ${APP_GROUP} \
    -m -d /home/${APP_USER} \
    -s /bin/bash ${APP_USER}

COPY --from=build --chown=${APP_USER}:${APP_GROUP} /app /app

WORKDIR /app

USER ${APP_USER}

ENTRYPOINT ["app"]
CMD ["--limit", "10"]
