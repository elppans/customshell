#!/bin/bash

##      Usando arquivo de log

LOGFILE="$(pwd)/${0##*/}".log
LOGFILEERROR="$(pwd)/${0##*/}"_error.log
# Habilita log copiando a saída padrão para o arquivo LOGFILE

exec 1> >(tee -a "$LOGFILE")

# faz o mesmo para a saída de ERROS

exec 2> >(tee -a "$LOGFILEERROR")

##      Usando arquivo de log - FIM

LNXPDV=/Zanthus/Zeus/pdvJava
path=`pwd`
#/Zanthus/Zeus/path_comum/VOVOZUZU/MV
BINCONV=lnx_conv_CZ
LCONV=./lnx_conv_CZ
NECF=$(pwd |cut -d "." -f "2")

#COMANDO
#echo "COMANDO $0 OK!"
if [ ! -e /usr/bin/$BINCONV ]; then
        echo -e "Deve conter o comando "$BINCONV" em \"/usr/bin\""
	echo -e "Copie ou faça um link do arquivo "$BINCONV" do CODFON em questão para a pasta especificada!"
			exit 0
fi
#COMANDO


case "$1" in
	-[Dd])
	data=$(echo $2)
	;;
	-[Dd][Ee])
LOC=`pwd`
DATA="$2"

#Date
	if [ -z $DATA ]
			then
		echo -e "O comando $0 deve conter uma data como parametro no formato AAAAMMDD."
		read -t 5
		exit 0
	fi
#Date

#Date > 0
	if [ $DATA -lt 20190000 ]
			then
		echo "Digite um numero maior que 20190000!"
		read -t 5
		exit 0
	fi
#Date > 0

ls -1d "$DATA"* | cut -d "." -f "2" > geralist


NUMX=$(cat "$LOC"/geralist)


for NUM in ${NUMX[@]}
do

./geratrab.sh -d $DATA -e "$NUM"
rm -rf "$LOC"/geralist

done

echo -e "Para somar todos os SDFs, entre na pasta Vendas_"$DATA" e faça o comando:
	cat * > NOME.ZAN "
	exit 0
	;;
	-[Ss])
LOC=`pwd`
DATA="$2"

if [ -d "$LOC"/Vendas_"$DATA" ]; then
	cd "$LOC"/Vendas_"$DATA"
  if [ -e "$LOC"/Vendas_"$DATA"/"$DATA".ZAN ]; then
		echo -e "O arquivo "$DATA".ZAN já existe..."
		exit 0
	else
		echo -e "Somando os arquivos \".SDF\"..."
		cat *.SDF > "$DATA".ZAN
   if [ -e "$LOC"/Vendas_"$DATA"/"$DATA".ZAN ]; then
		echo -e "Arquivo "$DATA".ZAN criado com sucesso!"
		exit 0
	 else
		echo -e "Arquivo "$DATA".ZAN \"NÃO\" foi criado com sucesso!"
		exit 0
   fi
  fi
