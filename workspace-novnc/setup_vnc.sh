#!/bin/bash

# Configure TigerVNC Server.
mkdir -p ~/.vnc

# Create startup script for XFCE desktop.
cat <<EOL > ~/.vnc/xstartup
#!/bin/bash
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
xsetroot -solid "#2e3440"
exec startxfce4
EOL
chmod +x ~/.vnc/xstartup

# Set empty password.
echo -e "\n\n" | vncpasswd -f > ~/.vnc/passwd
chmod 600 ~/.vnc/passwd

# VNC config.
cat <<EOL > ~/.vnc/config
geometry=1920x1080
depth=24
EOL
