---
name: media-engine-setup
description: Experto en inyectar la configuración de baja latencia en PipeWire y compilar FFmpeg con soporte nvenc/vaapi.
---

# Multimedia Engine Setup

Esta skill implementa el stack multimedia de alto rendimiento definido en `02_multimedia_stack.md`. Responsable de transformar Ukemi en una workstation creativa.

## 1. Audio Stack (PipeWire Pro)

- **Servidor**: Instalar `pipewire`, `pipewire-pulse`, y `pipewire-jack`.
- **Configuración Crítica**:
  - Editar `pipewire.conf` o `jack.conf` para establecer:
    - `default.clock.rate = 48000`
    - `default.clock.quantum = 128`
  - Esto es obligatorio para minimizar la latencia en aplicaciones DAW.

## 2. Video Stack (FFmpeg & Codecs)

- **Compilación de FFmpeg**:
  - Habilitar soporte de hardware: `--enable-nvenc` (NVIDIA), `--enable-vaapi` (Intel/AMD), `--enable-v4l2`.
  - Habilitar librerías GPL: `--enable-gpl --enable-nonfree`.
- **Librerías Codec**:
  - Instalar GStreamer plugins: `good`, `bad`, `ugly`.
  - Asegurar presencia de `libva` y `mesa-vdpau`.

## 3. Gráficos & Renderizado

- **Backend**: Forzar el uso de Vulkan (`vulkan-icd-loader`) donde sea posible frente a OpenGL.
- **Color**: Configurar `colord` para gestión de perfiles ICC en el sistema (crítico para GIMP/Darktable).
