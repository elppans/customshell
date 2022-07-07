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

# Via psql, REINDEX no BANCO, completo:

#echo -e "REINDEX BABCO "$BANCO""
#psql -h "$IP" -p "$PORT" -U postgres -d "$BANCO" -c "REINDEX DATABASE "$BANCO";"

# Via psql, REINDEX em tabela determinada:

 echo -e "INICIO $(date)"
echo "public.tab_controle_nfe"
psql -h "$IP" -p "$PORT" -U postgres -d "$BANCO" -c "REINDEX TABLE public.tab_controle_nfe;"
echo "public.tab_nota_header"
psql -h "$IP" -p "$PORT" -U postgres -d "$BANCO" -c "REINDEX TABLE public.tab_nota_header;"
echo "public.tab_nota_item"
psql -h "$IP" -p "$PORT" -U postgres -d "$BANCO" -c "REINDEX TABLE public.tab_nota_item;"
 echo -e "FIM $(date)"
