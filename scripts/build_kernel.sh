#!/bin/bash
# scripts/build_kernel.sh
# Build script for Ukemi Zen Kernel (kernel-optimizer skill)

set -e

KERNEL_VERSION="6.6.15" # Example stable version
KERNEL_URL="https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-${KERNEL_VERSION}.tar.xz"
BUILD_DIR="/mnt/ukemi/build/kernel"
CONFIG_FILE="/mnt/ukemi/configs/kernel.config"

# 1. Prepare Environment
echo "🏗️  Preparing Kernel Build Environment..."
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

if [ ! -f "linux-${KERNEL_VERSION}.tar.xz" ]; then
    echo "📥 Downloading Kernel v${KERNEL_VERSION}..."
    curl -L -O "$KERNEL_URL"
fi

if [ ! -d "linux-${KERNEL_VERSION}" ]; then
    echo "📦 Extracting Kernel..."
    tar -xf "linux-${KERNEL_VERSION}.tar.xz"
fi

cd "linux-${KERNEL_VERSION}"

# 2. Configure Kernel
echo "⚙️  Configuring Kernel (Zen/Low-Latency)..."

if [ -f "$CONFIG_FILE" ]; then
    cp "$CONFIG_FILE" .config
else
    make defconfig
fi

# Apply Mandatory Flags (kernel-optimizer)
scripts/config --enable CONFIG_PREEMPT
scripts/config --disable CONFIG_PREEMPT_NONE
scripts/config --enable CONFIG_PREEMPT_RT # Optional but recommended for creative work
scripts/config --set-val CONFIG_HZ 1000
scripts/config --enable CONFIG_HZ_1000

# Optimization Flags
export KCFLAGS="-O3 -march=native -pipe"

# 3. Build
echo "🚀 Starting Kernel Build (this will take a while)..."
make -j$(nproc)

# 4. Strip Binaries
echo "🪄  Stripping Kernel Modules..."
find . -name "*.ko" -exec strip --strip-unneeded {} +

echo "✅ Kernel Build Completed."
