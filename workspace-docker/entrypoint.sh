#!/bin/bash

set -e

# Set up cgroup v2 nesting
if [ -f /sys/fs/cgroup/cgroup.controllers ]; then
    sudo mkdir -p /sys/fs/cgroup/init
    xargs -rn 1 < /sys/fs/cgroup/cgroup.procs | sudo tee /sys/fs/cgroup/init/cgroup.procs > /dev/null 2>&1 || true
    sed -e 's/ / +/g' -e 's/^/+/' < /sys/fs/cgroup/cgroup.controllers \
        | sudo tee /sys/fs/cgroup/cgroup.subtree_control > /dev/null 2>&1 || true
fi

# Start Docker daemon
sudo dockerd --host=unix:///var/run/docker.sock \
    --storage-driver=vfs \
    --log-level=error \
    --log-driver=json-file > /tmp/docker.log 2>&1 &

for i in {1..30}; do
    if docker info >/dev/null 2>&1; then
        break
    fi
    if [ $i -eq 30 ]; then
        echo "Docker daemon failed to start" >&2
        cat /tmp/docker.log >&2
        exit 1
    fi
    sleep 1
done

exec "$@"
