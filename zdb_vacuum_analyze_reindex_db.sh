#!/bin/bash

if [ "$(id -u)" != "0" ]; then
echo "Deve executar o comando como super usuario!"
exit 0
fi

##      Usando arquivo de log - INÍCIO

# Habilita log copiando a saída padrão para o arquivo LOGFILE

exec 1> >(tee -a "/var/log/"${0##*/}".log")

# faz o mesmo para a saída de ERROS

exec 2> >(tee -a "/var/log/"${0##*/}"_error.log")

##      Usando arquivo de log - FIM

#tab_controle_nfe
#tab_nota_header
#tab_nota_item

IP="127.0.0.1"
PORT="5432"
BANCO="ZeusRetail"

 echo -e "INICIO $(date)"
 
# Via vacuumdb, VACUUM e ANALYZE em BANCO determinado, completo:

vacuumdb -h "$IP" -p "$PORT" -U postgres -w -d "$BANCO" -v -f -z

 
# Via reindexdb, REINDEX em BANCO determinado, completo:

echo "REINDEXANDO BANCO..."
reindexdb -h "$IP" -p "$PORT" -U postgres -w -d "$BANCO"
echo -e "REINDEX FINALIZADO"
 
 echo -e "FIM $(date)"
 
