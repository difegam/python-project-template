FROM python-base:latest

# Set evnironment variables
ENV VIRTUAL_ENV=/venv
ENV PATH=${VIRTUAL_ENV}/bin:$PATH

# Set python environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set source code directory
ENV PROJECT_SRC_DIR=src/python_project_template

# Copy the virtual environment from the previous stage
COPY --from=python-base ${VIRTUAL_ENV} ${VIRTUAL_ENV}

# Copy the application requirements
COPY ${PROJECT_SRC_DIR}/requirements.txt /app/

# Set the working directory
WORKDIR /app

# Install the application dependencies
RUN --mount=type=cache,target=/root/.cache uv pip install -r requirements.txt
# RUN uv sync --frozen --no-cache

# Copy the application code
COPY ${PROJECT_SRC_DIR} /app

# Run the application
ENTRYPOINT ["python", "app.py"]
