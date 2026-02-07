---
name: folder-architect
description: Arquitecto de software que define la estructura de carpetas y archivos para proyectos Next.js (Web) según la complejidad (Landing vs SaaS vs E-commerce).
---

# Web Folder Architect

Tu misión es garantizar que el proyecto sea escalable, ordenado y siga la metodología "Clean Architecture" adaptada a Next.js 15+ (App Router).

## 1. Análisis de Complejidad

Antes de crear carpetas, decide el tipo de arquitectura:

- **Tipo A: Landing / Portfolio (Minimalista)**
  - Foco en componentes visuales y pocas rutas.
  - Lógica de estado mínima.
- **Tipo B: SaaS / App / E-commerce (Robusta)**
  - Requiere separación estricta de lógica de negocio, UI y llamadas a base de datos.
  - Uso intensivo de Server Actions y Middlewares.

## 2. Estructuras Estándar (Src Directory)

### Estructura Base (Común a todos)

- `/src/app`: Únicamente para `page.tsx`, `layout.tsx`, `loading.tsx` y `route.ts` (API). No pongas componentes UI aquí.
- `/src/components/ui`: Componentes atómicos reutilizables (Botones, Inputs, Cards) sin lógica de negocio.
- `/src/lib`: Configuraciones globales (Firebase, Utils, Zod Schemas).

### Extensiones por Tipo

#### Si es Tipo A (Landing)

- `/src/components/sections`: Bloques grandes de página (Hero, Features, Pricing).
- `/src/styles`: Archivos CSS globales si Tailwind no es suficiente.

#### Si es Tipo B (SaaS/App)

- `/src/features`: Organización por dominio (Ej: `/features/auth`, `/features/billing`).
  - Dentro de cada feature: `components/`, `actions/` (Server Actions), `hooks/`.
- `/src/hooks`: Hooks personalizados globales (`use-scroll`, `use-window-size`).
- `/src/types`: Definiciones de TypeScript compartidas.
- `/src/actions`: Server Actions globales que no pertenecen a una feature específica.
- `/src/middleware.ts`: (En raíz de `src`) Para protección de rutas.

## 3. Reglas de Nombrado y Orden

- **Archivos**: Siempre `kebab-case` (ej: `user-profile-card.tsx`).
- **Componentes**: PascalCase dentro del archivo (ej: `export function UserProfileCard()`).
- **Barriles (Barrels)**: Usa archivos `index.ts` en carpetas de `ui` para exportaciones limpias.

## 4. Ubicación de Lógica (Separation of Concerns)

- **Lógica de Cliente**: Si usa `useState` o `useEffect`, el archivo debe llevar `'use client'` al inicio.
- **Lógica de Servidor**: Las llamadas a Firebase/DB deben ocurrir en archivos dentro de `/actions` o directamente en Server Components, nunca en componentes de cliente expuestos.
- **Constantes**: Crea `/src/lib/constants.ts` para textos fijos, menús de navegación o precios. No hardcodees en el componente.

## Instrucciones de Ejecución

1. Cuando se pida iniciar un proyecto, genera primero el árbol de directorios en texto.
2. Crea el archivo `ARCHITECTURE.md` explicando dónde debe vivir cada pieza del código.
3. Si el usuario pide crear un componente nuevo, pregúntate: "¿Es genérico (UI) o específico de negocio (Feature)?" y colócalo donde corresponda.
