#!/bin/bash

# Modul 2: Pengarsipan dan Integritas Log

INPUT="data/processed"
ARCHIVE="archive/log-arsip.tar.gz"
CHECKSUM="checksum/log-arsip.sha256"

# Validasi folder input
if [ ! -d "$INPUT" ] || [ -z "$(ls -A "$INPUT")" ]; then
    echo "Error: Data hasil pemilahan tidak ditemukan!"
    exit 1
fi

# Membuat folder penyimpanan
mkdir -p archive checksum

# Membuat arsip
tar -czf "$ARCHIVE" -C data processed

# Memeriksa keberhasilan arsip
if [ $? -ne 0 ]; then
    echo "Error: Pengarsipan gagal!"
    exit 1
fi

# Membuat checksum
sha256sum "$ARCHIVE" > "$CHECKSUM"

echo "Pengarsipan berhasil!"
echo "Checksum berhasil dibuat!"

