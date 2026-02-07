# Guía de Rendimiento: Optimización de Recursos

## 1. Gestión de Memoria (zRam)

- **Algoritmo:** `zstd` (Mejor balance compresión/CPU).
- **Configuración:** Crear dispositivo zRam igual al 100% de la RAM física.
- **Swappiness:** Configurar `vm.swappiness = 150` para forzar el uso de zRam antes que el disco.

## 2. Sistema de Archivos

- **FS:** Btrfs como root.
- **Mount Flags:** `compress=zstd:3,ssd,noatime,space_cache=v2`.
- **Limpieza:** Implementar un script de purga automática de logs cada 24h.

## 3. Control de Procesos

- **OOM Killer:** Configurar `earlyoom` para matar procesos que excedan el 95% de RAM antes de que el sistema se congele.
- **Prioridad:** Los procesos con tag `multimedia` deben tener un `nice` de -10.
