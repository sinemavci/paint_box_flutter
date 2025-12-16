import 'package:paint_box_flutter/pigeon/paint_editor_host_api.g.dart';

class PaintEditor {
  final _hostApi = PaintEditorHostApi();

  Future<void> undo() async {
    await _hostApi.undo();
  }

  Future<void> redo() async {
    await _hostApi.redo();
  }
}