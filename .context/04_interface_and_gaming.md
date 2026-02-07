# Guía de Interfaz: Wayland y Gaming

## 1. Compositor (Sway)

- **Protocolo:** Wayland nativo (prohibir X11 excepto vía XWayland para apps legadas).
- **Input:** `libinput` con aceleración de puntero plana para diseño.
- **Estética:** Usar `waybar` para la barra de tareas y `wofi` como lanzador (mínimo consumo).

## 2. Gaming & Graphics

- **Tools:** Integrar `MangoHud` para monitoreo de recursos en tiempo real.
- **Game Optimization:** Implementar `Feral GameMode` para ajustar automáticamente el escalado de CPU al jugar.
- **Wine/Proton:** Usar `Proton-GE` para máxima compatibilidad con títulos de Windows.

## 3. Visualización de Video

- **MPV:** Configurar como reproductor por defecto con `vo=gpu` y `hwdec=auto-safe`.
