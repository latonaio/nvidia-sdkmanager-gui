#!/bin/bash

NVIDIA_VOLUME_DIR=/var/lib/sdkmanager-docker
USER_ID=1000
GROUP_ID=0

mkdir -p "$NVIDIA_VOLUME_DIR/"{nvsdkm,nvidia,nvidia_sdk}
chown -R "$USER_ID.$GROUP_ID" "$NVIDIA_VOLUME_DIR"
