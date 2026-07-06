FROM katorlys/workspace-base:latest

# Run as root
USER root

# Install Go
RUN GO_VERSION=$(curl -s https://go.dev/dl/?mode=json | jq -r '.[0].version') && \
    wget https://go.dev/dl/${GO_VERSION}.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf ${GO_VERSION}.linux-amd64.tar.gz && \
    echo 'export PATH="/usr/local/go/bin:$PATH"' >> /etc/bash.bashrc && \
    echo 'export GOPATH="/home/dev/go"' >> /etc/bash.bashrc && \
    echo 'export CGO_ENABLED=1' >> /etc/bash.bashrc && \
    rm ${GO_VERSION}.linux-amd64.tar.gz

# Set environment variables
ENV PATH="/usr/local/go/bin:/home/dev/go/bin:${PATH}" \
    GOPATH="/home/dev/go" \
    CGO_ENABLED=1

# Set back to non-root user
USER dev

# Install development tools
RUN go install -v github.com/go-delve/delve/cmd/dlv@latest && \
    go install -v github.com/golangci/golangci-lint/cmd/golangci-lint@latest && \
    go install -v golang.org/x/tools/gopls@latest && \
    go install -v github.com/air-verse/air@latest && \
    go clean -cache -modcache