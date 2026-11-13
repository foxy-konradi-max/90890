#!/bin/bash
set -e

# Vorherige Build-Reste vollständig bereinigen
lb clean --purge

# Live-Build mit allen erforderlichen Repositories und Architekturen initialisieren
lb config \
    --distribution bookworm \
    --archive-areas "main contrib non-free non-free-firmware" \
    --binary-images iso-hybrid \
    --architectures amd64 \
    --debian-installer false

# Build-Prozess starten
lb build
