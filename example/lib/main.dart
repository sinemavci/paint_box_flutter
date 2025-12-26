import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:paint_box_flutter/common/mime_type.dart';
import 'package:paint_box_flutter/paint_box_flutter_plugin.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 final paintEditor1 = PaintEditor();
 final paintEditor2 = PaintEditor();
 File? file;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height - 16,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: PaintBoxView(paintEditor: paintEditor1), // Kotlin View
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: ElevatedButton(onPressed: () async {
              await paintEditor1.undo();
                    }, child: Text("UNDO")),     // Flutter widget
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: ElevatedButton(onPressed: () async {
              await paintEditor1.redo();
                    }, child: Text("REDO")),     // Flutter widget
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: ElevatedButton(onPressed: () async {
              await paintEditor1.reset();
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
                await paintEditor1.import(base64Result);
                } else {
                    }
                    }, child: Text("IMPORT")),     // Flutter widget
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(onPressed: () async {
                final isEnable = await paintEditor1.isEnable();
                await paintEditor1.setEnable(!isEnable);
               }, child: Text("ENABLE")),     // Flutter widget
                  ),
                   Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(onPressed: () async {
                      final path = await getDownloadsDirectory();
                      await paintEditor1.export(path!.path, MimeType.jpeg, "exported_imageeee");
               }, child: Text("EXPORT")),     // Flutter widget
                  ),
                ],
              ),
            ),
           Text("Second PaintBoxView"),
           if (file != null) ...[
             Image.file(file!),
           ]
          
            // SizedBox(
            //   height: 350,
            //   child: Stack(
            //     children: [
            //       Positioned.fill(
            //         child: PaintBoxView(paintEditor: paintEditor2), // Kotlin View
            //       ),
            //       Align(
            //         alignment: Alignment.topRight,
            //         child: ElevatedButton(onPressed: () async {
            //   await paintEditor2.undo();
            //         }, child: Text("UNDO")),     // Flutter widget
            //       ),
            //       Align(
            //         alignment: Alignment.topCenter,
            //         child: ElevatedButton(onPressed: () async {
            //   await paintEditor2.redo();
            //         }, child: Text("REDO")),     // Flutter widget
            //       ),
            //       Align(
            //         alignment: Alignment.topLeft,
            //         child: ElevatedButton(onPressed: () async {
            //   await paintEditor2.reset();
            //         }, child: Text("RESET")),     // Flutter widget
            //       ),
            //       Align(
            //         alignment: Alignment.centerLeft,
            //         child: ElevatedButton(onPressed: () async {
            //   FilePickerResult? result = await FilePicker.platform.pickFiles();
            //   if (result != null) {
            //     File file = File(result.files.single.path!);
            //     final bytes = await file.readAsBytes();
            //     final base64Result = base64Encode(bytes);
            //     await paintEditor2.import(base64Result);
            //     } else {
            //         }
            //         }, child: Text("IMPORT")),     // Flutter widget
            //       ),
            //       Align(
            //         alignment: Alignment.center,
            //         child: ElevatedButton(onPressed: () async {
            //     final isEnable = await paintEditor2.isEnable();
            //     await paintEditor2.setEnable(!isEnable);
            //    }, child: Text("ENABLE")),     // Flutter widget
            //       ),
            //     ],
            //   ),
            // ),
          
          ],
        )
      ),
    );
  }
}
