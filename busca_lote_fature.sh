#!/bin/bash
  

#Seta os parametros da busca que será realizada abaixo
echo "#################################"
echo "#                               #"
echo "# Insira os dados do Lote:      #"
echo "#                               #"
echo "#################################"
echo
echo " ano (yyyy) "
echo " __________ " 
read ano
echo " mes (mm)"
echo " ________" 
read mes;
echo " dia (dd)"
echo " ________" 
read dia;
echo " hora (hh)"
echo " _________" 
read hora;
echo " Numero do Protocolo"
echo " __________________ " 
read protocolo;
echo "---------------------------------------------------- " 

#checa cada diretório de armazenamento de dados das ANDALUCIA de acordo com as infomações preenchidas acima
for ((i = 5; i < 9 ; i++))
do
        echo Executando comando: xzgrep $protocolo /andalucia0${i}/log/dmsf_admin.debug_${ano}${mes}${dia}_${hora}.xz
        xzgrep $protocolo /andalucia0${i}/log/dmsf_admin.debug_${ano}${mes}${dia}_${hora}.xz

        if [ $? -eq 1 ]; #caso o protocolo seja encontrado, o código cessa a busca
        then break;
        fi
        echo "---------------------------------------------------- " 
done