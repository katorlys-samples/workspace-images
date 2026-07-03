# workspace-docker
Docker-related development environment with optimization tools.

## Includes
- Docker & Docker Compose
- [Crun](https://github.com/containers/crun), as an alternative OCI runtime
- [dive](https://github.com/wagoodman/dive)
- [Slim](https://github.com/slimtoolkit/slim)

Use `--privileged` flag to enable Docker inside your container. For example:
```shell
docker run --privileged -it katorlys/workspace-docker:latest
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
