#!/bin/bash

# Define uma função para imprimir mensagens de status
print_status() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

# Pede ao usuário os parâmetros de data/hora e número do protocolo
echo "#################################"
echo "#                               #"
echo "# Insira os dados do Lote:      #"
echo "#                               #"
echo "#################################"
echo
while true; do
    read -p "ano (yyyy): " ano
    if [[ $ano =~ ^[0-9]{4}$ ]]; then
        break
    fi
    echo "Por favor insira um ano válido (yyyy)"
done
while true; do
    read -p "mes (mm): " mes
    if [[ $mes =~ ^((0?[1-9])|1[0-2])$ ]]; then
        break
    fi
    echo "Por favor insira um mês válido (mm)"
done
while true; do
    read -p "dia (dd): " dia
    if [[ $dia =~ ^((0?[1-9])|([1-2][0-9])|3[0-1])$ ]]; then
        break
    fi
    echo "Por favor insira um dia válido (dd)"
done
while true; do
    read -p "hora (hh): " hora
    if [[ $hora =~ ^((0?[0-9])|([0-1][0-9])|2[0-3])$ ]]; then
        break
    fi
    echo "Por favor insira uma hora válida (hh)"
done
read -p "Numero do Protocolo: " id


# Realiza a busca
print_status "Buscando log..."
ANDALUCIA=$(find /andalucia/andalucia*/log/ -name "dmsf_motor_regra.debug_${ano}${mes}${dia}_${hora}.xz" -print -quit | cut -c 12-22 | xargs basename)
if [[ -z $ANDALUCIA ]]; then
    echo "Erro: O log não foi encontrado."
    exit 1
fi
print_status "Log encontrado no servidor $ANDALUCIA"
print_status "Buscando ocorrência de protocolo..."
GREP_BASE=$(xzgrep -naF "${id}" "/andalucia/${ANDALUCIA}/log/dmsf_motor_regra.debug_${ano}${mes}${dia}_${hora}.xz" | sed -n '4p')
GREP01=$(xzgrep -aF "${GREP_BASE}" "/andalucia/${ANDALUCIA}/log/dmsf_motor_regra.debug_${ano}${mes}${dia}_${hora}.xz" | less > ~/dmsf_motor_regra.debug_${id}.txt)
