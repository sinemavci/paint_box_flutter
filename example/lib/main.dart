import 'dart:convert';
import 'dart:io';

import 'package:paint_box_flutter/common/color.dart' as paintboxcolor;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:paint_box_flutter/common/mime_type.dart';
import 'package:paint_box_flutter/common/paint_mode.dart';
import 'package:paint_box_flutter/paint_box_flutter_plugin.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

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
  paintboxcolor.Color? selectedColor;
  double strokeSize = 12.0;
  paintboxcolor.Color? strokeColor;
  Map<PaintMode, IconData> icons = {
    PaintMode.pen: Icons.edit,
    PaintMode.brush: MaterialCommunityIcons.brush,
    PaintMode.eraser: MaterialCommunityIcons.eraser,
    PaintMode.marker: MaterialCommunityIcons.format_paint,
    PaintMode.bucket: MaterialCommunityIcons.format_color_fill,
  };
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }

  OverlayEntry _createOverlay() {
    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                _overlayEntry?.remove();
                _overlayEntry = null;
              },
              behavior: HitTestBehavior.translucent,
              child: Container(),
            ),
          ),
          Positioned(
            width: 64,
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: const Offset(0, 48), // butonun hemen altı
              child: Material(
                elevation: 6,
                borderRadius: BorderRadius.circular(8),
                child: RotatedBox(
                  quarterTurns: -1,
                  child: Slider(
                    value: strokeSize,
                    min: 1,
                    max: 40,
                    label: 'Stroke Size',
                    onChanged: (double value) async {
                      await paintEditor1.setStrokeSize(value);
                      setState(() {
                        strokeSize = value;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(title: const Text('Paint Box Flutter')),
            body: Stack(
              children: [
                Positioned.fill(
                  child: PaintBoxView(
                    paintEditor: paintEditor1,
                    onPaintBoxViewReady: () async {
                      final _strokeColor = await paintEditor1.getStrokeColor();
                      final _strokeSize = await paintEditor1.getStrokeSize();
                      setState(() {
                        strokeSize = _strokeSize;
                        strokeColor = _strokeColor;
                      });
                    },
                  ),
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
                            showDialog<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Pick a color!'),
                                  content: SingleChildScrollView(
                                    child: ColorPicker(
                                      pickerColor: selectedColor != null
                                          ? Color.from(
                                              alpha: selectedColor!.alpha!,
                                              green: selectedColor!.green,
                                              blue: selectedColor!.blue,
                                              red: selectedColor!.red,
                                            )
                                          : Colors.black,
                                      onColorChanged: (color) {
                                        final finalColor = paintboxcolor.Color(
                                          red: color.r,
                                          green: color.g,
                                          blue: color.b,
                                          alpha: color.a,
                                        );
                                        print(
                                          'color changed: ${color.r} ${color.g} ${color.b} --- ${finalColor.red} ${finalColor.green} ${finalColor.blue}',
                                        );
                                        setState(
                                          () => selectedColor = finalColor,
                                        );
                                      },
                                    ),
                                  ),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      child: const Text('Apply'),
                                      onPressed: () async {
                                        if (selectedColor != null) {
                                          await paintEditor1.setStrokeColor(
                                            selectedColor!,
                                          );
                                          print(
                                            "color final: ${selectedColor?.red} ${selectedColor?.green} ${selectedColor?.blue}",
                                          );
                                          setState(() {
                                            strokeColor = selectedColor;
                                          });
                                          if (mounted) {
                                            Navigator.of(context).pop();
                                          }
                                        }
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: Icon(
                            Icons.circle,
                            color: strokeColor != null
                                ? Color.from(
                                    alpha: strokeColor!.alpha!,
                                    green: strokeColor!.green,
                                    blue: strokeColor!.blue,
                                    red: strokeColor!.red,
                                  )
                                : Colors.black,
                          ),
                        ),
                        CompositedTransformTarget(
                          link: _layerLink,
                          child: IconButton(
                            onPressed: () async {
                              if (_overlayEntry == null) {
                                _overlayEntry = _createOverlay();
                                Overlay.of(context).insert(_overlayEntry!);
                              } else {
                                _overlayEntry!.remove();
                                _overlayEntry = null;
                              }
                            },
                            icon: Icon(
                              Icons.line_weight,
                              color: strokeColor != null
                                  ? Color.from(
                                      alpha: strokeColor!.alpha!,
                                      green: strokeColor!.green,
                                      blue: strokeColor!.blue,
                                      red: strokeColor!.red,
                                    )
                                  : Colors.black,
                            ), //todo: retrieve stroke color
                          ),
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
          );
        },
      ),
    );
  }
}
