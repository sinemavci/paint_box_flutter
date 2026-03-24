import 'dart:convert';
import 'dart:io';

import 'package:paint_box_flutter/common/model/color.dart' as paintboxcolor;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:paint_box_flutter/common/model/mime_type.dart';
import 'package:paint_box_flutter/common/model/paint_mode.dart';
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
  File? file1;
  File? file2;
  int selectedTool1 = PaintMode.pen.index;
  int selectedTool2 = PaintMode.pen.index;
  paintboxcolor.Color? selectedColor1;
  paintboxcolor.Color? selectedColor2;
  double strokeSize1 = 12.0;
  double strokeSize2 = 12.0;
  paintboxcolor.Color? strokeColor1;
  paintboxcolor.Color? strokeColor2;
  MimeType? selectedExportType1;
  MimeType? selectedExportType2;
  Map<PaintMode, IconData> icons = {
    PaintMode.pen: Icons.edit,
    PaintMode.brush: MaterialCommunityIcons.brush,
    PaintMode.eraser: MaterialCommunityIcons.eraser,
    PaintMode.marker: MaterialCommunityIcons.format_paint,
    PaintMode.bucket: MaterialCommunityIcons.format_color_fill,
  };

  final LayerLink _strokeSizeLink1 = LayerLink();
  final LayerLink _strokeSizeLink2 = LayerLink();
  final LayerLink _exportLink1 = LayerLink();
  final LayerLink _exportLink2 = LayerLink();

  OverlayEntry? _strokeSizeOverlayEntry1;
  OverlayEntry? _strokeSizeOverlayEntry2;
  OverlayEntry? _exportOverlayEntry1;
  OverlayEntry? _exportOverlayEntry2;

  @override
  void dispose() {
    _strokeSizeOverlayEntry1?.remove();
    _strokeSizeOverlayEntry2?.remove();
    _exportOverlayEntry1?.remove();
    _exportOverlayEntry2?.remove();
    super.dispose();
  }

  OverlayEntry _createStrokeSizeOverlay1() {
    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                _strokeSizeOverlayEntry1?.remove();
                _strokeSizeOverlayEntry1 = null;
              },
              behavior: HitTestBehavior.translucent,
              child: Container(),
            ),
          ),
          Positioned(
            width: 64,
            child: CompositedTransformFollower(
              link: _strokeSizeLink1,
              showWhenUnlinked: false,
              offset: const Offset(0, 48), // butonun hemen altı
              child: Material(
                elevation: 6,
                borderRadius: BorderRadius.circular(8),
                child: RotatedBox(
                  quarterTurns: -1,
                  child: Slider(
                    value: strokeSize1,
                    min: 1,
                    max: 40,
                    label: 'Stroke Size',
                    onChanged: (double value) async {
                      await paintEditor1.setStrokeSize(value);
                      setState(() {
                        strokeSize1 = value;
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

  OverlayEntry _createStrokeSizeOverlay2() {
    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                _strokeSizeOverlayEntry2?.remove();
                _strokeSizeOverlayEntry2 = null;
              },
              behavior: HitTestBehavior.translucent,
              child: Container(),
            ),
          ),
          Positioned(
            width: 64,
            child: CompositedTransformFollower(
              link: _strokeSizeLink2,
              showWhenUnlinked: false,
              offset: const Offset(0, 48), // butonun hemen altı
              child: Material(
                elevation: 6,
                borderRadius: BorderRadius.circular(8),
                child: RotatedBox(
                  quarterTurns: -1,
                  child: Slider(
                    value: strokeSize1,
                    min: 1,
                    max: 40,
                    label: 'Stroke Size',
                    onChanged: (double value) async {
                      await paintEditor2.setStrokeSize(value);
                      setState(() {
                        strokeSize2 = value;
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

  OverlayEntry _createExportOverlay1() {
    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                _exportOverlayEntry1?.remove();
                _exportOverlayEntry1 = null;
              },
              behavior: HitTestBehavior.translucent,
              child: Container(),
            ),
          ),
          Positioned(
            width: 64,
            child: CompositedTransformFollower(
              link: _exportLink1,
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
                              backgroundColor: selectedExportType1 == item
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
                                selectedExportType1 = item;
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

  OverlayEntry _createExportOverlay2() {
    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                _exportOverlayEntry2?.remove();
                _exportOverlayEntry2 = null;
              },
              behavior: HitTestBehavior.translucent,
              child: Container(),
            ),
          ),
          Positioned(
            width: 64,
            child: CompositedTransformFollower(
              link: _exportLink2,
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
                              backgroundColor: selectedExportType2 == item
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
                                selectedExportType2 = item;
                              });
                              try {
                                final path = await getDownloadsDirectory();
                                await paintEditor2.export(
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
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                children: [
                  Container(
                    height: 64,
                    margin: EdgeInsets.all(8),
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
                              selectedTool1 = value!;
                            });
                          },
                          value: selectedTool1,
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
                                      pickerColor: selectedColor1 != null
                                          ? Color.from(
                                              alpha: selectedColor1!.alpha!,
                                              green: selectedColor1!.green,
                                              blue: selectedColor1!.blue,
                                              red: selectedColor1!.red,
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
                                          () => selectedColor1 = finalColor,
                                        );
                                      },
                                    ),
                                  ),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      child: const Text('Apply'),
                                      onPressed: () async {
                                        if (selectedColor1 != null) {
                                          await paintEditor1.setStrokeColor(
                                            selectedColor1!,
                                          );
                                          setState(() {
                                            strokeColor1 = selectedColor1;
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
                            color: strokeColor1 != null
                                ? Color.from(
                                    alpha: strokeColor1!.alpha!,
                                    green: strokeColor1!.green,
                                    blue: strokeColor1!.blue,
                                    red: strokeColor1!.red,
                                  )
                                : Colors.black,
                          ),
                        ),
                        CompositedTransformTarget(
                          link: _strokeSizeLink1,
                          child: IconButton(
                            onPressed: () async {
                              if (_strokeSizeOverlayEntry1 == null) {
                                _strokeSizeOverlayEntry1 =
                                    _createStrokeSizeOverlay1();
                                Overlay.of(
                                  context,
                                ).insert(_strokeSizeOverlayEntry1!);
                              } else {
                                _strokeSizeOverlayEntry1!.remove();
                                _strokeSizeOverlayEntry1 = null;
                              }
                            },
                            icon: Icon(
                              Icons.line_weight,
                              color: strokeColor1 != null
                                  ? Color.from(
                                      alpha: strokeColor1!.alpha!,
                                      green: strokeColor1!.green,
                                      blue: strokeColor1!.blue,
                                      red: strokeColor1!.red,
                                    )
                                  : Colors.black,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            try {
                              FilePickerResult? result = await FilePicker
                                  .platform
                                  .pickFiles();
                              if (result != null) {
                                await paintEditor1.import(
                                  path: result.files.single.path!,
                                );
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
                          link: _exportLink1,
                          child: IconButton(
                            onPressed: () async {
                              if (_exportOverlayEntry1 == null) {
                                _exportOverlayEntry1 = _createExportOverlay1();
                                Overlay.of(
                                  context,
                                ).insert(_exportOverlayEntry1!);
                              } else {
                                _exportOverlayEntry1!.remove();
                                _exportOverlayEntry1 = null;
                              }
                            },
                            icon: Icon(Icons.save),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: PaintBoxView(
                            paintEditor: paintEditor1,
                            onPaintBoxViewReady: () async {
                              final _strokeColor = await paintEditor1
                                  .getStrokeColor();
                              final _strokeSize = await paintEditor1
                                  .getStrokeSize();
                              setState(() {
                                strokeSize1 = _strokeSize;
                                strokeColor1 = _strokeColor;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 64,
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.withAlpha(50),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () async {
                            await paintEditor2.reset();
                          },
                          icon: Icon(Icons.refresh),
                        ),
                        IconButton(
                          onPressed: () async {
                            await paintEditor2.undo();
                          },
                          icon: Icon(Icons.undo),
                        ),
                        IconButton(
                          onPressed: () async {
                            await paintEditor2.redo();
                          },
                          icon: Icon(Icons.redo),
                        ),
                        DropdownButton(
                          items: [
                            ...PaintMode.values.map(
                              (val) => DropdownMenuItem(
                                value: val.index,
                                onTap: () async {
                                  await paintEditor2.setEnable(true);
                                  await paintEditor2.setPaintMode(val);
                                },
                                child: Icon(icons[val]),
                              ),
                            ),
                            DropdownMenuItem(
                              value: PaintMode.values.length + 1,
                              onTap: () async {
                                await paintEditor2.setEnable(false);
                              },
                              child: Icon(Icons.edit_off),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              selectedTool2 = value!;
                            });
                          },
                          value: selectedTool2,
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
                                      pickerColor: selectedColor2 != null
                                          ? Color.from(
                                              alpha: selectedColor2!.alpha!,
                                              green: selectedColor2!.green,
                                              blue: selectedColor2!.blue,
                                              red: selectedColor2!.red,
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
                                          () => selectedColor2 = finalColor,
                                        );
                                      },
                                    ),
                                  ),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      child: const Text('Apply'),
                                      onPressed: () async {
                                        if (selectedColor2 != null) {
                                          await paintEditor2.setStrokeColor(
                                            selectedColor2!,
                                          );
                                          setState(() {
                                            strokeColor2 = selectedColor1;
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
                            color: strokeColor2 != null
                                ? Color.from(
                                    alpha: strokeColor2!.alpha!,
                                    green: strokeColor2!.green,
                                    blue: strokeColor2!.blue,
                                    red: strokeColor2!.red,
                                  )
                                : Colors.black,
                          ),
                        ),
                        CompositedTransformTarget(
                          link: _strokeSizeLink2,
                          child: IconButton(
                            onPressed: () async {
                              if (_strokeSizeOverlayEntry2 == null) {
                                _strokeSizeOverlayEntry2 =
                                    _createStrokeSizeOverlay2();
                                Overlay.of(
                                  context,
                                ).insert(_strokeSizeOverlayEntry2!);
                              } else {
                                _strokeSizeOverlayEntry2!.remove();
                                _strokeSizeOverlayEntry2 = null;
                              }
                            },
                            icon: Icon(
                              Icons.line_weight,
                              color: strokeColor2 != null
                                  ? Color.from(
                                      alpha: strokeColor2!.alpha!,
                                      green: strokeColor2!.green,
                                      blue: strokeColor2!.blue,
                                      red: strokeColor2!.red,
                                    )
                                  : Colors.black,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            try {
                              FilePickerResult? result = await FilePicker
                                  .platform
                                  .pickFiles();
                              if (result != null) {
                                await paintEditor2.import(
                                  path: result.files.single.path!,
                                );
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
                          link: _exportLink2,
                          child: IconButton(
                            onPressed: () async {
                              if (_exportOverlayEntry2 == null) {
                                _exportOverlayEntry2 = _createExportOverlay2();
                                Overlay.of(
                                  context,
                                ).insert(_exportOverlayEntry2!);
                              } else {
                                _exportOverlayEntry2!.remove();
                                _exportOverlayEntry2 = null;
                              }
                            },
                            icon: Icon(Icons.save),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: PaintBoxView(
                            paintEditor: paintEditor2,
                            onPaintBoxViewReady: () async {
                              final _strokeColor = await paintEditor2
                                  .getStrokeColor();
                              final _strokeSize = await paintEditor2
                                  .getStrokeSize();
                              setState(() {
                                strokeSize2 = _strokeSize;
                                strokeColor2 = _strokeColor;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
