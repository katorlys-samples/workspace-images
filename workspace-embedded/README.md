# workspace-embedded
Embedded development environment in Docker.

## Includes
- openocd
- qemu
- gcc-arm-none-eabi
- ..., etc.

Use `--device` flag to access USB devices in your container. For example:
```shell
docker run --device=/dev/ttyUSB0 -it katorly/workspace-c:latest
```
