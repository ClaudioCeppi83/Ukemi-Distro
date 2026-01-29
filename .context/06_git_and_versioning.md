# Protocolo de Control de Versiones y Git

## 1. Estrategia de Ramas (Git Flow)

El desarrollo de Ukemi Distro sigue un flujo estricto para asegurar la estabilidad del núcleo y la ISO final.

* `main`: **Estable**. Solo contiene código que ha pasado todas las pruebas y genera una ISO funcional y booteable. **No se hace commit directo aquí**.
* `develop`: **Integración**. La rama base de desarrollo. Todo el código nuevo se integra aquí primero.
* `feature/<nombre>`: **Características Nuevas**. Ramas temporales para componentes específicos (ej. `feature/pipewire-config`, `feature/installer-gui`).
* `hotfix/<nombre>`: **Parches Urgentes**. Para arreglos críticos en `main` que no pueden esperar al ciclo normal.

## 2. Convenciones de Commits (Semantic Commits)

Es **obligatorio** usar el estándar de Conventional Commits para mantener un historial limpio y automatizar el changelog.

* `feat:` Una nueva característica (ej. `feat: add zstd compression to initramfs`).
* `fix:` Corrección de un bug (ej. `fix: resolve kernel panic on amdgpu`).
* `docs:` Cambios solo en documentación (ej. `docs: update install guide`).
* `style:` Cambios de formato (espacios, comas) sin lógica de código.
* `refactor:` Reescritura de código que no añade features ni corrige bugs.
* `perf:` Mejoras de rendimiento (ej. `perf: optimize boot script`).
* `test:` Añadir o corregir tests.
* `chore:` Tareas de mantenimiento (actualización de dependencias, scripts de build).

## 3. Versionado del Proyecto (Semver)

Ukemi Distro utiliza **Versionado Semántico (SemVer)** `MAJOR.MINOR.PATCH`:

* **MAJOR**: Cambios incompatibles en la arquitectura base (ej. cambio de glibc o estructura de directorios).
* **MINOR**: Nuevas funcionalidades o paquetes importantes (ej. actualización del Kernel, nuevo entorno de escritorio) compatible hacia atrás.
* **PATCH**: Correcciones de bugs y parches de seguridad.

### Versionado de la ISO

Las imágenes generadas seguirán el formato: `ukemi-v{VERSIÓN}-{ARQUITECTURA}.iso` (ej. `ukemi-v0.1.0-x86_64.iso`).

## 4. 🔒 Security & Safety

Ukemi development follows a **Strict Isolation Policy**:

* **Build Isolation**: All compilations occur inside a **Docker Sandbox**.
* **Privilege Control**: No `sudo` is allowed inside automated scripts.
* **Integrity**: Source integrity is verified via **SHA256 Manifests**.

## 5. Reglas de PR / Merge

1. Ningún PR se fusiona a `main` sin pasar el pipeline de validación (linting + boot test).
2. Todos los commits de un PR deben mantener la convención semántica (usar Squash Merge si es necesario).
