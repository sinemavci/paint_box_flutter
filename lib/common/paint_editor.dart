import 'package:paint_box_flutter/common/paint_box_reference.dart';
import 'package:paint_box_flutter/pigeon/paint_editor_host_api.g.dart';

class PaintEditor {
  String? get channelSuffix => PaintBoxReference.instance.findPaintBoxReference(this)?.paintBoxView.suffix;

  Future<void> undo() async {
    if(channelSuffix == null) {
      throw Exception("PaintBoxView not found for this PaintEditor");
    }
    await PaintEditorHostApi(messageChannelSuffix: channelSuffix!).undo();
  }

  Future<void> redo() async {
    if(channelSuffix == null) {
      throw Exception("PaintBoxView not found for this PaintEditor");
    }
    await PaintEditorHostApi(messageChannelSuffix: channelSuffix!).redo();
  }

  Future<void> reset() async {
    if(channelSuffix == null) {
      throw Exception("PaintBoxView not found for this PaintEditor");
    }
    await PaintEditorHostApi(messageChannelSuffix: channelSuffix!).reset();
  }

  Future<void> import(String bitmap) async {
    if(channelSuffix == null) {
      throw Exception("PaintBoxView not found for this PaintEditor");
    }
    await PaintEditorHostApi(messageChannelSuffix: channelSuffix!).import(bitmap);
  }
}