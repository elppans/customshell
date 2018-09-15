#!/bin/bash
# https://ubuntuforums.org/showthread.php?t=2172828
# Force Zenity Status message box to always be on top.
BNAME=$(basename "$0")

TMIN="$1" # Indicar o tempo (Em segundos)
NUM="9"

COMMAND="shutdown"


[ "$TMIN" == "--help" ] || [ "$TMIN" == "-h" ] || \
[ "$TMIN" == "--HELP" ] || [ "$TMIN" == "-H" ] && {
zenity --info --title "Help" --text="Use o comando \""$BNAME"\" especificando um número de tempo em Segundos.
Exemplo especificando 2 minutos:
	
	"$BNAME" 120

O Usuário deve ter permissão ou usar o Super Usuário para executar o comando \"$COMMAND\"!

" \
--ellipsize
exit 1
}

[ -z "$TMIN" ] && {
zenity --warning --text="Deve especificar o tempo em Segundos!" --ellipsize
exit 1
}

[ "$TMIN" -lt "$NUM" ] && {
zenity --warning --title "Erro" --text "O tempo deve ser especificado em no MÍNIMO \""$NUM"\" Segundos!"  --ok-label "Ok" --no-wrap
exit 1
}


TSIG=$(expr "$TMIN" / "$NUM" )
T9=$(expr 1 \* "$TSIG")
T8=$(expr 2 \* "$TSIG")
T7=$(expr 3 \* "$TSIG")
T6=$(expr 4 \* "$TSIG")
T5=$(expr 5 \* "$TSIG")
T4=$(expr 6 \* "$TSIG")
T3=$(expr 7 \* "$TSIG")
T2=$(expr 8 \* "$TSIG")
T1=$(expr 9 \* "$TSIG")
#sleep 1 && wmctrl -r "Progress Status" -b add,above &
# Calculo do tempo: Segs. \* Min / "$NUM" \* "$Tx"

(
echo "1"
echo "# O computador será desligado em "$T1" seg." ; sleep "$TSIG"
echo "15"
echo "# O computador será desligado em "$T2" seg." ; sleep "$TSIG"
echo "20"
echo "# O computador será desligado em "$T3" seg." ; sleep "$TSIG"
echo "35"
echo "# O computador será desligado em "$T4" seg." ; sleep "$TSIG"
echo "50"
echo "# O computador será desligado em "$T5" seg." ; sleep "$TSIG"
echo "65"
echo "# O computador será desligado em "$T6" seg." ; sleep "$TSIG"
echo "80"
echo "# O computador será desligado em "$T7" seg." ; sleep "$TSIG"
echo "99"
echo "# O computador será desligado em "$T8" seg." ; sleep "$TSIG"
echo "# O computador será desligado em "$T9" seg." ; sleep "$TSIG"
#echo "# Desligando agora..." ; sleep 1
echo "100" ;

#"$COMMAND" 0
"$COMMAND" -h now

) |
zenity --progress \
  --title="Progress Status" \
  --text="First Task." \
  --percentage=0 \
  --auto-close \
  --auto-kill

(( $? != 0 )) && zenity --error --text="Error in zenity command."

exit 0


