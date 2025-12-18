import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:paint_box_flutter/paint_box_flutter_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 final paintEditor = PaintEditor();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Stack(
  children: [
    Positioned.fill(
      child: PaintBoxView(), // Kotlin View
    ),
    Align(
      alignment: Alignment.topRight,
      child: ElevatedButton(onPressed: () async {
        await paintEditor.undo();
      }, child: Text("UNDO")),     // Flutter widget
    ),
    Align(
      alignment: Alignment.topCenter,
      child: ElevatedButton(onPressed: () async {
        await paintEditor.redo();
      }, child: Text("REDO")),     // Flutter widget
    ),
    Align(
      alignment: Alignment.topLeft,
      child: ElevatedButton(onPressed: () async {
        await paintEditor.reset();
      }, child: Text("RESET")),     // Flutter widget
    ),
    Align(
      alignment: Alignment.centerLeft,
      child: ElevatedButton(onPressed: () async {
        FilePickerResult? result = await FilePicker.platform.pickFiles();
        if (result != null) {
          File file = File(result.files.single.path!);
          final bytes = await file.readAsBytes();
          final base64Result = base64Encode(bytes);
          await paintEditor.import(base64Result);
          } else {
      }
      }, child: Text("IMPORT")),     // Flutter widget
    ),
  ],
)
      ),
    );
  }
}
