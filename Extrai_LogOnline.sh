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
#echo "insira o ano"
#read ano;
 
echo "insira o mes (para dias menores que 10, apenas um digito) "
read mes;

echo "insira o dia (para dias menores que 10, apenas um digito) "
read dia;

#echo "Insira a hora(2 digitos)"
#read hora;

decisao=1

while [ $decisao = 1 ]
do

echo "Insira o ID "
read id;



#informacao exibida na tela apos a insercao dos dados e inicio da extracao. 
echo
echo
echo "####################################################################"
echo "# Retirando Xml de LogOnline da transacao $id ...            #"
echo "####################################################################"
echo
echo
   
   #diretorio em que estao localizados arquivos de LogOnline 
	cd /var/log/autorizador/madrid01/log/xz
	
			#realiza uma busca por todos os arquivos de LogOnline do mes em que a transacao foi realizada em diante
			for ((a=$mes;a<=12;a++))
			do
					#realiza uma busca por todos os arquivos de LogOnline dia a dia a partir do mes escolhido 
					for ((i=1;i<=31;i++))
					do
							if [ $a -eq $mes ]&&[ $i -lt $dia ]   
								then
									i=$dia;
							fi
			
							#Verifica se o dia e menor que 10. caso for, e inserido um zero no comando para encontrar o arquivo (pois nas iteracoes do laco for as variaveis "i"                              e "a" nao sao  geradas com zero a esquerda).
							if [ $i -lt 10 ]&& [ $a -lt 10 ]
								then
									xzgrep -a $id XPorter346-LOG.log.2017'0'$a'0'$i*|grep trn_numero >> /var/log/autorizador/temp/LogOnline_$id''.txt
			
								    RESPOSTA=`xzgrep -a $id XPorter346-LOG.log.2017'0'$a'0'$i*|grep trn_numero|cut -d " " -f18`
									echo $RESPOSTA                            			                   	

		
							elif [ $i -lt 10 ]&&[ $a -gt 10 ] 
								then
									xzgrep -a $id XPorter346-LOG.log.2017$a'0'$i*|grep trn_numero >> /var/log/autorizador/temp/LogOnline_$id''.txt					
	                        		
									RESPOSTA=`xzgrep -a $id XPorter346-LOG.log.2017$a'0'$i*|grep trn_numero|cut -d " " -f18`
                                    echo $RESPOSTA
				

							elif [ $i -gt 9 ]&&[ $a -lt 10 ]	
								then
									xzgrep -a $id XPorter346-LOG.log.2017'0'$a$i*|grep trn_numero >> /var/log/autorizador/temp/LogOnline_$id''.txt

									RESPOSTA=`xzgrep -a $id XPorter346-LOG.log.2017'0'$a$i*|grep trn_numero|cut -d " " -f18`
                                    echo $RESPOSTA

									
                  			elif [ $i -gt 9 ]&&[ $a -gt 10 ]
								then
									xzgrep -a $id XPorter346-LOG.log.2017$a$i*|grep trn_numero >> /var/log/autorizador/temp/LogOnline_$id''.txt
									
									RESPOSTA=`xzgrep -a $id XPorter346-LOG.log.2017$a$i*|grep trn_numero|cut -d " " -f18`
                                    echo $RESPOSTA

							fi	
	
							
													
							
	   			    done

					
			       
                    #reset da variavel "i" para que ela possa recomecar a coletar dados do mes seguinte
					i=1
									

			done

done


cd /var/log/autorizador/temp
chmod 777 * 
echo
echo
echo "#####################################"
echo "# Extracao LogOnline finalizada     #"
echo "# Arquivo txt gerado na pasta:      #"
echo "# /var/log/autorizador/temp         #"
echo "#####################################"
echo
echo

