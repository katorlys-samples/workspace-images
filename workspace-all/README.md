# workspace-all
Combination of all workspace images for general-purpose development.

## Includes
**Everything from:**

### workspace-c
- Clang
- Code linter: clang-format, clang-tidy, etc.
- Build tools: cmake, ninja, etc.

### workspace-docker
- Docker & Docker Compose
- [Crun](https://github.com/containers/crun), as an alternative OCI runtime
- [dive](https://github.com/wagoodman/dive)
- [Slim](https://github.com/slimtoolkit/slim)

Use `--privileged` flag to enable Docker inside your container. For example:
```shell
docker run --privileged -it katorlys/workspace-all:latest
```
or in DevContainer:
```json
"runArgs": ["--privileged"]
```

> [!CAUTION]  
> Using `--privileged` flag may pose significant risks to the host machine. Use it at your own risk.

> [!TIP]
> If Docker fails to start automatically inside the container, you can manually start it by running:
> ```shell
> /workspace/entrypoint.sh
> ```

### workspace-go
- Golang
- Delve, golangci-lint, air, etc.

### workspace-java
- Java 25
- Kotlin
- Maven & Gradle

Use SDKMAN to install and manage Java versions.

### workspace-node
- Node.js 24.13.0 (Krypton)
- npm, yarn, pnpm
- node-gyp
- TypeScript

Use nvm to install and manage Node.js versions.

### workspace-python
- Python 3.14
- Tools for dependencies management, code analysis, package publishing, etc.
- Jupyter

Use pyenv to install and manage Python versions.

Map the container's port 8888 to your host's port to use Jupyter Notebook:
```shell
docker run -p <host-port>:8888 -it katorlys/workspace-all:latest
```

### workspace-rust
- Rust
- Rust analyzer, rustfmt, clippy
- cargo-edit, cargo-watch
