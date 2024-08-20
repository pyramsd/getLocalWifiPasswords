#!/bin/bash

if [ $EUID -ne 0 ]; then
        echo "Pemission denied"
        exit 1
fi

for file in /etc/NetworkManager/system-connections/*; do
    if [ -f "$file" ]; then
        # Lee las líneas que contienen 'id' y 'psk'
        id=$(grep '^id=' "$file" | cut -d '=' -f 2 | tr -d ' ')
        psk=$(grep '^psk=' "$file" | cut -d '=' -f 2 | tr -d ' ')
        # Si ambos valores están presentes, imprímelos
        if [ -n "$id" ] && [ -n "$psk" ]; then
            echo "$id = $psk"
        fi
    fi
done
