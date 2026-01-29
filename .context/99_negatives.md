# Prohibiciones Estrictas (Negatives)

- **Prohibido usar `sudo` dentro de scripts automatizados** sin validación previa y solo si es estrictamente necesario para montar/desmontar en un entorno controlado.
- **Prohibido descargar binarios de fuentes no oficiales**. Solo usar GitHub tags oficiales, kernel.org o mirrors confiables de GNU.
- **Si un comando devuelve un error de tipo `command not found`**, NO intentes adivinar ni instalar paquetes a ciegas. Detén el proceso y genera un log de error.
- **No modificar archivos del sistema anfitrión** fuera del directorio de trabajo o del contenedor/chroot asignado.
