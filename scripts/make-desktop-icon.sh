#!/bin/bash

SERVICE_NAME=sdkmanager-gui

here=$(cd "$(dirname "$0")"; pwd)
root=$(cd "$here/.."; pwd)

container_name=sdkmanager-icon-tmp-$RANDOM
tmpdir=$(mktemp -d)

trap 'rm -rf "'"$tmpdir"'"; docker stop "'"$container_name"'"' EXIT

docker compose --project-directory "$root" run --rm --name "$container_name" -d "$SERVICE_NAME" --shell

for size in 16 32 48 64 128 256; do
  docker cp "$container_name:/usr/share/icons/hicolor/${size}x$size/apps/sdkmanager.png" "$tmpdir/$size.png"
  xdg-icon-resource install --size "$size" "$tmpdir/$size.png" nvidia-sdkmanager
done

cat "$root/resources/nvidia-sdkmanager.desktop.template" | sed -E 's|%PATH%|'"$root"'|g' > "$tmpdir/nvidia-sdkmanager.desktop"
xdg-desktop-icon install "$tmpdir/nvidia-sdkmanager.desktop"
