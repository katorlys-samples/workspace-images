#!/bin/bash

set -e

start_docker_daemon() {
    (
        set +e

        if docker info >/dev/null 2>&1; then
            exit 0
        fi

        # Set up cgroup v2 nesting when the container has enough privileges.
        if [ -f /sys/fs/cgroup/cgroup.controllers ]; then
            sudo mkdir -p /sys/fs/cgroup/init > /dev/null 2>&1 || true
            xargs -rn 1 < /sys/fs/cgroup/cgroup.procs | sudo tee /sys/fs/cgroup/init/cgroup.procs > /dev/null 2>&1 || true
            sed -e 's/ / +/g' -e 's/^/+/' < /sys/fs/cgroup/cgroup.controllers \
                | sudo tee /sys/fs/cgroup/cgroup.subtree_control > /dev/null 2>&1 || true
        fi

        # Docker is optional in workspace-all.
        # If Docker cannot start, keep the main workspace process running and leave details in /tmp/docker.log.
        sudo dockerd --host=unix:///var/run/docker.sock \
            --storage-driver=vfs \
            --log-level=error \
            --log-driver=json-file > /tmp/docker.log 2>&1 &
        dockerd_pid=$!

        for i in {1..30}; do
            if docker info >/dev/null 2>&1; then
                exit 0
            fi

            if ! kill -0 "$dockerd_pid" 2>/dev/null; then
                exit 0
            fi

            sleep 1
        done

    ) &
}

start_docker_daemon

exec "$@"
