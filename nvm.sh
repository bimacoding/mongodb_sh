#!/bin/bash

# Pastikan skrip dijalankan dengan hak akses root
if [ "$EUID" -ne 0 ]; then
    echo "Silakan jalankan skrip ini dengan sudo atau sebagai root."
    exit 1
fi

# Menginstal dependensi yang diperlukan
echo "Menginstal dependensi yang diperlukan..."
apt update
apt install -y curl

# Mengunduh dan menginstal NVM
echo "Mengunduh dan menginstal NVM..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

# Memuat nvm ke dalam sesi shell saat ini
echo "Memuat NVM ke dalam sesi shell saat ini..."
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # Memuat NVM ke dalam shell

# Sourcing .bashrc untuk menggunakan nvm
echo "Menambahkan NVM ke .bashrc..."
echo "export NVM_DIR=\"$HOME/.nvm\"" >> ~/.bashrc
echo "[ -s \"$NVM_DIR/nvm.sh\" ] && \. \"$NVM_DIR/nvm.sh\"" >> ~/.bashrc

# Memuat ulang .bashrc
source ~/.bashrc

# Memeriksa versi NVM
echo "Memeriksa versi NVM..."
nvm --version

# Menampilkan versi Node.js yang tersedia
echo "Menampilkan versi Node.js yang tersedia..."
nvm list-remote

# Menginstal versi Node.js (ubah versi sesuai kebutuhan)
NODE_VERSION="v18.17.0"
echo "Menginstal Node.js versi $NODE_VERSION..."
nvm install $NODE_VERSION

# Mengatur versi default Node.js
nvm alias default $NODE_VERSION

# Memeriksa versi Node.js yang terinstal
echo "Memeriksa versi Node.js yang terinstal..."
node -v

# Memeriksa versi npm yang terinstal
echo "Memeriksa versi npm yang terinstal..."
npm -v

echo "Instalasi NVM dan Node.js selesai!"
