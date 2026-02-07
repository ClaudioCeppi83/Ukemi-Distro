#!/bin/bash
set -e

export PATH=$LFS/tools/bin:$PATH
PKG_NAME="binutils"
PKG_VERSION="2.41"
TARBALL="binutils-2.41.tar.xz"

echo "📦 Building $PKG_NAME-$PKG_VERSION (Pass 1)..."

cd /mnt/ukemi/build
tar -xf "sources/$TARBALL"
cd binutils-2.41

mkdir -v build
cd build

../configure --prefix=$LFS/tools \
             --with-sysroot=$LFS \
             --target=$LFS_TGT \
             --disable-nls \
             --enable-gprofng=no \
             --disable-werror \
             --enable-default-hash-style=gnu \
             --disable-gprof

make -j4
sync
make install || (sleep 2 && sync && make install)

cd /mnt/ukemi/build
rm -rf binutils-2.41
echo "✅ $PKG_NAME built successfully."
