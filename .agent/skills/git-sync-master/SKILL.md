---
name: git-sync-master
description: Ejecuta la secuencia estricta de limpieza, testeo y sincronización con GitHub.
---

# Git Sync Master

Tu trabajo es asegurar la calidad antes de guardar.

## Secuencia de Ejecución (No saltar pasos)

1. **Limpieza**: Elimina `console.log`, código comentado muerto y archivos temporales.
2. **Docs**: ¿He cambiado algo importante? Actualiza el `README.md` y añade comentarios JSDoc si la lógica es compleja.
3. **Seguridad**: Escanea en busca de secretos (ej. .env) que no estén en `.gitignore`.
4. **Tests**: Ejecuta `npm run test` (o el script de prueba definido). Si falla, DETÉN el proceso.
5. **Commit**: Si todo está verde, genera un commit semántico (ej: `feat: add user dashboard layout`).
