#!/bin/bash

set -eu

AGENT_PATH="/var/lib/incus-agent"

if [ ! -f ${AGENT_PATH}/agent.crt ]; then
    echo "Certificates not found, mounting"
    mkdir -p /tmp/incusmnt
    mount -t 9p config /tmp/incusmnt
    mkdir -p ${AGENT_PATH}
    cp /tmp/incusmnt/* ${AGENT_PATH}/
    chmod 0600 ${AGENT_PATH}/agent.key
    umount /tmp/incusmnt
    rm -rf /tmp/incusmnt
fi

cd ${AGENT_PATH}
exec incus-agent -d
