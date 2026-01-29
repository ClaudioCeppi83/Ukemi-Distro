# Límites Críticos de Ejecución

- **Tiempo Máximo de Compilación:** Si un módulo tarda más de 4 horas, abortar y optimizar `-j` (jobs).
- **Espacio en Disco:** Si el espacio en `/build` baja de 20GB, limpiar caché inmediatamente.
- **Seguridad:** Prohibido descargar scripts de `curl | sh` de fuentes desconocidas. Solo usar `git clone` de repositorios verificados.
- **Prioridad Multimedia:** El agente debe verificar que el sistema final no tenga más de 40 procesos en ejecución al arrancar (Idle state).
