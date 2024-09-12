# Stage 1: Linux Base
FROM ubuntu:latest AS linux-base

# Set non-interactive to prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive
ENV DEBIAN_PRIORITY=critical

# Set the default shell to bash
SHELL ["/bin/sh", "-exc"]

# Update and install essential packages
RUN apt-get update -qy && apt-get upgrade -y && \
    apt-get install -qyy --no-install-recommends \
    ca-certificates \
    openssl \
    build-essential \
    locales \
    gcc \
    wget \
    curl \
    git

# Set the locale
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# Set the time zone to UTC
ENV TZ=UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Remove unnecessary packages
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Stage 2: Python Base
FROM linux-base AS python-base

RUN mkdir /app

ENV PATH=/venv/bin:$PATH
ENV PATH=/root/.cargo/bin:$PATH

# Install uv
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

# Set the virtual environment directory
ENV PYTHON_VERSION=3.12.5
ENV VIRTUAL_ENV=/venv
RUN uv venv --python $PYTHON_VERSION ${VIRTUAL_ENV}

# Set the virtual environment as the default python environment
RUN echo "\nsource ${VIRTUAL_ENV}/bin/activate\n" >> /root/.zshrc
RUN uv --version

RUN ${VIRTUAL_ENV}/bin/python --version

CMD ["python", "--version"]
