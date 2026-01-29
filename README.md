# 🌀 Ukemi Distro
### *The High-Performance Multimedia Linux Distribution from Scratch*

[![License: MIT](https://img.shields.io/badge/License-MIT-purple.svg)](https://opensource.org/licenses/MIT)
[![Engine: LFS](https://img.shields.io/badge/Base-LFS-orange.svg)](https://www.linuxfromscratch.org/)
[![Kernel: Liquorix/Zen](https://img.shields.io/badge/Kernel-Liquorix/Zen-blue.svg)](https://liquorix.net/)

Ukemi Distro is a specialized Linux distribution built from the ground up (**Linux From Scratch**) designed for creators, gamers, and performance enthusiasts. It eliminates all unnecessary layers to provide an ultra-low latency environment for professional audio (DAW), video editing, and high-frame-rate gaming.

---

## 🔥 Key Features

*   **⚡ Zen/Liquorix Kernel**: Patched for low-latency I/O and real-time process priority.
*   **🎵 Pro Audio Stack**: Native **PipeWire** implementation with pre-configured 48kHz/128-sample buffers for zero-lag audio.
*   **🎮 Wayland + Sway**: A modern, lightweight tiling window manager that consumes < 150MB RAM.
*   **🚀 Efficient Memory**: **zRam** with `zstd` compression and `earlyoom` for aggressive resource management.
*   **🛠️ Optimized Toolchain**: Every binary is compiled with `-march=native -O3` and stripped to the bone.

---

## 🏗️ Project Architecture

The project is managed by an autonomous agent ecosystem following strict engineering specs:

*   **`.context/`**: Intelligence and architectural rules for the agents.
*   **`core/`**: Orchestration logic and LFS build scripts.
*   **`docker/`**: Isolated build environment (Sandbox) to ensure host safety.
*   **`scripts/`**: Automation hooks and safe command wrappers.

---

## 🚀 Quick Start

### 1. Requirements
*   **Docker** (highly recommended for isolation).
*   **Python 3.11+**.
*   **Make**.

### 2. Initialization
```bash
make init
```

### 3. Fetch Source Packages
```bash
make fetch-sources
```

### 4. Enter the Build Sandbox
```bash
make build-env
```

---

## 🔒 Security & Safety

Ukemi development follows a **Strict Isolation Policy**:
- All builds occur inside a **Docker Sandbox**.
- No `sudo` is allowed inside automated scripts.
- Source integrity is verified via **SHA256 Manifests**.

---

## 📄 License
This project is licensed under the MIT License.
