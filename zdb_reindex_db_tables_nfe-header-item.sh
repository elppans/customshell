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

# Via psql, REINDEX no BANCO, completo:

#echo -e "REINDEX BABCO "$BANCO""
#psql -h "$IP" -p "$PORT" -U postgres -d "$BANCO" -c "REINDEX DATABASE "$BANCO";"

# Via psql OU reindexdb, REINDEX em tabela determinada:

echo "public.tab_controle_nfe"

#psql -h "$IP" -p "$PORT" -U postgres -d "$BANCO" -c "REINDEX TABLE public.tab_controle_nfe;"
reindexdb -h "$IP" -p "$PORT" -U postgres -w -d "$BANCO" -t public.tab_controle_nfe

echo "public.tab_nota_header"

#psql -h "$IP" -p "$PORT" -U postgres -d "$BANCO" -c "REINDEX TABLE public.tab_nota_header;"
reindexdb -h "$IP" -p "$PORT" -U postgres -w -d "$BANCO" -t public.tab_nota_header

echo "public.tab_nota_item"

#psql -h "$IP" -p "$PORT" -U postgres -d "$BANCO" -c "REINDEX TABLE public.tab_nota_item;"
reindexdb -h "$IP" -p "$PORT" -U postgres -w -d "$BANCO" -t public.tab_nota_item

# Via psql OU reindexdb, REINDEX em BANCO determinado:

#echo "REINDEXANDO BANCO..."
#reindexdb -h "$IP" -p "$PORT" -U postgres -w -d "$BANCO"

 echo -e "FIM $(date)"
 

### Sobre o REINDEXDB:
#
#reindexdb reindexa um banco de dados PostgreSQL.
#
#Uso:
#  reindexdb [OPÇÃO]... [NOMEBD]
#
#Opções:
#  -a, --all                 reindexa todos os bancos de dados
#  -d, --dbname=NOMEBD       banco de dados a ser reindexado
#  -e, --echo                mostra os comandos enviados ao servidor
#  -i, --index=ÍNDICE        reindexa somente índice(s) especificado(s)
#  -q, --quiet               não exibe nenhuma mensagem
#  -s, --system              reindexa os catálogos do sistema
#  -t, --table=TABELA        reindexa somente tabela(s) especificada(s)
#  -V, --version             mostra informação sobre a versão e termina
#  -?, --help                mostra essa ajuda e termina
#
#Opções de conexão:
#  -h, --host=MÁQUINA        máquina do servidor de banco de dados ou diretório do soquete
#  -p, --port=PORTA          porta do servidor de banco de dados
#  -U, --username=USUÁRIO    nome do usuário para se conectar
#  -w, --no-password         nunca pergunta senha
#  -W, --password            pergunta senha
#  --maintenance-db=NOMEBD   especifica um banco de dados para manutenção
#
#Leia a descrição do comando SQL REINDEX para obter detalhes.
#
#Relate erros a <pgsql-bugs@postgresql.org>.
