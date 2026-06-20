#!/bin/bash

set -euo pipefail

DIR="${1:-/path/handshakes/}"

if [ ! -d "$DIR" ]; then
    echo "[ERROR] Directory not found: $DIR"
    exit 1
fi

if ! command -v hcxpcapngtool >/dev/null 2>&1; then
    echo "[ERROR] hcxpcapngtool not found. Install hcxtools."
    exit 1
fi

cd "$DIR"
shopt -s nullglob

files=(*.pcap *.cap)

if [ ${#files[@]} -eq 0 ]; then
    echo "[INFO] No .pcap or .cap files found in $DIR"
    exit 0
fi

converted=0
skipped=0
failed=0

for file in "${files[@]}"; do
    output="${file%.*}.hc22000"

    if [ -f "$output" ]; then
        echo "[SKIP] $output already exists"
        ((skipped++))
        continue
    fi

    echo "[*] Converting: $file"

    if hcxpcapngtool -o "$output" "$file" 2>&1 | grep -q "written to"; then

        if [ -s "$output" ]; then
            echo "[+] $file -> $output OK!"
            ((converted++))
        else
            echo "[-] Empty output for $file - removing..."
            rm -f "$output"
            ((failed++))
        fi

    else
        echo "[!] Failed: $file"
        rm -f "$output"
        ((failed++))
    fi
done

echo ""
echo "[DONE] Total: ${#files[@]} | Converted: $converted | Skipped: $skipped | Failed: $failed"
