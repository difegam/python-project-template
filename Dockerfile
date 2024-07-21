# Use an official Python runtime as a parent image
FROM python:3.10-slim-buster

# Set the environment variable for the application user
ARG APP_USER=appuser

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set work directory
WORKDIR /app

# Install Poetry
RUN pip install --no-cache-dir poetry

# Copy only requirements to cache them in docker layer
COPY pyproject.toml poetry.lock* /app/

# Project initialization:
RUN poetry config virtualenvs.create false \
    && poetry install --no-root --no-dev

# Copy project
COPY . /app

# Create a non-root user and switch to it
RUN useradd -m ${APP_USER}
USER ${APP_USER}

# Run the application
CMD ["poetry", "run", "app"]