fi
	;;
	-[Dd][Ss])
	LOC=`pwd`
	DATA="$2"

	"$0" -de "$DATA"
	cd "$LOC"
	"$0" -s "$DATA"
	exit 0
	;;
	-[Rr][Ss])
	LOC=`pwd`
	DATA="$2"
	echo -e "Removendo TODOS os SDF..."
	sleep 5
	find "$LOC" -type f -name "*.SDF" -exec rm -rfv {} \; 
	exit 0
	;;
	-[Rr][Ss][Dd])
	LOC=`pwd`
	DATA="$2"
	echo -e "Removendo TODOS os SDF da data especificada..."
	sleep 5
	find "$LOC"/"$DATA"* -type f -name "*.SDF" -exec rm -rfv {} \; 
	exit 0
	;;
	-[Vv]|--[Vv][Ee][Rr][Ss][Aa][Oo])
	echo "0.1"
	exit 0
	;;
	-[Hh]|--[Hh][Ee][Ll][Pp])
 echo -e "Comando para conversão de movimentos gravados no path_comum
 
	Opções:
 -d 	Data, deve especificar a data no formato \"AAAAMMDD\"
 -e 	ECF, deve especificar o número do ECF a converter para \".SDF\"
 -de 	Especificando a data, é convertido TODOS os ECFs encontrados
 -s 	Faz a soma de todos os SDF criado para um arquivo \"DATA.ZAN\".
 -ds 	Especificando a data, \"Converte\" E \"Soma\" TODOS os ECFs encontrados para \"DATA.ZAN\"
 -rsd	Remove TODOS os SDF da data especificada. (Não inclui a pasta \"Vendas_AAAAMMDD\")
 -rs	Remove TODOS OS \"SDF\". Não é necessário especificar data, inclui a pasta \"Vendas_AAAAMMDD\"
 -v	Mostra a versão do comando

 Exemplo:
	$0 -d $(date +%Y%m%d ) -e 101
	OU
	$0 -ds $(date +%Y%m%d )
	
 Os arquivos são enviados para a pasta \"Vendas_AAAAMMDD\".
"
	exit 0
	;;
	*) echo -e "Parâmetro inválido, use a opção -h ou --help para mais informações!"
	exit 0
	;;
esac

#Date
	if [ -z $data ]
			then
		echo -e "O comando $0 deve conter uma data como parametro no formato AAAAMMDD."
		read -t 5
		exit 0
	fi
#Date

#Date > 0
	if [ $data -lt 20190000 ]
			then
		echo "Digite um numero maior que 20190000"
		read -t 5
		exit 0
	fi
#Date > 0



case "$3" in
	-[Ee])
	ECF="$4"
	;;
	*) echo "Deve especificar a opção "-e"!"
	exit 0
	;;

esac

##Conversao
#$data.$ECF
#echo -e "$path/$data.$ECF"
if [ -d "$path/$data.$ECF" ]; then
	cd "$path/$data.$ECF"
	pwd
		else
	echo "Nao existe $BINCONV"
echo "Nao foi possivel criar TRAB1.SDF para ECF $ECF" >> $path/lnxconv_info >> /dev/null
	echo "O sistema deve conter o aplicativo $BINCONV para fazer as conversoes."
	echo "Saindo do configurador..."
	read -t 5

fi
#$data.$ECF

## ZMV > TRA
if ls -F | grep -Ev '/|@|=|>|\|' | grep .ZMV | cut -d '*' -f '1' | tee ZMV_File.txt ; then
        cp -av $(cat ZMV_File.txt) TH01HKCZ.TRA
else
if ! ls TH01HKCZ.TRA 2>> /dev/null; then
	echo "Não existe arquivo TRA nesta pasta!"
	exit 0
fi
fi
## ZMV > TRA

#$BINCONV
##if (ls /usr/bin | grep $BINCONV)
##	then
$BINCONV -m
##		else

##if (ls $path/MV | grep $BINCONV)
##	then
##$path/./$BINCONV -m
##fi
##fi
#$BINCONV


if (ls | grep TRAB1.SDF)
		then
	cp -rfv TRAB1.SDF TRAB1_$ECF.SDF

if [ -d "$path"/Vendas_"$data" ]
		then
	cp -rfv TRAB1_$ECF.SDF $path/Vendas_$data
for i in `seq 5 -1 1` ; do echo -ne " Arquivo do ECF $ECF, data $data Ok. Continuando em $i SEGUNDOS\r" ; sleep 1 ; done
	cd $path
	#pwd
			else
	mkdir -p $path/Vendas_$data
	cp -rfv TRAB1_$ECF.SDF $path/Vendas_$data
for i in `seq 5 -1 1` ; do echo -ne " Arquivo do ECF $ECF, data $data Ok. Continuando em $i SEGUNDOS\r" ; sleep 1 ; done
	cd $path
	pwd
fi

			else
	echo "Nao foi possivel criar TRAB1.SDF para ECF $ECF" >> $path/SDF_info >> /dev/null
	cd $path
	pwd
fi


##Fim Conversao




