# Guía de Audio y Video: Multimedia Stack

## 1. Servidor de Sonido (PipeWire)
- **Implementación:** Sustituir ALSA/PulseAudio/JACK mediante `pipewire-pulse` y `pipewire-jack`.
- **Configuración Pro:** Forzar `default.clock.rate = 48000` y `default.clock.quantum = 128` para minimizar latencia en DAWs.
- **Librerías:** Instalar `gst-plugins-good`, `gst-plugins-bad`, `gst-plugins-ugly` para soporte universal de codecs.

## 2. Procesamiento de Video
- **Aceleración:** Implementar `libva` y `mesa-vdpau`.
- **Backends:** Priorizar Vulkan (`vulkan-icd-loader`) sobre OpenGL siempre que sea posible.
- **FFmpeg:** Compilar con soporte para `nvenc`, `vaapi` y `v4l2`.

## 3. Renderizado
- **Color:** Soporte para perfiles ICC vía `colord` para edición fotográfica (GIMP/Darktable).
