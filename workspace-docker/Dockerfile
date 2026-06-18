FROM katorlys/workspace-base:latest

# Run as root
USER root

RUN DEBIAN_FRONTEND="noninteractive" apt-get update -y && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl && \
    install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc && \
    chmod a+r /etc/apt/keyrings/docker.asc && \
    echo "Types: deb" > /etc/apt/sources.list.d/docker.sources && \
    echo "URIs: https://download.docker.com/linux/ubuntu" >> /etc/apt/sources.list.d/docker.sources && \
    echo "Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")" >> /etc/apt/sources.list.d/docker.sources && \
    echo "Components: stable" >> /etc/apt/sources.list.d/docker.sources && \
    echo "Signed-By: /etc/apt/keyrings/docker.asc" >> /etc/apt/sources.list.d/docker.sources && \
    apt-get update -y && \
    apt-get install -y --no-install-recommends docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin && \
    # Install crun (https://github.com/containers/crun) for better DinD support
    CRUN_VERSION=$(curl -sL "https://api.github.com/repos/containers/crun/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/') && \
    curl -fsSL "https://github.com/containers/crun/releases/download/${CRUN_VERSION}/crun-${CRUN_VERSION}-linux-amd64" -o /usr/bin/crun && \
    chmod +x /usr/bin/crun && \
    # Use crun as default runtime
    mkdir -p /etc/docker && \
    printf '{\n  "default-runtime": "crun",\n  "runtimes": {\n    "crun": {\n      "path": "/usr/bin/crun"\n    }\n  }\n}\n' > /etc/docker/daemon.json && \
    # Allow non-root user to use docker
    usermod -aG docker dev && \
    # Install dive (https://github.com/wagoodman/dive)
    DIVE_VERSION=$(curl -sL "https://api.github.com/repos/wagoodman/dive/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/') && \
    curl -OL https://github.com/wagoodman/dive/releases/download/v${DIVE_VERSION}/dive_${DIVE_VERSION}_linux_amd64.deb && \
    apt install ./dive_${DIVE_VERSION}_linux_amd64.deb && \
    rm dive_${DIVE_VERSION}_linux_amd64.deb && \
    # Install Slim (https://github.com/slimtoolkit/slim)
    curl -sL https://raw.githubusercontent.com/slimtoolkit/slim/master/scripts/install-slim.sh | bash - && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Start Docker daemon on startup
COPY entrypoint.sh /usr/local/bin/
COPY entrypoint.sh /workspace/
RUN chmod +x /usr/local/bin/entrypoint.sh /workspace/entrypoint.sh

# Switch back to non-root user
USER dev

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/bin/bash"]