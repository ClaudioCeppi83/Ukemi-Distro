---
trigger: always_on
---

# Ukemi Distro: Local Engineering Rules

## 1. Prioridad de Contexto (Context-First)

- **Mandatario**: Antes de cualquier análisis o generación de código, DEBES leer y aplicar los estándares definidos en la carpeta `.context/`.
- **Arquitectura**: Sigue estrictamente `01_core_architecture.md` (Zen Kernel, OpenRC) y `00_engineering_specs.md`.
- **Estructura**: No improvises carpetas. Usa la jerarquía de `/build`, `/configs`, `/core`, `/iso`, `/scripts` y `/tests`.

## 2. Protocolo de Ingeniería (05_error_handling_and_logs.md)

- **Compilación**: Si sugieres comandos de compilación, usa las flags de `01_core_architecture.md` (`-O3 -march=native`).
- **Validación**: Antes de finalizar una tarea, verifica que pase `shellcheck` (Bash) y `pytest` (Python).
- **Límites**: Respeta `99_critical_limits.md`. No inicies procesos que consuman más RAM de la disponible ni modifiques el host (`99_negatives.md`).

## 3. Estilo Visual & Multimedia (A+C Style)

- **Interfaz**: Aplica los principios de `04_interface_and_gaming.md` (Sway/Wayland) manteniendo el estilo Orgánico-Minimalista (bordes redondeados en Waybar/Wofi).
- **Audio**: Configuración PipeWire fija a 48000Hz/128 quantum según `02_multimedia_stack.md`.

## 4. Gestión de Skills

- Prioriza el uso de skills locales en `.agent/skills/`.
- Si una tarea es recurrente y no hay skill, invoca a `skill-factory`.