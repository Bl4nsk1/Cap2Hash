<p align="center">
  <img src="static/cap2hash_banner_clean.png">
</p>

<p align="center">
  <b>PCAP/CAP → HC22000 Converter for WPA/WPA2 Cracking</b><br>
  Fast, automated and reliable handshake conversion
</p>

<p align="center">
  <img src="https://img.shields.io/badge/version-1.0-blue">
  <img src="https://img.shields.io/badge/bash-script-green">
  <img src="https://img.shields.io/badge/status-active-success">
  <img src="https://img.shields.io/github/license/Bl4nsk1/Cap2Hash">
</p>

---

## ⚡ Overview

Cap2Hash is a lightweight automation tool designed to convert `.pcap`
and `.cap` Wi-Fi capture files into **Hashcat-compatible `.hc22000`
hashes**.

------------------------------------------------------------------------

## 🔥 Features

-   Batch processing of `.pcap` and `.cap`
-   Automatic conversion to `.hc22000`
-   Hash validation
-   Auto-clean invalid outputs
-   Fast and silent execution

------------------------------------------------------------------------

## 🛠 Requirements

-   bash
-   hcxpcapngtool
-   hcxhashtool (optional)
-   wlanhcxinfo (fallback)

------------------------------------------------------------------------

## 🚀 Usage

``` bash
chmod +x cap2hash.sh
./cap2hash.sh
```

Edit:

``` bash
DIR="handshakes_path"
```

------------------------------------------------------------------------

## 📂 Output

    input.pcap → input.hc22000

------------------------------------------------------------------------

## ⚙️ Workflow

    PCAP/CAP → Convert → Validate → Output

------------------------------------------------------------------------

## 📜 License
MIT License

Copyright (c) 2026 Bl4nsk1

------------------------------------------------------------------------

## 👤 Author

Bl4nsk1
