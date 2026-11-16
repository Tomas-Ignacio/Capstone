# Arquitectura y tecnologías

## Propósito

Finanzas App permite registrar ingresos y gastos, revisar indicadores mensuales, administrar categorías, presupuestos y metas de ahorro. Reduce el registro manual mediante una demostración controlada: Banco Demo emite notificaciones de prueba que la aplicación puede convertir en movimientos locales.

## Componentes

```text
Banco Demo (Flutter)
        │ notificación Android de prueba
        ▼
NotificationListenerService (Kotlin, Android)
        │ filtra, valida, deduplica e interpreta el mensaje
        ▼
SQLite: finanzas.db  ◄──── DatabaseHelper (Dart / sqflite)
        ▲                         ▲
        └──── pantallas Flutter ──┘
```

### Capa de presentación

Las pantallas Flutter se encuentran en `lib/screens`. Cubren inicio, actividad, detalle de movimiento, alta de movimientos, categorías y metas de ahorro. La navegación y el estado de cada pantalla se apoyan en las entidades de `lib/models`.

### Capa de datos

`lib/db/database_helper.dart` centraliza la apertura, migración y consultas de `finanzas.db`. Es la única capa que ejecuta SQL desde Dart, lo que evita que cada pantalla construya consultas propias.

### Integración Android

`TransactionNotificationListenerService.kt` es un servicio Android declarado con el permiso de sistema `BIND_NOTIFICATION_LISTENER_SERVICE`. Su responsabilidad es:

1. aceptar solamente el paquete `com.capstone.banco_demo`;
2. evitar duplicados mediante la clave de notificación;
3. reconocer gastos, abonos y transferencias de los formatos de prueba;
4. guardar una transacción con origen `automatico`, institución `Banco Demo` y estado `confirmado`;
5. notificar a la interfaz para que recargue los datos.

## Tecnologías

| Tecnología | Uso en el proyecto |
| --- | --- |
| Flutter / Dart | Interfaz móvil y lógica de aplicación |
| Material 3 | Componentes visuales y tema de la interfaz |
| SQLite | Base de datos local en el dispositivo |
| `sqflite` | Acceso desde Flutter a SQLite |
| Kotlin | Servicio Android de notificaciones |
| Android Studio / AVD | Construcción y pruebas en emulador |
| Git / GitHub | Control de versiones y entrega del repositorio |

## Decisiones y límites

- **Android como alcance de integración.** La API `NotificationListenerService` corresponde a Android; por ello la detección automática no se declara compatible con iOS.
- **Persistencia local.** El MVP no requiere un backend ni credenciales bancarias; la información queda en `finanzas.db` dentro del dispositivo.
- **Banco Demo como fuente controlada.** Se evita captar notificaciones reales. Esta decisión permite pruebas repetibles y no representa integración con BancoEstado ni otros bancos.
- **Recomendaciones explicables.** `financial_insights.dart` aplica reglas determinísticas para alertas de presupuesto, categoría predominante, ahorro y sobre-gasto. No usa un modelo de IA generativa o aprendizaje automático.
