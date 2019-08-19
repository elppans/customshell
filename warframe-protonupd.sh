#!/bin/bash

WINE="$HOME/.steam/steam/compatibilitytools.d/Proton-4.11-GE-1/dist/bin/wine64"
WINEARCH="win64"
WINEDEBUG="-all"
WINEPREFIX="/mnt/files/Steam/steamapps/compatdata/230410/pfx/"
WINDIR="$HOME/.steam/steam/compatibilitytools.d/Proton-4.11-GE-1/dist/bin"
WINLIB="$HOME/.steam/steam/compatibilitytools.d/Proton-4.11-GE-1/dist/lib"
WINLIB64="$HOME/.steam/steam/compatibilitytools.d/Proton-4.11-GE-1/dist/lib64"

export WINE
export WINEARCH
export WINEDEBUG
export WINEPREFIX
export PATH="$WINDIR:$PATH"
export LD_LIBRARY_PATH="$WINLIB:$WINLIB64:$LD_LIBRARY_PATH"

cd /mnt/files/Steam/steamapps/common/Warframe/Tools/
./updater.sh --no-game -v
