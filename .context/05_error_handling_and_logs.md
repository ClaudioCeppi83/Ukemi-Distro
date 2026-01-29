# Protocolo de Errores y Recuperación

    ## 1. Manejo de Fallos de Compilación
        - Si la compilación del Kernel falla, el agente debe extraer las últimas 50 líneas del log de error.
        - Debe buscar la palabra clave 'Error' o 'Fatal' y comparar con la documentación en `.context/`.

    ## 2. Puntos de Control (Checkpoints)
        - Tras cada fase exitosa (ej. Toolchain lista), el agente debe crear un snapshot o backup del directorio de trabajo.
        - Si la fase siguiente falla, el agente debe tener la capacidad de revertir al último checkpoint estable.

    ## 3. Telemetría de Recursos
        - El agente debe monitorear el uso de CPU y RAM. Si el sistema anfitrión llega al 90% de carga, el agente debe pausar la compilación (usar `SIGSTOP`) por 5 minutos para evitar un kernel panic del host.
