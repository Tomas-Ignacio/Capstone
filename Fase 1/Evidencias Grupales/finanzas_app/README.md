# Finanzas App

Aplicación móvil Android para registrar y revisar ingresos, gastos, presupuestos por categoría y metas de ahorro. Incluye una integración de prueba que incorpora movimientos desde notificaciones emitidas exclusivamente por **Banco Demo**.

> Estado académico: MVP desarrollado para CAPSTONE. No es un producto bancario ni procesa notificaciones de bancos reales.

## Funcionalidades implementadas

- Registro manual de ingresos y gastos.
- Categorías editables y detalle de cada movimiento.
- Presupuestos mensuales por categoría.
- Metas de ahorro con avance acumulado.
- Resumen mensual, gasto por categoría y comparación con el mes anterior.
- Recomendaciones financieras determinísticas basadas en reglas locales.
- Detección automática de notificaciones emitidas por la aplicación Banco Demo.
- Reinicio de datos de demostración sin eliminar categorías.

## Arquitectura y tecnologías

| Capa | Implementación |
| --- | --- |
| Interfaz | Flutter y Dart con Material 3 |
| Persistencia | SQLite local mediante `sqflite` |
| Integración Android | Kotlin, `NotificationListenerService` y `MethodChannel` |
| Pruebas | `flutter_test` y pruebas manuales guiadas |

La interfaz Flutter consulta `DatabaseHelper`, que concentra las operaciones CRUD. En Android, `TransactionNotificationListenerService` filtra el paquete `com.capstone.banco_demo`, interpreta formatos de prueba y guarda una transacción confirmada en la base local.

## Requisitos

- Flutter SDK compatible con el proyecto.
- Android Studio y un emulador Android o teléfono físico con depuración USB.
- Para probar la captura automática: instalar también `banco_demo` y conceder acceso de lectura de notificaciones a Finanzas App.

## Ejecución

Desde esta carpeta:

```powershell
flutter pub get
flutter run
```

Para ejecutar las comprobaciones:

```powershell
dart analyze lib test
flutter test
```

## Prueba de captura automática

1. Instala y abre Banco Demo en el mismo dispositivo Android.
2. Concede a Finanzas App el acceso a las notificaciones desde Ajustes de Android.
3. Abre Finanzas App al menos una vez para crear su base local y categorías iniciales.
4. En Banco Demo, toca una transacción de prueba, por ejemplo **Compra en supermercado**.
5. Vuelve a Finanzas App y verifica que exista un movimiento de origen automático.

La integración soporta solamente notificaciones del paquete Banco Demo y los formatos controlados del proyecto. No deben presentarse pruebas con BancoEstado, Tenpo, Copec Pay, Mercado Pago ni otra institución real como si estuvieran implementadas.

## Privacidad y límites

- Los datos se almacenan localmente en el dispositivo, en `finanzas.db`.
- La aplicación no autentica usuarios, no transmite datos a un servidor y no se conecta a APIs bancarias.
- Las recomendaciones no usan inteligencia artificial generativa ni modelos de aprendizaje automático; son reglas transparentes sobre los datos locales.
- La funcionalidad de notificaciones es exclusiva para demostración Android.

## Estructura relevante

```text
lib/
  db/database_helper.dart                 # Esquema y operaciones SQLite
  models/                                 # Entidades del dominio
  screens/                                # Vistas Flutter
  services/financial_insights.dart        # Reglas de recomendaciones
android/.../TransactionNotificationListenerService.kt
                                             # Captura Android de Banco Demo
```

La evidencia de arquitectura, modelo de datos, pruebas y trazabilidad académica se encuentra en `Fase 2/Evidencias Grupales` y `Fase 3/Evidencias Grupales` del repositorio.
