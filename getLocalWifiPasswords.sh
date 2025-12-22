#!/bin/bash

if [ $EUID -ne 0 ]; then
        echo "Pemission denied"
        echo "Run: sudo ./getLocalWifiPasswords.sh"
        exit 1
fi

output="SSID\tPSK\n----\t---"-
for file in /etc/NetworkManager/system-connections/*; do
    if [ -f "$file" ]; then
        id=$(grep '^id=' "$file" | cut -d '=' -f 2 | tr -d ' ')
        psk=$(grep '^psk=' "$file" | cut -d '=' -f 2 | tr -d ' ')
        if [ -n "$id" ] && [ -n "$psk" ]; then
            output="$output\n$id\t$psk"
        fi
    fi
done

echo -e "$output" | column -s $'\t' -t
