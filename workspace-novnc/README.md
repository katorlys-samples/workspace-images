# workspace-novnc
Basic Ubuntu desktop development environment with noVNC access via web browser.

## Includes
- Everything from `katorlys/workspace-base`
- TigerVNC & noVNC
- XFCE4 desktop environment
- Firefox, Thunar (file manager), Ristretto (image viewer), etc.

## Usage
Map the container's port 6081 to your host's port:
```shell
docker run -p <host-port>:6081 -it katorlys/workspace-base-novnc:latest
```

Then visit `localhost:<host-port>` in your browser, and click "Connect". When asked for credentials, press "Send Credentials" with empty password.
