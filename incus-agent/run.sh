#!/bin/bash

set -eu

AGENT_PATH="/var/lib/incus-agent"

if [ ! -f ${AGENT_PATH}/agent.crt ]; then
    echo "Certificates not found, mounting"
    mkdir -p /tmp/incusmnt
    mount -t 9p config /tmp/incusmnt
    mkdir -p ${AGENT_PATH}
    for i in agent.crt agent.key server.crt incus-agent; do
        cp /tmp/incusmnt/${i} ${AGENT_PATH}/
    done
    echo "Setting 0600 on agent key"
    chmod 0600 ${AGENT_PATH}/agent.key
    echo "Unmounting"
    umount /tmp/incusmnt
    rm -rf /tmp/incusmnt
fi

echo "Execing.."
cd ${AGENT_PATH}
#exec ./incus-agent -dv
sleep 36000
