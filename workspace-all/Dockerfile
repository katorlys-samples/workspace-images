FROM katorlys/workspace-base:latest


# !================== Installations that only need non-root ==================
# *------------------ Java ------------------
# The Java version to install: 25.0.1.fx-zulu, 21.0.9.fx-zulu, 17.0.17.fx-zulu, 11.0.29.fx-zulu, 8.0.472.fx-zulu
ARG JAVA_VERSION=25.0.1.fx-zulu

# Install Java, Kotlin, Maven and Gradle
RUN curl -s https://get.sdkman.io | bash && \
    source $HOME/.sdkman/bin/sdkman-init.sh && \
    sdk install java $JAVA_VERSION && \
    sdk default java $JAVA_VERSION && \
    sdk install kotlin && \
    sdk install maven && \
    sdk install gradle && \
    sdk flush archives && \
    sdk flush tmp
# *------------------ End of Java ------------------

# *------------------ Node ------------------
# The Node.js version to install: https://nodejs.org/en/about/previous-releases#looking-for-the-latest-release-of-a-version-branch
ARG NODE_VERSION=24.13.0

# Install nvm
ENV NVM_DIR=/home/dev/.nvm
RUN NVM_VERSION=$(curl -s https://api.github.com/repos/nvm-sh/nvm/releases/latest | jq -r .tag_name) && \
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh | bash && \
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && \
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" && \
    # Install Node.js
    nvm install v${NODE_VERSION} && \
    nvm use v${NODE_VERSION} && \
    nvm alias default v${NODE_VERSION} && \
    nvm cache clear && \
    # Install yarn, pnpm, etc.
    npm install -g yarn pnpm node-gyp typescript && \
    echo "export PATH=$PATH:$HOME/.npm-global/bin:$HOME/.yarn/bin:$HOME/.local/share/pnpm" >> ~/.bashrc && \
    npm cache clean --force
# *------------------ End of Node ------------------
# !================== End of Installations that only need non-root ==================


# !================== Installations that only need root ==================
# Run as root
USER root
# *------------------ C ------------------
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
# *------------------ End of C ------------------

# *------------------ Docker ------------------
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
    apt-get install -y --no-install-recommends ./dive_${DIVE_VERSION}_linux_amd64.deb && \
    rm dive_${DIVE_VERSION}_linux_amd64.deb && \
    # Install Slim (https://github.com/slimtoolkit/slim)
    curl -sL https://raw.githubusercontent.com/slimtoolkit/slim/master/scripts/install-slim.sh | bash - && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Start Docker daemon on startup
COPY entrypoint.sh /usr/local/bin/
COPY entrypoint.sh /workspace/
RUN chmod +x /usr/local/bin/entrypoint.sh /workspace/entrypoint.sh
# *------------------ End of Docker ------------------

# *------------------ Go ------------------
# Install Go
RUN GO_VERSION=$(curl -s https://go.dev/dl/?mode=json | jq -r '.[0].version') && \
    wget https://go.dev/dl/${GO_VERSION}.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf ${GO_VERSION}.linux-amd64.tar.gz && \
    echo 'export PATH="/usr/local/go/bin:$PATH"' >> /etc/bash.bashrc && \
    echo 'export GOPATH="/root/go"' >> /etc/bash.bashrc && \
    echo 'export CGO_ENABLED=1' >> /etc/bash.bashrc && \
    rm ${GO_VERSION}.linux-amd64.tar.gz

# Set environment variables
ENV PATH="/usr/local/go/bin:${PATH}" \
    GOPATH="/root/go" \
    CGO_ENABLED=1

# Install development tools
RUN go install -v github.com/go-delve/delve/cmd/dlv@latest && \
    go install -v github.com/golangci/golangci-lint/cmd/golangci-lint@latest && \
    go install -v golang.org/x/tools/gopls@latest && \
    go install -v github.com/air-verse/air@latest && \
    go clean -cache -modcache
# *------------------ End of Go ------------------
# !================== End of Installations that only need root ==================


# !================== Installations that need non-root & root ==================
# *------------------ Python ------------------
# The Python version to install: https://devguide.python.org/versions/#supported-versions
ARG PYTHON_VERSION=3.14

# Run as root
USER root

# Install pyenv dependencies
RUN DEBIAN_FRONTEND="noninteractive" apt-get update -y && apt-get install -y --no-install-recommends \
    libbz2-dev \
    libffi-dev \
    liblzma-dev \
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
    zlib1g-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Set back to non-root user
USER dev

# Install pyenv
RUN curl https://pyenv.run | bash

# Set pyenv environment variables
ENV PYENV_ROOT=/home/dev/.pyenv
ENV PATH=$PYENV_ROOT/bin:$PYENV_ROOT/shims:$PATH

# Install Python
RUN pyenv install ${PYTHON_VERSION} && \
    pyenv global ${PYTHON_VERSION} && \
    # Install development tools
    pip install --no-cache-dir --upgrade pip setuptools wheel virtualenv pipenv \
    numpy scipy pylint poetry flake8 black pyright ruff rope pytest twine \
    pandas ipython jupyterlab notebook

# Configure Jupyter Notebook
RUN jupyter notebook --generate-config && \
    echo "c.ServerApp.ip = '0.0.0.0'" >> ~/.jupyter/jupyter_server_config.py && \
    echo "c.ServerApp.allow_root = True" >> ~/.jupyter/jupyter_server_config.py && \
    echo "c.ServerApp.open_browser = False" >> ~/.jupyter/jupyter_server_config.py && \
    echo "c.ServerApp.port = 8888" >> ~/.jupyter/jupyter_server_config.py && \
    echo "c.ServerApp.token = ''" >> ~/.jupyter/jupyter_server_config.py && \
    echo "c.ServerApp.password = ''" >> ~/.jupyter/jupyter_server_config.py
EXPOSE 8888
# *------------------ End of Python ------------------

# *------------------ Rust ------------------
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
# *------------------ End of Rust ------------------
# !================== End of Installations that need non-root & root ==================


# Set back to non-root user
USER dev

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/bin/bash"]