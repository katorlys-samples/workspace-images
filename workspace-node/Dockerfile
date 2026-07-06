FROM katorlys/workspace-base:latest

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
    echo 'export PATH="$PATH:$HOME/.npm-global/bin:$HOME/.yarn/bin:$HOME/.local/share/pnpm"' >> ~/.bashrc && \
    npm cache clean --force