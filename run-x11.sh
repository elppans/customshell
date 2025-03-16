#!/bin/bash

# Verifica se está rodando no Wayland
if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    env -u WAYLAND_DISPLAY GDK_BACKEND=x11 QT_QPA_PLATFORM=xcb "$@"
else
    "$@"
fi
