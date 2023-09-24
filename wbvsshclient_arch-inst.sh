#!/bin/bash

sudo pacman -Syu --needed --noconfirm wine-mono
DGET="~/Downloads/bitvise" && mkdir -p $DGET
export WINEPREFIX="$HOME/.wine/wbvsshclient" && mkdir -p $WINEPREFIX
export WINEDEBUG="-all"
cd "$DGET"
wget -c https://dl.bitvise.com/BvSshClient-Inst.exe
wine "BvSshClient-Inst.exe" -force -acceptEULA  "$@"
cd
rm -rf "$DGET"
