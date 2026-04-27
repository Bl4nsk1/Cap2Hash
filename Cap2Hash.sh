#!/bin/bash

set -euo pipefail
DIR="handshakes_path"

cd "$DIR" || exit 1
shopt -s nullglob

for file in *.pcap *.cap; do
    output="${file%.*}.hc22000"

    echo "[*] Processing: $file"

    if hcxpcapngtool -o "$output" "$file" >/dev/null 2>&1; then

        if command -v hcxhashtool >/dev/null 2>&1; then
            if hcxhashtool -i "$output" >/dev/null 2>&1; then
                echo "[+] $file OK!"
            else
                echo "[-] Invalid hash for $file - removing output..."
                rm -f "$output"
            fi
        else
            if wlanhcxinfo -i "$output" >/dev/null 2>&1; then
                echo "[+] $file OK!"
            else
                echo "[-] Invalid hash for $file - removing output..."
                rm -f "$output"
            fi
        fi

    else
        echo "[!] Error converting file: $file"
    fi
done