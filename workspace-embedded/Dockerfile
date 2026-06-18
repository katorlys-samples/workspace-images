FROM katorlys/workspace-c:latest

# Run as root
USER root

# Install embedded development tools
RUN DEBIAN_FRONTEND="noninteractive" apt-get update -y && apt-get install -y --no-install-recommends \
    binutils-arm-none-eabi \
    device-tree-compiler \
    dfu-util \
    gcc-arm-none-eabi \
    gdb-multiarch \
    libhidapi-dev \
    libncurses-dev \
    libnewlib-arm-none-eabi \
    libssl-dev \
    libusb-dev \
    openocd \
    picocom \
    qemu-system && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Set back to non-root user
USER dev