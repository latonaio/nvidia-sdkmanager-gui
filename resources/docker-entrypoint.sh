#!/bin/bash

delete_extracted=0

for option in $(getopt -n "$(basename "$0")" -o ds -l delete-extracted -l shell -- "$@"); do
  case "$option" in
    -d | --delete-extracted) delete_extracted=1;;
    -s | --shell) bash; exit;;
    --) break;;
  esac
done

/opt/nvidia/sdkmanager/sdkmanager-gui

if [ "$delete_extracted" = 1 ]; then
  sudo rm -rf /var/lib/sdkmanager-docker/nvidia_sdk/*
fi
