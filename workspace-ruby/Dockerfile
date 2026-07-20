FROM katorlys/workspace-base:latest

# The Ruby version to install: https://www.ruby-lang.org/en/downloads/releases
ARG RUBY_VERSION=4.0.5

# Run as root
USER root

# Install dependencies
RUN DEBIAN_FRONTEND="noninteractive" apt-get update -y && apt-get install -y --no-install-recommends \
	autoconf \
	bison \
	libffi-dev \
	libgdbm-dev \
	libgmp-dev \
	libncurses5-dev \
	libreadline-dev \
	libssl-dev \
	libyaml-dev \
    make \
	rustc \
	zlib1g-dev && \
	apt-get clean && rm -rf /var/lib/apt/lists/*

# Set back to non-root user
USER dev

# Install Ruby
ENV RBENV_ROOT="/home/dev/.rbenv" \
    PATH="/home/dev/.rbenv/bin:/home/dev/.rbenv/shims:$PATH"
RUN git clone https://github.com/rbenv/rbenv.git $RBENV_ROOT && \
	git clone https://github.com/rbenv/ruby-build.git $RBENV_ROOT/plugins/ruby-build && \
	rbenv install ${RUBY_VERSION} && \
	rbenv global ${RUBY_VERSION} && \
	rbenv rehash && \
    # Install development tools
	gem install bundler rails && \
	gem cleanup