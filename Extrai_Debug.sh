#!/bin/bash
# Título: Extrai Debug de Transações autorize
# Descrição: Extrai informações sobre transações à serem analisadas e os adiciona em um arquivo de texto, tornando muito mais prática e assertiva a extração.
# Autor: Daniel Carvalho de Souza (Caxambu)
# Data: 08/03/2023
# Versão: V-2.2

# Solicitar entrada do usuário
echo "#################################"
echo "#                               #"
echo "# Insira os dados da transação: #"
echo "#                               #"
echo "#################################"
echo
read -p "Insira o nome da operadora (em minúsculo): " operadora
read -p "Insira o ano (yyyy): " ano
read -p "Insira o mês (mm): " mes
read -p "Insira o dia (dd): " dia
read -p "Insira o ID da transação: " id

# Validar entrada do usuário
if ! [[ "$ano" =~ ^[0-9]{4}$ ]]; then
  echo "Ano inválido: $ano"
  exit 1
fi
if ! [[ "$mes" =~ ^[0-9]{2}$ ]]; then
  echo "Mês inválido: $mes"
  exit 1
fi
if ! [[ "$dia" =~ ^[0-9]{2}$ ]]; then
  echo "Dia inválido: $dia"
  exit 1
fi

# Extrair informações do arquivo de log
log_file="/orzasaeprd/orzasaeprd01/log/auth${operadora}_${dia}${mes}${ano}.debug.xz"
grep_base=$(xzgrep -m1 -a "$id" "$log_file" | cut -c 1-18)
grep_output=$(xzgrep -a "$grep_base" "$log_file")

# Escrever saída em arquivo de texto
output_file="auth${operadora}_${id}.txt"
echo "$grep_output" > "$output_file"

# Excluir arquivo de log
rm "$log_file"

# Dar permissão de execução ao arquivo
chmod +x "$output_file"

echo "Arquivo de saída: $output_file"
# Fim do script
