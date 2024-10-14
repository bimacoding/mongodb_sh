#!/bin/bash

# Pastikan skrip dijalankan dengan hak akses root
if [ "$EUID" -ne 0 ]; then
    echo "Silakan jalankan skrip ini dengan sudo atau sebagai root."
    exit 1
fi

# Memperbarui paket
echo "Memperbarui daftar paket..."
apt update

# Menginstal dependensi
echo "Menginstal dependensi yang diperlukan..."
apt install -y wget gnupg

# Menambahkan kunci GPG MongoDB
echo "Menambahkan kunci GPG MongoDB..."
wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | apt-key add -

# Menambahkan repositori MongoDB
echo "Menambahkan repositori MongoDB..."
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/multiverse amd64 Packages" \
    | tee /etc/apt/sources.list.d/mongodb-org-6.0.list

# Memperbarui daftar paket setelah menambahkan repositori
echo "Memperbarui daftar paket setelah menambahkan repositori..."
apt update

# Menginstal MongoDB
echo "Menginstal MongoDB versi 6.0.18..."
apt install -y mongodb-org=6.0.18 mongodb-org-server=6.0.18 mongodb-org-shell=6.0.18 mongodb-org-mongos=6.0.18 mongodb-org-tools=6.0.18

# Memulai layanan MongoDB
echo "Memulai layanan MongoDB..."
systemctl start mongod

# Mengaktifkan MongoDB agar berjalan saat boot
echo "Mengaktifkan MongoDB agar berjalan saat boot..."
systemctl enable mongod

# Menampilkan status MongoDB
echo "Menampilkan status MongoDB..."
systemctl status mongod

echo "Instalasi MongoDB selesai!"
