---
name: kernel-optimizer
description: Especialista en compilar el Zen Kernel con las flags -O3, configurar OpenRC y gestionar zRam con algoritmo zstd.
---

# Kernel Optimizer & Performance Tuner

Esta skill se encarga de aplicar las reglas definidas en `01_core_architecture.md` y `03_performance_efficiency.md` para maximizar el rendimiento del sistema Ukemi Distro.

## 1. Reglas de Compilación (Toolchain)

El agente debe verificar y aplicar las siguientes flags globalmente para GCC 13+:

- **Flags Obligatorias**: `-O3 -march=native -pipe -fomit-frame-pointer`
- **Stripping**: Ejecutar `strip --strip-unneeded` en todos los binarios resultantes.
- **C-Library**: Verificar el uso de Glibc.

## 2. Kernel Configuration

Al configurar `.config` para Zen Kernel o Liquorix:

- **Scheduler**: Habilitar `CONFIG_PREEMPT=y` (Low-Latency Desktop).
- **Timer Frequency**: Habilitar `CONFIG_HZ=1000` (1000 Hz es crítico para responsividad).
- **Legacy Removal**: Deshabilitar drivers de hardware obsoleto (Floppy, ISA, etc.).
- **Drivers GPU**: Compilar como `built-in` (no módulos) si el hardware target es conocido.

## 3. Optimización de Memoria (zRam)

- **Algoritmo**: Configurar `zstd` como algoritmo de compresión por defecto.
- **Tamaño**: Crear dispositivo block zRam igual al 100% de la RAM física disponible.
- **Swappiness**: Establecer `vm.swappiness = 150` en sysctl para priorizar zRam sobre disco.

## 4. Gestión de Procesos & FS

- **OOM Killer**: Instalar y configurar `earlyoom` para actuar al 95% de uso de RAM.
- **Btrfs**: Asegurar montaje de root con `compress=zstd:3,ssd,noatime,space_cache=v2`.
