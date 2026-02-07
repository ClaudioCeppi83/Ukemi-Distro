#!/bin/bash
set -e

export PATH=$LFS/tools/bin:$PATH
PKG_NAME="gcc"
PKG_VERSION="13.2.0"
TARBALL="gcc-13.2.0.tar.xz"

echo "📦 Building $PKG_NAME-$PKG_VERSION (Pass 1)..."

cd /mnt/ukemi/build
if [ -d "gcc-13.2.0" ]; then
    rm -rf gcc-13.2.0
fi
tar -xf "sources/$TARBALL"
cd gcc-13.2.0

# GCC requires MPFR, GMP, and MPC...
./contrib/download_prerequisites

mkdir -pv build
cd build

../configure                  \
    --target=$LFS_TGT         \
    --prefix=$LFS/tools       \
    --with-glibc-version=2.38 \
    --with-sysroot=$LFS       \
    --with-newlib             \
    --without-headers         \
    --enable-default-pie      \
    --enable-default-ssp      \
    --disable-nls             \
    --disable-shared          \
    --disable-multilib        \
    --disable-threads         \
    --disable-libatomic       \
    --disable-libgomp         \
    --disable-libquadmath     \
    --disable-libssp          \
    --disable-libvtv          \
    --disable-libstdcxx       \
    --enable-languages=c,c++

# 3. Build
echo "🚀 Starting GCC Build (Pass 1) - Using j2 for stability..."
make -j2 || make -j1
sync
make install

cd ..
cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
  `dirname $($LFS_TGT-gcc -print-libgcc-file-name)`/include/limits.h

cd /mnt/ukemi/build
rm -rf gcc-13.2.0
echo "✅ $PKG_NAME built successfully."
