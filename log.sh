#!/bin/bash

# BASE
        COMMAND=`basename "$0"`
# BASE

##      Usando arquivo de log

#mkdir -p "$HOME"/."$COMMAND"
LOGFILE="$HOME/${0##*/}".log
LOGFILEERROR="$HOME/${0##*/}"_error.log
# Habilita log copiando a saída padrão para o arquivo LOGFILE

exec 1> >(tee -a "$LOGFILE")

# faz o mesmo para a saída de ERROS

exec 2> >(tee -a "$LOGFILEERROR")

##      Usando arquivo de log - FIM
