#!/bin/bash

#!/bin/bash

# BASE
	COMMAND=`basename "$0"`
# BASE

##	Usando arquivo de log

#mkdir -p "$HOME"/."$COMMAND"
LOGFILE="$HOME/${0##*/}".log

# Habilita log copiando a saída padrão para o arquivo LOGFILE

exec 1> >(tee -a "$LOGFILE")

# faz o mesmo para a saída de ERROS

exec 2>&1

##	Usando arquivo de log - FIM

PROTON="$HOME/.steam/steam/compatibilitytools.d/Proton-4.11-GE-1"
STEAMAPPS="/mnt/files/Steam/steamapps"

WINE="$PROTON/dist/bin/wine64"
WINEARCH="win64"
WINEDEBUG="-all"
WINEPREFIX="$STEAMAPPS/compatdata/230410/pfx/"
WINDIR="$PROTON/dist/bin"
WINLIB="$PROTON/dist/lib"
WINLIB64="$PROTON/dist/lib64"

export PROTON
export STEAMAPPS
export WINE
export WINEARCH
export WINEDEBUG
export WINEPREFIX
export PATH="$WINDIR:$PATH"
export LD_LIBRARY_PATH="$WINLIB:$WINLIB64:$LD_LIBRARY_PATH"

cd "$STEAMAPPS/common/Warframe/Tools/"
./updater.sh --no-game -v
