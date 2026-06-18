FROM katorlys/workspace-base:latest

# Run as root
USER root

# Install C & C++
RUN add-apt-repository ppa:ubuntu-toolchain-r/test && \
    DEBIAN_FRONTEND="noninteractive" apt-get update -y && apt-get install -y --no-install-recommends \
    ccache \
    clang \
    clangd \
    clang-format \
    clang-tidy \
    clang-tools \
    cmake \
    cppcheck \
    gcc \
    gdb \
    g++ \
    lldb \
    libc6-dbg \
    make \
    ninja-build \
    pkg-config \
    valgrind && \
    # Clean up to reduce image size
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Set back to non-root user
USER dev