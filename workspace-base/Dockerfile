# Use the official Ubuntu 24.04 base image
FROM ubuntu:24.04

# Set terminal environment variables
SHELL ["/bin/bash", "-c"]
ENV DEBIAN_FRONTEND=noninteractive

# Run as root
USER root

# Remove default ubuntu user and install baseline packages
RUN userdel -r ubuntu && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    bash-completion \
    build-essential \
    curl \
    fish \
    git \
    git-lfs \
    htop \
    jq \
    locales \
    man-db \
    nano \
    net-tools \
    software-properties-common \
    sudo \
    time \
    unzip \
    vim \
    wget \
    zip \
    zsh && \
    # Clean up installation cache
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Set terminal locale to UTF-8
ENV LANG=en_US.UTF-8

# Add a non-root user `dev`
RUN locale-gen en_US.UTF-8 && \
    useradd -u 10000 -mld /home/dev -s /bin/bash dev && \
    # Set no-password sudo
    echo 'dev ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    # Set workspace directory permissions
    mkdir -p /workspace && chown -hR dev:dev /workspace && \ 
    # Customize bash prompt
    echo -e "PS1='\[\033[01;33m\]\u\[\033[00m\] \[\033[01;34m\]\w\[\033[00m\]\$(__git_ps1 \" (%s)\") $ '" >> /home/dev/.bashrc && \
    echo -e "PS1='\[\033[01;31m\]\u\[\033[00m\] \[@\h\] \[\033[01;34m\]\w\[\033[00m\] # '" >> /root/.bashrc

# Set to `dev` user
USER dev

# Set default workspace directory
WORKDIR /workspace