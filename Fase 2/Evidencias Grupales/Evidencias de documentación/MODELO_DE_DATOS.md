# Modelo de datos

## Diagrama lógico

```text
categoria (1) ─────< transaccion
     │
     └─────────────< presupuesto

meta_ahorro (entidad independiente)
```

## Entidades implementadas

| Tabla | Campos principales | Propósito |
| --- | --- | --- |
| `categoria` | `id`, `nombre`, `tipo` | Clasifica ingresos o gastos. Incluye categorías iniciales y permite nuevas categorías. |
| `transaccion` | `id`, `categoria_id`, `monto`, `fecha`, `descripcion`, `tipo`, `origen`, `estado`, `institucion`, `hora` | Registra cada movimiento manual o automático. |
| `presupuesto` | `id`, `categoria_id`, `monto_limite`, `mes` | Define el límite mensual para una categoría. |
| `meta_ahorro` | `id`, `nombre`, `monto_objetivo`, `monto_actual`, `fecha_creacion` | Mantiene objetivos de ahorro y su avance. |

## Reglas de integridad aplicadas

- `categoria_id` es obligatorio en transacciones y presupuestos.
- `monto`, `fecha` y `tipo` son obligatorios en una transacción.
- No se elimina una categoría que esté en uso por movimientos o presupuestos.
- Para cada combinación de categoría y mes, guardar un presupuesto actualiza el existente en vez de duplicarlo.
- El reinicio de datos de demostración borra transacciones, presupuestos y metas, pero preserva categorías.

## Evolución del esquema

La base está versionada en `DatabaseHelper` con versión 3. La migración de versión 2 agrega `institucion` y `hora` a `transaccion`; la versión 3 crea `meta_ahorro` de manera segura con `IF NOT EXISTS`. Esto evita volver a crear la tabla cuando una instalación ya la posee.

## Consultas relevantes

- `getTransaccionesPorMes`: filtra movimientos por `yyyy-MM`.
- `getTotalPorTipo`: obtiene ingresos o gastos, de todos los datos o de un mes.
- `getGastosPorCategoria`: agrupa gastos por categoría y los ordena de mayor a menor.
- `insertOrUpdatePresupuesto`: mantiene un presupuesto único por categoría y mes.
