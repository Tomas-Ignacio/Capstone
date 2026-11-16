# Matriz de pruebas de certificación

**Proyecto:** Finanzas App
**Responsable:** Tomás Ignacio García Barria
**Alcance:** MVP Android con almacenamiento SQLite local.
**Criterio de aprobación:** el resultado observado debe coincidir con el resultado esperado y no debe perder datos existentes fuera del caso probado.

| ID | Caso | Precondición | Pasos resumidos | Resultado esperado | Evidencia / estado |
| --- | --- | --- | --- | --- | --- |
| TC-01 | Registrar gasto manual | Categoría de gasto disponible | Crear gasto con monto, fecha y categoría | Movimiento visible y saldo actualizado | Cubierto por ejecución manual. |
| TC-02 | Registrar ingreso manual | Categoría de ingreso disponible | Crear ingreso de sueldo | Movimiento visible e ingreso mensual actualizado | Cubierto por ejecución manual. |
| TC-03 | Gestionar categoría | App iniciada | Crear categoría, seleccionarla y verificarla | La categoría queda disponible; no se elimina si está en uso | Cubierto por prueba manual y reglas de datos. |
| TC-04 | Consultar detalle y editar categoría | Existe un movimiento | Abrir el movimiento y cambiar la categoría | El detalle muestra datos y persiste la nueva categoría | Cubierto por ejecución manual. |
| TC-05 | Crear presupuesto por categoría | Categoría de gasto disponible | Definir límite para un mes | El presupuesto queda asociado a categoría y mes | Cubierto por ejecución manual. |
| TC-06 | Visualizar gasto mensual | Existen movimientos de meses distintos | Abrir resumen/actividad | Se filtra y compara gasto por mes | Cubierto por ejecución manual. |
| TC-07 | Crear meta de ahorro | App iniciada | Definir nombre y monto objetivo | Se muestra avance, monto actual y faltante | Cubierto por ejecución manual. |
| TC-08 | Reiniciar datos de demostración | Existen movimientos, presupuestos y metas | Usar reinicio y confirmar | Se borran datos monetarios y se conservan categorías | Cubierto por revisión de implementación. |
| TC-09 | Capturar compra Banco Demo | Finanzas App abierta una vez; permiso de notificaciones concedido | Enviar “Compra en supermercado” desde Banco Demo | Se inserta gasto automático en categoría Comida | Validado manualmente en Android. |
| TC-10 | Capturar abono Banco Demo | Mismas condiciones de TC-09 | Enviar “Depósito de sueldo” | Se inserta ingreso automático en categoría Sueldo | Validado manualmente en Android. |
| TC-11 | Capturar transferencia de prueba | Mismas condiciones de TC-09 | Enviar transferencia recibida o enviada | Se registra ingreso o gasto con descripción de transferencia | Validado manualmente en Android. |
| TC-12 | Análisis estático | Dependencias instaladas | Ejecutar `dart analyze lib test` | No se reportan incidencias | Ejecutado el 16-11-2026: sin incidencias. |
| TC-13 | Pruebas automatizadas | Dependencias instaladas | Ejecutar `flutter test` | Suite exitosa | Ejecutado el 16-11-2026: 4 pruebas aprobadas. |

## Limitaciones de certificación

- TC-09 a TC-11 son pruebas de una integración de demostración con Banco Demo, no una certificación con entidades financieras reales.
- La autorización para leer notificaciones depende del ajuste de seguridad del dispositivo Android; debe verificarse antes de ejecutar estos casos.
- El proyecto no incluye backend, autenticación ni sincronización entre dispositivos, por lo que quedan fuera de este ciclo de pruebas.
