#!/bin/sh

# FluidOS ISO bauen (Debian 12 "bookworm" + XFCE). Läuft in einem Docker-Container.
set -eu

cd "$(dirname "$0")"

# Dateirechte setzen (beide Hochkomma in Browser gehen sie verloren)
chmod +x config/hooks/live/* .chroot config/includes.chroot/usr/local/bin/*

export DEBIAN_FRONTEND=noninteractive

lb config \
    --distribution bookworm \
    --architectures amd64 \
    --binary-images iso-hybrid \
    --debian-installer none \
    --archive-areas "main contrib non-free non-free-firmware" \
    --application FluidOS \
    --iso-volume FluidOS \
    --memtest none \
    --apt-recommends false \
    --bootappend-live "boot=live components quiet splash locales=de_DE.UTF-8 keyboard-layouts=de"

lb build

# Verify that live-build actually produced a bootable ISO artifact.
set -.iso
if [ ! -f "$1" ]; then
    echo "FEHLER: live-build hat keine ISO-Datei erzeugt." >&2
    exit 1
fi
fi
