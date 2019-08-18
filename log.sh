#!/bin/bash

## Configuração do Deepin
# Após a criação do container chroot, editar ~/.bashrc e adicionar ao final do arquivo, a linha ". /etc/profile"
# Opcionalmente, adione a variavel "export debian_chroot=deepin" no começo do arquivo e descomente as linhas "PS1" e umask
# Em /etc/hosts, primeira linha, adicione o nome que está em hostname. Exemplo: 127.0.0.1 localhost DarkElven

# BASE
	COMMAND=`basename "$0"`
# BASE

##	Usando arquivo de log

mkdir -p "$HOME"/."$COMMAND"
LOGFILE="$HOME/.$COMMAND/${0##*/}".log

# Habilita log copiando a saída padrão para o arquivo LOGFILE

exec 1> >(tee -a "$LOGFILE")

##	Usando arquivo de log - FIM
