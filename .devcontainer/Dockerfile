FROM perl:latest

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies for raylib
RUN apt-get update && apt-get install -y \
    libasound2-dev \
    libxcursor-dev \
    libxinerama-dev \
    mesa-common-dev \
    libx11-dev \
    libxrandr-dev \
    libxi-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Install cpanminus and required modules
RUN cpanm App::cpm \
    && mkdir -p /workspace

# Install modified Alien::raylib
WORKDIR /workspace

# Create a non-root user for development
ARG USERNAME=developer
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && chown -R $USERNAME:$USERNAME /workspace

# Switch to the developer user
USER $USERNAME
