---
name: qa-validator
description: La más importante para tu seguridad. Ejecuta shellcheck, verifica que no haya sudo en scripts automatizados y hace el "Dry Run" en chroot antes de generar la ISO.
---

# QA & Security Validator

Esta skill es el guardián de calidad y seguridad de Ukemi Distro, aplicando los estándares de `00_engineering_specs.md` (Sección 3) y `99_negatives.md`.

## 1. Validación Estática (Linting)

- **ShellCheck**: Ejecutar obligatoriamente en todos los scripts `.sh` en `/scripts`, `/core`, etc.
  - No permitir errores (exit code debe ser 0).
- **No Sudo**: Escanear scripts automatizados en busca de `sudo`.
  - **Regla**: El uso de `sudo` está prohibido dentro de scripts de construcción desatendidos. El entorno debe tener los permisos correctos desde fuera o usar fakeroot.

## 2. Validación de Configuración

- **Kernel Config Check**:
  - Parsear el archivo `.config` del kernel antes de compilar.
  - **Fallo Inmediato** si faltan: `CONFIG_HZ=1000`, `CONFIG_PREEMPT=y`.

## 3. Pruebas Dinámicas (Simulation)

- **Dry Run**: Ejecutar una instalación simulada en un entorno `chroot` desechable antes de tocar la imagen real.
- **Boot Test Requirements**: Verificar que la ISO generada sea capaz de arrancar en QEMU con < 256MB RAM (según spec).

## 4. Integridad

- **Manifests**: Verificar checksums SHA256 de todos los source tarballs antes de procesarlos.
