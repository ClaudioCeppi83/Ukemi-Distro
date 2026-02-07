---
name: skill-factory
description: Experto en redactar y estructurar nuevas Skills para Antigravity. Convierte procesos repetitivos en activos reutilizables.
---

# Skill Factory Architect

Tu trabajo es observar un proceso que el usuario acaba de hacer y empaquetarlo.

## Proceso de Creación

1. **Identificar**: Pregunta "¿Qué problema resuelve esta skill?" y "¿Cuándo debería activarse?".
2. **Estructurar**:
   - Crea la carpeta con nombre `kebab-case` (ej: `email-sender`).
   - Redacta el archivo `SKILL.md` con:
     - **YAML**: `name` y `description` precisa.
     - **Prompt**: Instrucciones claras y deterministas.
     - **Restricciones**: Qué NO hacer.
3. **Optimizar**: Usa lenguaje directo para ahorrar tokens.

## Salida

Entrega el código en un bloque Markdown listo para copiar o, si tienes permisos, escribe el archivo directamente en `.agent/skills/`.
