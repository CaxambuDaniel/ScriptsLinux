#!/bin/bash

#Caxambu
#este Script pega os logs que sao gerados no  envio de transacoes para operadoras roteadas e gera um arquivo .txt com todas as tentativas para um determinado ID


# Variaveis que Armazenam dados necessarios para a extracao dos arquivos
echo "#################################"
echo "#                               #"
echo "# Insira os dados da transacao: #"
echo "#                               #"
echo "#################################"
echo
echo "insira o nome da operadora"
read operadora;
echo "insira o ano do Debug"
read ano
echo "insira o mes do Debug"
read mes;
echo "insira o dia do Debug"
read dia;
echo "Insira a hora da transacao (hh:mm:ss) "
read hora;
echo "Insira o ID da transacao"
read id;



	 if [[ $ano -lt `date +%Y` ]];
       then
			CP01=`cp /var/log/autorizador/barcelona01/log/$ano/$mes/auth${operadora}_${dia}${mes}${ano}.debug.xz /var/log/autorizador/temp/`	
       else
      		CP02=`cp /var/log/autorizador/barcelona01/log/xz/auth${operadora}_${dia}${mes}${ano}.debug.xz /var/log/autorizador/temp/`
     fi

cd /var/log/autorizador/temp

GREP02=`xzgrep -a " $hora " auth${operadora}_${dia}${mes}${ano}.debug.xz > /var/log/autorizador/temp/auth${operadora}_${id}.txt`

echo `Extrai_tudo.sh $operadora`

chmod 777 *
