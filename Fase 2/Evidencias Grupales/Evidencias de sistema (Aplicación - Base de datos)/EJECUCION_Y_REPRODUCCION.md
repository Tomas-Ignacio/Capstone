# Ejecución y reproducción de pruebas

## Finanzas App

```powershell
cd "Fase 1\Evidencias Grupales\finanzas_app"
flutter pub get
dart analyze lib test
flutter test
flutter run
```

## Banco Demo

En una segunda terminal:

```powershell
cd "Fase 1\Evidencias Grupales\banco_demo"
flutter pub get
flutter run
```

## Prueba de notificación automática

1. Ejecutar ambas aplicaciones en el mismo emulador o teléfono Android.
2. Abrir Finanzas App una vez para inicializar la base local y las categorías.
3. En Ajustes de Android, permitir a Finanzas App el acceso a notificaciones.
4. Abrir Banco Demo y permitirle mostrar notificaciones.
5. En Banco Demo, emitir una compra, abono o transferencia de prueba.
6. Revisar Actividad o Inicio en Finanzas App y confirmar el movimiento automático.

Si el movimiento no aparece, comprobar que el acceso de notificaciones esté activo y que la notificación provenga de Banco Demo. El servicio descarta, intencionalmente, notificaciones de cualquier otro paquete.
