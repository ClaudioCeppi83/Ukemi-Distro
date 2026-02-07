#!/bin/bash
set -e

export PATH=$LFS/tools/bin:$PATH
PKG_NAME="linux-headers"
# We are using the zen-kernel tag v6.7.4-zen1 based on manifest
TARBALL="v6.7.4-zen1.tar.gz"

echo "📦 Installing Linux API Headers..."

cd /mnt/ukemi/build
tar -xf "sources/$TARBALL"
cd zen-kernel-6.7.4-zen1

make mrproper
make headers
find usr/include -type f ! -name '*.h' -delete
cp -rv usr/include/* $LFS/usr/include

cd /mnt/ukemi/build
rm -rf zen-kernel-6.7.4-zen1
echo "✅ Linux headers installed successfully."
