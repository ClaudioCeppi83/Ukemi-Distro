# Architecture: Ukemi Distro

## 🎨 Overview

Ukemi Distro is an **Organic, Minimalist, and High-Performance** Linux distribution built following Linux From Scratch (LFS) principles. It is architected for ultra-low latency multimedia and gaming.

## 🧱 Core Pillars

1. **Zen Kernel**: Real-time patches and preemption for responsiveness.
2. **OpenRC Init**: Minimalistic and fast discovery-based initialization.
3. **Wayland/Sway Interface**: High-efficiency, low-overhead graphical environment.
4. **PipeWire Ecosystem**: Unified pro-audio and video handling.

## 📁 Directory Structure

- `core/`: Orchestration scripts for the LFS build process.
- `scripts/`: Implementation-specific scripts for Gaming, Multimedia, and Performance.
- `configs/`: Immutable configuration baselines for Kernel, Sway, and Services.
- `docker/`: The "Safe Harbor" build environment ensuring host isolation.
- `build/`: Temporary workspace for compilation (git-ignored).
- `.context/`: Machine-readable engineering specs for agentic autonomous development.

## 🛠️ Engineering Standards

- **Compiler Flags**: Strict `-O3 -march=native -pipe`.
- **Safety**: No `sudo` in automated builders; mandatory SHA256 verification.
- **Optimization**: Binary stripping and aggressive RAM management via zRam.

## 🔄 Build Workflow

1. `make init`: Environment setup.
2. `make fetch-sources`: Manifest verification and download.
3. `make validate`: QA/Security linting.
4. `make toolchain-p1`: Cross-compiler generation.
5. `ISO Creation`: Final system bundling.
