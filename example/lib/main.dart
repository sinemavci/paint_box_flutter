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
  MimeType? selectedExportType;
  Map<PaintMode, IconData> icons = {
    PaintMode.pen: Icons.edit,
    PaintMode.brush: MaterialCommunityIcons.brush,
    PaintMode.eraser: MaterialCommunityIcons.eraser,
    PaintMode.marker: MaterialCommunityIcons.format_paint,
    PaintMode.bucket: MaterialCommunityIcons.format_color_fill,
  };

  final LayerLink _strokeSizeLink = LayerLink();
  final LayerLink _exportLink = LayerLink();

  OverlayEntry? _strokeSizeOverlayEntry;
  OverlayEntry? _exportOverlayEntry;

  @override
  void dispose() {
    _strokeSizeOverlayEntry?.remove();
    _exportOverlayEntry?.remove();
    super.dispose();
  }

  OverlayEntry _createStrokeSizeOverlay() {
    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                _strokeSizeOverlayEntry?.remove();
                _strokeSizeOverlayEntry = null;
              },
              behavior: HitTestBehavior.translucent,
              child: Container(),
            ),
          ),
          Positioned(
            width: 64,
            child: CompositedTransformFollower(
              link: _strokeSizeLink,
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

  OverlayEntry _createExportOverlay() {
    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                _exportOverlayEntry?.remove();
                _exportOverlayEntry = null;
              },
              behavior: HitTestBehavior.translucent,
              child: Container(),
            ),
          ),
          Positioned(
            width: 64,
            child: CompositedTransformFollower(
              link: _exportLink,
              showWhenUnlinked: false,
              offset: const Offset(0, 48),
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                child: Column(
                  children: [
                    ...MimeType.values.map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: SizedBox(
                          height: 32,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              backgroundColor: selectedExportType == item
                                  ? Colors.blueGrey.shade400
                                  : Colors.blueGrey.shade100,
                            ),

                            child: Text(
                              item.value,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () async {
                              setState(() {
                                selectedExportType = item;
                              });
                              try {
                                final path = await getDownloadsDirectory();
                                await paintEditor1.export(
                                  path!.path,
                                  item,
                                  "exported_imageeee",
                                );
                                final snackBar = SnackBar(
                                  content: Text("Exported to $path"),
                                );
                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(snackBar);
                              } catch (_) {
                                final snackBar = SnackBar(
                                  content: Text("Export failed"),
                                );
                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(snackBar);
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
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
                          link: _strokeSizeLink,
                          child: IconButton(
                            onPressed: () async {
                              if (_strokeSizeOverlayEntry == null) {
                                _strokeSizeOverlayEntry =
                                    _createStrokeSizeOverlay();
                                Overlay.of(
                                  context,
                                ).insert(_strokeSizeOverlayEntry!);
                              } else {
                                _strokeSizeOverlayEntry!.remove();
                                _strokeSizeOverlayEntry = null;
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
                            try {
                              FilePickerResult? result = await FilePicker
                                  .platform
                                  .pickFiles();
                              if (result != null) {
                                File file = File(result.files.single.path!);
                                final bytes = await file.readAsBytes();
                                final base64Result = base64Encode(bytes);
                                await paintEditor1.import(base64Result);
                              } else {
                                final snackBar = SnackBar(
                                  content: Text("File can not selected"),
                                );
                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(snackBar);
                              }
                            } catch (e) {
                              final snackBar = SnackBar(
                                content: Text("Import failed"),
                              );
                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(snackBar);
                            }
                          },
                          icon: Icon(Icons.upload),
                        ),
                        CompositedTransformTarget(
                          link: _exportLink,
                          child: IconButton(
                            onPressed: () async {
                              if (_exportOverlayEntry == null) {
                                _exportOverlayEntry = _createExportOverlay();
                                Overlay.of(
                                  context,
                                ).insert(_exportOverlayEntry!);
                              } else {
                                _exportOverlayEntry!.remove();
                                _exportOverlayEntry = null;
                              }
                            },
                            icon: Icon(Icons.save),
                          ),
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
