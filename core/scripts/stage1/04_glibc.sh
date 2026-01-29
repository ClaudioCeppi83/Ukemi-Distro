#!/bin/bash
set -e

PKG_NAME="glibc"
PKG_VERSION="2.38"
TARBALL="glibc-2.38.tar.xz"

echo "📦 Building $PKG_NAME-$PKG_VERSION..."

cd /mnt/ukemi/build
tar -xf "sources/$TARBALL"
cd glibc-2.38

case $(uname -m) in
    i?86)   ln -sfv ld-linux.so.2 $LFS/lib/ld-lsb.so.3
    ;;
    x86_64) ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64
            ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64/ld-lsb-x86-64.so.3
    ;;
esac

patch -Np1 -i ../sources/glibc-2.38-fhs-1.patch || echo "No patch found, skipping"

mkdir -v build
cd build

echo "rootsbindir=/usr/sbin" > configparms

../configure                             \
      --prefix=/usr                      \
      --host=$LFS_TGT                    \
      --build=$(../scripts/config.guess) \
      --enable-kernel=4.14               \
      --with-headers=$LFS/usr/include    \
      --disable-nls                      \
      libc_cv_slibdir=/usr/lib

make -j$(nproc)
DESTDIR=$LFS make install

# Fix ldd path
sed -i 's|/usr/bin/perl|/usr/bin/with-perl-is-not-here|' $LFS/usr/bin/ldd

cd /mnt/ukemi/build
rm -rf glibc-2.38
echo "✅ $PKG_NAME built successfully."
