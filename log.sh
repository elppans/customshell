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

