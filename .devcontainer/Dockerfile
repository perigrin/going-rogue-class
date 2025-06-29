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
    xauth \
    && rm -rf /var/lib/apt/lists/*

# Install cpanminus and required modules
RUN cpanm Carton
