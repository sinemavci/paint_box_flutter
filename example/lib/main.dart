import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:paint_box_flutter/common/mime_type.dart';
import 'package:paint_box_flutter/common/paint_mode.dart';
import 'package:paint_box_flutter/paint_box_flutter_plugin.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

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
  int selectedTool = PaintMode.pen.index;
  Map<PaintMode, IconData> icons = {
    PaintMode.pen: Icons.edit,
    PaintMode.brush: MaterialCommunityIcons.brush,
    PaintMode.eraser: MaterialCommunityIcons.eraser,
    PaintMode.marker: MaterialCommunityIcons.format_paint,
    PaintMode.bucket: MaterialCommunityIcons.format_color_fill,
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Paint Box Flutter')),
        body: Stack(
          children: [
            Positioned.fill(
              child: PaintBoxView(paintEditor: paintEditor1), // Kotlin View
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.withAlpha(50),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () async {
                        await paintEditor1.reset();
                      },
                      icon: Icon(Icons.refresh),
                    ),
                    IconButton(
                      onPressed: () async {
                        await paintEditor1.undo();
                      },
                      icon: Icon(Icons.undo),
                    ),
                    IconButton(
                      onPressed: () async {
                        await paintEditor1.redo();
                      },
                      icon: Icon(Icons.redo),
                    ),
                    DropdownButton(
                      items: [
                        ...PaintMode.values.map(
                          (val) => DropdownMenuItem(
                            value: val.index,
                            onTap: () async {
                              await paintEditor1.setEnable(true);
                              await paintEditor1.setPaintMode(val);
                            },
                            child: Icon(icons[val]),
                          ),
                        ),
                        DropdownMenuItem(
                          value: PaintMode.values.length + 1,
                          onTap: () async {
                            await paintEditor1.setEnable(false);
                          },
                          child: Icon(Icons.edit_off),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedTool = value!;
                        });
                      },
                      value: selectedTool,
                    ),

                    IconButton(
                      onPressed: () async {
                        FilePickerResult? result = await FilePicker.platform
                            .pickFiles();
                        if (result != null) {
                          File file = File(result.files.single.path!);
                          final bytes = await file.readAsBytes();
                          final base64Result = base64Encode(bytes);
                          await paintEditor1.import(base64Result);
                        } else {}
                      },
                      icon: Icon(Icons.upload),
                    ),
                    IconButton(
                      onPressed: () async {
                        final path = await getDownloadsDirectory();
                        await paintEditor1.export(
                          path!.path,
                          MimeType.tif,
                          "exported_imageeee",
                        );
                      },
                      icon: Icon(Icons.save),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
