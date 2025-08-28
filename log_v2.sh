#!/bin/bash

# Comando
command="$(basename $0)"

# Diretório do arquivo
file_dir="$(dirname "$command")" # "$(dirname "$file")"
mkdir -p "$file_dir/LOGGERAL"

# Caminho do log
log_file="$file_dir/LOGGERAL/$command".log # lnx_conv_log.txt"

# Log geral
LOGFILE="$log_file" # ${0##*/}".log
LOGFILEERROR="$log_file"_error # ${0##*/}"_error.log
exec 1> >(tee -a "$LOGFILE")
exec 2> >(tee -a "$LOGFILEERROR")
