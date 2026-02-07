# Guía de Arquitectura: Core del Sistema

## 1. Identidad

- **Base:** Estructura LFS (Linux From Scratch) para evitar bloatware.
- **Kernel:** Zen Kernel o Liquorix (Branch: Stable).
- **Init System:** OpenRC (por su ligereza y velocidad frente a systemd).

## 2. Reglas de Compilación (Toolchain)

- **Compilador:** GCC 13+ con soporte para binutils.
- **Flags Globales:** `-O3 -march=native -pipe -fomit-frame-pointer`.
- **C-Library:** Glibc (estándar para máxima compatibilidad multimedia).
- **Stripping:** Es obligatorio ejecutar `strip --strip-unneeded` en todos los binarios finales.

## 3. Kernel Config (Prioridades)

- Habilitar `CONFIG_HZ=1000`.
- Habilitar `CONFIG_PREEMPT=y`.
- Desactivar soporte para hardware legado (disqueteras, drivers de red de los 90).
- Compilar drivers de GPU (AMDGPU/NVIDIA) como módulos `built-in` si el hardware es conocido.
