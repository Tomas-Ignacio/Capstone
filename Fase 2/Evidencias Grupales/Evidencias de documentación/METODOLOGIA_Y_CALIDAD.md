# Metodología y calidad

## Metodología aplicada

Se utilizó un enfoque ágil individual con tablero Kanban. El tablero permite mantener visibles las tareas en **Pendiente**, **En curso**, **En revisión/prueba** y **Completado**, priorizando una funcionalidad utilizable por cada ciclo corto.

Trabajar individualmente no impide aplicar Kanban: cambia la coordinación entre personas por una gestión personal del flujo, límites de trabajo en curso y evidencia de avance. El tablero del proyecto se encuentra en `Fase 2/Evidencias Grupales/TABLERO_KANBAN_FASE2.md`.

## Ciclos de avance relevantes

1. **MVP de registro:** categorías, transacciones y base SQLite.
2. **Automatización de prueba:** Banco Demo y servicio de notificaciones Android.
3. **Control financiero:** presupuestos por categoría, metas de ahorro, movimientos por mes y recomendaciones basadas en reglas.
4. **Mejora de interfaz y validación:** dashboard, tipografía, gráficos/resúmenes y pruebas de regresión.

## Prácticas de calidad

- Análisis estático con `dart analyze lib test`.
- Pruebas automatizadas con `flutter test`.
- Casos manuales repetibles documentados en la matriz de pruebas.
- Validación manual en emulador Android y dispositivo físico para permisos y notificaciones.
- Versionamiento mediante Git y entrega centralizada en GitHub.

## Resultados verificables al 16 de noviembre de 2026

| Comprobación | Resultado |
| --- | --- |
| `dart analyze lib test` | Sin incidencias reportadas. |
| `flutter test` | 4 pruebas aprobadas. |
| Persistencia SQLite | Validada mediante las operaciones CRUD y migraciones del proyecto. |
| Notificaciones Banco Demo | Probadas en Android con acceso de notificaciones habilitado. |

Las pruebas manuales no sustituyen una certificación bancaria. La matriz de sistema identifica explícitamente qué casos requieren ejecución en Android.
