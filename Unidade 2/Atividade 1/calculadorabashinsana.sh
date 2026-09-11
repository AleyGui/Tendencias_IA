#!/bin/bash

echo "=== Calculadora Bash ==="

read -p "Digite o primeiro número: " n1
read -p "Digite o operador (+ - * /): " op
read -p "Digite o segundo número: " n2

case "$op" in
    +)
        resultado=$((n1 + n2))
        ;;
    -)
        resultado=$((n1 - n2))
        ;;
    \*)
        resultado=$((n1 * n2))
        ;;
    /)
        if [ "$n2" -eq 0 ]; then
            echo "Erro: divisão por zero!"
            exit 1
        fi
        resultado=$((n1 / n2))
        ;;
    *)
        echo "Operador inválido!"
        exit 1
        ;;
esac

echo "Resultado: $resultado"
