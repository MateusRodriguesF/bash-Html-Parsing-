#!/bin/bash
#Script para detecção de sub-dominios e ips de hosts e e html parsing
if [ "$1" == "" ]
then

	echo -e "\033[32;94;2m
#############################################################################
- >                             HTML PARSING                              < -
- >                    Codado Por Mateus Rodrigues                        < -
- >             Modo de Usar: ./script.sh www.alvo.com.br                 < -
#############################################################################
	\033[m"
else
		echo -e "\033[32;94;5m
#############################################################################
- >                             HTML PARSING                              < -
- >                    Codado Por Mateus Rodrigues                        < -
#############################################################################
	\033[m"
		echo -e "\033[32;94;2m
_____________________________________________________________________________
 [+] Fazendo Varredura no alvo: $1                       
-----------------------------------------------------------------------------
	\033[m"
		wget -q $1 -O $1.html
		grep "href" $1.html | cut -d "/" -f 3 | grep "\." | cut -d '"' -f1 | egrep -v "<l|png|jpg|ico|js|css|mp3|mp4" |sort -u |sed "s/'/ /" > $1.txt
		sleep 1.00
		echo -e "\033[31;91;2m
_____________________________________________________________________________
 [+] Concluido...
 [+] Registrando O Resultado em $1.txt                       
-----------------------------------------------------------------------------
	\033[m"
		echo -e "\033[31;94;2m
_____________________________________________________________________________
 [+] Identificando o ip                                                     
-----------------------------------------------------------------------------
	\033[m"
fi

for hst in $(cat $1.txt);
do
	host $hst | grep "has address" |sed 's/has address/\tIP:/' | column -t -s ' ';
	# sed 's/has address/<< IP >>/' | column -t;
done
