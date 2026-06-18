FROM katorlys/workspace-base:latest

# Run as root
USER root

# Install dependencies
RUN DEBIAN_FRONTEND="noninteractive" apt-get update -y && apt-get install -y --no-install-recommends \
    libssl-dev \
    pkg-config && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Set back to non-root user
USER dev

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain stable && \
    export PATH=$HOME/.cargo/bin:$PATH && \
    # Install development tools
    rustup component add rust-src && \
    rustup component add rustfmt && \
    rustup component add clippy && \
    rustup component add rust-analyzer && \
    cargo install cargo-watch && \
    cargo install cargo-edit