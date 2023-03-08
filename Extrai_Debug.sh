#!/bin/bash

#Caxambu
#A partir da inserção de algumas alguma informações como o nome da operadora, data e o numero da transacao, este script gera um arquivo contendo o debug da transacao citada. Este arquivo txt é disponibilizado na raiz do usuario executante (/home/orizon.local/usuario) 
#Deve ser executado na lugo01, portanto d-1. Caso haja necessidade de gerar um script para resgate de debug do dia vigente, peço que me contate para criar algo que atenda essa necessidade

# Variaveis que Armazenam dados necessarios para a extracao dos arquivos
echo "#################################"
echo "#                               #"
echo "# Insira os dados da transacao: #"
echo "#                               #"
echo "#################################"
echo
echo "insira o nome da operadora (em minusculo)"
read operadora;
echo "insira o ano (yyyy)"
read ano
echo "insira o mes (mm)"
read mes;
echo "insira o dia (dd)"
read dia;
echo "Insira o ID da transacao"
read id;


cd ~/

CP=`cp /orzasaeprd/orzasaeprd01/log/auth${operadora}_${dia}${mes}${ano}.debug.xz ~/`


GREP_BASE=`xzgrep -m1 -a ${id} /orzasaeprd/orzasaeprd01/log/auth${operadora}_${dia}${mes}${ano}.debug.xz | cut -c 1-18`
GREP01= `xzgrep -a ${GREP_BASE} /orzasaeprd/orzasaeprd01/log/auth${operadora}_${dia}${mes}${ano}.debug.xz > ~/auth${operadora}_${id}.txt `

remove_zip= `rm auth${operadora}_${dia}${mes}${ano}.debug.xz`

chmod 777 *

