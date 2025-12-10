# paint_box_flutter

A new Flutter plugin project.

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/to/develop-plugins),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

dart run pigeon \
--input lib/common/paint_editor_host_api.dart \
--dart_out lib/pigeon/paint_editor_host_api.g.dart \
--kotlin_out android/src/main/kotlin/com/example/paint_box_flutter/pigeons/PaintEditorModulePigeon.kt \
--kotlin_package "com.example.paint_box_flutter.PaintEditorModulePigeon"