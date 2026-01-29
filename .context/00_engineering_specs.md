# Especificaciones de Ingeniería y Desarrollo

## 1. Stack Tecnológico de Construcción
| Herramienta | Uso |
| :--- | :--- |
| **Python 3.11+** | Orquestador principal y lógica de scripts complejos. |
| **Bash (ShellCheck)** | Scripts de automatización de bajo nivel y hooks de instalación. |
| **QEMU / KVM** | Entorno de pruebas para booting y validación de ISO. |
| **Git** | Control de versiones con ramas `dev` y `stable`. |
| **Pytest** | Framework para testear la lógica de los scripts de construcción. |

## 2. Estructura del Repositorio
El agente debe seguir estrictamente esta jerarquía:
- `/build`: Directorio temporal para compilación.
- `/configs`: Archivos de configuración (.config de Kernel, dotfiles de Sway).
- `/core`: Scripts de Python para la orquestación del sistema base (LFS).
- `/iso`: Herramientas para generar la imagen final (.iso).
- `/scripts`: Scripts de Bash para tareas rápidas y automatización de paquetes.
- `/tests`: Pruebas de integración y validación de hardware virtual.

## 3. Protocolo de Pruebas (Validation)
Antes de marcar un módulo como "Listo", el agente debe verificar:
1. **Linting:** Los scripts de Bash deben pasar `shellcheck`.
2. **Kernel Check:** Verificar que `.config` contiene las flags críticas (`PREEMPT_RT`, `HZ_1000`).
3. **Dry Run:** Simulación de instalación en un entorno `chroot`.
4. **Boot Test:** El sistema debe arrancar en QEMU con menos de 256MB de RAM asignada.

## 4. Convenciones de Código
- Documentar cada función en estilo Google (docstrings).
- Los scripts deben ser modulares (no archivos de 1000 líneas).
- Manejo estricto de errores: cada comando de compilación debe verificar su `exit code`.
