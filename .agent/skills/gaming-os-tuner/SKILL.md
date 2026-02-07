---
name: gaming-os-tuner
description: Basado en 04_interface_and_gaming.md. Configura Sway/Wayland, GameMode y optimizaciones de gaming.
---

# Gaming & Interface Tuner

Esta skill configura la interfaz de usuario y las optimizaciones específicas para juegos según `04_interface_and_gaming.md`.

## 1. Entorno de Escritorio (Sway/Wayland)

- **Protocolo**: Enforzar Wayland nativo. Prohibir sesiones X11 puras (XWayland permitido solo para legado).
- **Input**: Configurar `libinput` con perfil "flat" (aceleración desactivada) para precisión en diseño y gaming.
- **Componentes**:
  - `waybar`: Barra de estado minimalista.
  - `wofi`: Lanzador de aplicaciones ligero.

## 2. Gaming Optimization Stack

- **GameMode**: Instalar y configurar `Feral GameMode`.
  - Asegurar que active el gobernador de CPU "performance" al iniciar juegos.
- **Monitoring**: Integrar `MangoHud` globalmente (configurar shortcut o variable de entorno por defecto).
- **Compatibilidad**: Instalar `Proton-GE` (GloriousEggroll) como runner por defecto para Steam/Lutris.

## 3. Reproducción de Video

- **Player**: Configurar `mpv` como reproductor por defecto.
- **Config**:
  - `vo=gpu`
  - `hwdec=auto-safe`
