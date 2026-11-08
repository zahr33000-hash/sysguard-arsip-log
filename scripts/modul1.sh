#!/bin/bash

# Modul 1: Pengumpulan dan Pemilahan Log

INPUT="data/raw/system.log"
OUTPUT="data/processed"

# Fungsi mencatat aktivitas
catat_log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> logs/activity.log
}

# Validasi file input
if [ ! -f "$INPUT" ]; then
    echo "Error: File log tidak ditemukan!"
    catat_log "GAGAL: File input tidak ditemukan"
    exit 1
fi

# Membuat folder output
mkdir -p "$OUTPUT"

# Memilah log berdasarkan kategori
grep "^INFO:" "$INPUT" > "$OUTPUT/info.log"
grep "^WARNING:" "$INPUT" > "$OUTPUT/warning.log"
grep "^ERROR:" "$INPUT" > "$OUTPUT/error.log"

# Membuat ringkasan
{
    echo "RINGKASAN LOG"
    echo "Total INFO: $(grep -c '^INFO:' "$INPUT")"
    echo "Total WARNING: $(grep -c '^WARNING:' "$INPUT")"
    echo "Total ERROR: $(grep -c '^ERROR:' "$INPUT")"
} > "$OUTPUT/summary.txt"

catat_log "BERHASIL: Pemilahan log selesai"

echo "Pemilahan log berhasil!"
echo "Hasil tersimpan di folder $OUTPUT"
