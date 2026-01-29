#!/bin/bash
set -e

PKG_NAME="gcc"
PKG_VERSION="13.2.0"
TARBALL="gcc-13.2.0.tar.xz"

echo "📦 Building $PKG_NAME-$PKG_VERSION (Pass 1)..."

cd /mnt/ukemi/build
tar -xf "sources/$TARBALL"
cd gcc-13.2.0

# GCC requires MPFR, GMP, and MPC. LFS usually extracts them into the gcc source tree.
# We'll assume the downloader already handled them or we'll fetch them if missing, 
# but for a standard LFS pass 1, we often use the host's version if present in the container
# OR we should have downloaded them. Let's assume we need to handle them here if they aren't in the manifest.
# For simplicity in this step, I'll use the 'contrib/download_prerequisites' script if possible,
# or better, I should have included them in the manifest.
# SINCE my manifest didn't have them, I'll add them to the manifest or download them now.
# Actually, the Dockerfile.builder has build-essential, but for cross-gcc it's better to have them in-tree.

./contrib/download_prerequisites

mkdir -v build
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

make -j$(nproc)
make install

cd ..
cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
  `dirname $($LFS_TGT-gcc -print-libgcc-file-name)`/include/limits.h

cd /mnt/ukemi/build
rm -rf gcc-13.2.0
echo "✅ $PKG_NAME built successfully."
