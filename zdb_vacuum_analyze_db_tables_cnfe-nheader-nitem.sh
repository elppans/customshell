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

# Via psql, VACUUM e ANALYZE em tabela determinada:

#psql -h "$IP" -p "$PORT" -U postgres -d "$BANCO" -c "VACUUM FULL VERBOSE ANALYZE public.tab_controle_nfe;"
#psql -h "$IP" -p "$PORT" -U postgres -d "$BANCO" -c "VACUUM FULL VERBOSE ANALYZE public.tab_nota_header;"
#psql -h "$IP" -p "$PORT" -U postgres -d "$BANCO" -c "VACUUM FULL VERBOSE ANALYZE public.tab_nota_item;"

# Via vacuumdb, VACUUM e posteriormente ANALYZE em tabela determinada:

#vacuumdb -h "$IP" -p "$PORT" -U postgres -w -d "$BANCO" -v -f -t public.tab_controle_nfe
#vacuumdb -h "$IP" -p "$PORT" -U postgres -w -d "$BANCO" -v -Z -t public.tab_controle_nfe

#vacuumdb -h "$IP" -p "$PORT" -U postgres -w -d "$BANCO" -v -f -t public.tab_nota_header
#vacuumdb -h "$IP" -p "$PORT" -U postgres -w -d "$BANCO" -v -Z -t public.tab_nota_header

#vacuumdb -h "$IP" -p "$PORT" -U postgres -w -d "$BANCO" -v -f -t public.tab_nota_item
#vacuumdb -h "$IP" -p "$PORT" -U postgres -w -d "$BANCO" -v -Z -t public.tab_nota_item

# Via vacuumdb, VACUUM e ANALYZE em tabela determinada:

vacuumdb -h "$IP" -p "$PORT" -U postgres -w -d "$BANCO" -v -f -z -t public.tab_controle_nfe
vacuumdb -h "$IP" -p "$PORT" -U postgres -w -d "$BANCO" -v -f -z -t public.tab_nota_header
vacuumdb -h "$IP" -p "$PORT" -U postgres -w -d "$BANCO" -v -f -z -t public.tab_nota_item

 echo -e "FIM $(date)"

### Sobre o VACUUMDB:
#
#vacuumdb cleans and analyzes a PostgreSQL database.
#
#Usage:
#  vacuumdb [OPTION]... [DBNAME]
#
#Usage:
#  vacuumdb [OPTION]... [DBNAME]
#
#Options:
#  -a, --all                       vacuum all databases
#  -d, --dbname=DBNAME             database to vacuum
#  -e, --echo                      show the commands being sent to the server
#  -f, --full                      do full vacuuming
#  -F, --freeze                    freeze row transaction information
#  -q, --quiet                     don't write any messages
#  -t, --table='TABLE[(COLUMNS)]'  vacuum specific table(s) only
#  -v, --verbose                   write a lot of output
#  -V, --version                   output version information, then exit
#  -z, --analyze                   update optimizer statistics
#  -Z, --analyze-only              only update optimizer statistics
#      --analyze-in-stages         only update optimizer statistics, in multiple
#                                  stages for faster results
#  -?, --help                      show this help, then exit
#
#Connection options:
#  -h, --host=HOSTNAME       database server host or socket directory
#  -p, --port=PORT           database server port
#  -U, --username=USERNAME   user name to connect as
#  -w, --no-password         never prompt for password
#  -W, --password            force password prompt
#  --maintenance-db=DBNAME   alternate maintenance database
