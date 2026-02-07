#!/bin/bash
set -e

export PATH=$LFS/tools/bin:$PATH
PKG_NAME="libstdc++"
PKG_VERSION="13.2.0"
TARBALL="gcc-13.2.0.tar.xz"

echo "📦 Building $PKG_NAME (Pass 1)..."

cd /mnt/ukemi/build
tar -xf "sources/$TARBALL"
cd gcc-13.2.0

mkdir -v build
cd build

../libstdc++-v3/configure           \
    --host=$LFS_TGT                 \
    --build=$(../config.guess)      \
    --prefix=/usr                   \
    --disable-multilib              \
    --disable-nls                   \
    --disable-libstdcxx-pch         \
    --with-gxx-include-dir=/tools/$LFS_TGT/include/c++/13.2.0

make -j$(nproc)
DESTDIR=$LFS make install

cd /mnt/ukemi/build
rm -rf gcc-13.2.0
echo "✅ $PKG_NAME built successfully."
