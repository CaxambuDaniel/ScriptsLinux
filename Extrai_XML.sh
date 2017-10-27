#!/bin/bash

#Caxambu
#este Script pega os logs que sao gerados no  envio de transacoes para operadoras roteadas e gera um arquivo .txt com todas as tentativas para um determinado ID

#Limpa a tela assim que o script e executado
clear


# Variaveis que Armazenam dados necessarios para a extracao dos arquivos
echo "#################################"
echo "#                               #"
echo "# Insira os dados da transacao: #"
echo "#                               #"
echo "#################################"
echo
echo "insira o ano"
read ano;

echo "insira o mes"
read mes;

echo "insira o dia"
read dia;

echo "Insira a hora(2 digitos)"
read hora;

echo "Insira o ID "
read id;



#Validacoes realizadas para verificar o local em que o arquivo desejado deve ser procurado
if [[ $dia -gt `date +%d -d "7 days ago"` && $mes -lt `date +%m` ]];
	then
		`cp /var/log/autorizador/madrid01/transacoes/$ano-$mes-$dia''.tar.xz /var/log/autorizador/temp/ > /dev/null  2>&1 `	
		
		
			elif [[ $ano = `date +%Y` ]];
				then
					`cp /var/log/autorizador/madrid01/transacoes/$ano/$mes/$ano-$mes-$dia''.tar.xz /var/log/autorizador/temp/ > /dev/null  2>&1 `
					
				
				 elif [[ $ano = `date +%Y -d "1 year ago"` ]];
					then	
						`cp /var/log/autorizador/madrid01/transacoes/$ano/$mes/$ano-$mes-$dia''.tar.xz /var/log/autorizador/temp/ > /dev/null  2>&1 `
	                    		
fi

#vai ate a pasta em que sera realizada a busca pelo xml no arquivo e o descompacta
`cd /var/log/autorizador/temp;tar -xvf $ano-$mes-$dia''.tar.xz > /dev/null  2>&1`

	 cd /var/log/autorizador/temp/opt/autorizador/transacoes/$ano-$mes-$dia/$hora/> /dev/null  2>&1
		 if [ $? -eq 0 ];
        	  then
            	  cd /var/log/autorizador/temp/opt/autorizador/transacoes/$ano-$mes-$dia/$hora/
		 else
                  cd /var/log/autorizador/temp/$ano-$mes-$dia/$hora/			
		 fi	


SEARCH=`grep -o -a -m 1 $id *| awk -F : '{print $1}'`
CONVERT=`unix2dos $SEARCH `
CPDebug=`cp $SEARCH /var/log/autorizador/temp/`


echo "deseja realizar outra operacao? (1 - sim / 2 - nao)"
read decisao


cd /var/log/autorizador/temp
chmod 777 *
echo
echo
echo "########################"
echo "# Processo  finalizado #"
echo "########################"
echo




				


