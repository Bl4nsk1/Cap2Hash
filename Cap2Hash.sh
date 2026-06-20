#!/bin/bash

set -uo pipefail

if [ $# -ne 1 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

DIR="$1"

if [ ! -d "$DIR" ]; then
    echo "[ERROR] Directory not found: $DIR"
    exit 1
fi

if ! command -v hcxpcapngtool >/dev/null 2>&1; then
    echo "[ERROR] hcxpcapngtool not found. Install hcxtools."
    exit 1
fi

cd "$DIR" || {
    echo "[ERROR] Failed to access directory: $DIR"
    exit 1
}

shopt -s nullglob

files=(*.pcap *.cap *.pcapng)

if [ ${#files[@]} -eq 0 ]; then
    echo "[INFO] No .pcap, .cap or .pcapng files found in $DIR"
    exit 0
fi

converted=0
skipped=0
failed=0

echo "[INFO] Found ${#files[@]} capture file(s)"
echo

for file in "${files[@]}"; do
    output="${file%.*}.hc22000"

    if [ -f "$output" ]; then
        echo "[SKIP] $output already exists"
        ((++skipped))
        continue
    fi

    echo "[*] Converting: $file"

    if hcxpcapngtool -o "$output" "$file" >/dev/null 2>&1; then
        if [ -s "$output" ]; then
            echo "[+] Success: $file -> $output"
            ((++converted))
        else
            echo "[-] Empty output generated for $file"
            rm -f "$output"
            ((++failed))
        fi
    else
        echo "[!] Conversion failed: $file"
        rm -f "$output"
        ((++failed))
    fi

    echo
done

echo "======================================"
echo "[DONE]"
echo "Total files : ${#files[@]}"
echo "Converted   : $converted"
echo "Skipped     : $skipped"
echo "Failed      : $failed"
echo "======================================"
