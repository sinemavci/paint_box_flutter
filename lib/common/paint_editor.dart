import 'package:paint_box_flutter/common/mime_type.dart';
import 'package:paint_box_flutter/common/paint_box_reference.dart';
import 'package:paint_box_flutter/common/paint_mode.dart';
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


  Future<bool> export(String path, MimeType mimeType, String fileName) async {
    if(channelSuffix == null) {
      throw Exception("PaintBoxView not found for this PaintEditor");
    }
    return await PaintEditorHostApi(messageChannelSuffix: channelSuffix!).export(path, mimeType.value, fileName);
  }

  Future<bool> isEnable() async {
    if(channelSuffix == null) {
      throw Exception("PaintBoxView not found for this PaintEditor");
    }
    return await PaintEditorHostApi(messageChannelSuffix: channelSuffix!).isEnable();
  }

  Future<void> setEnable(bool enable) async {
    if(channelSuffix == null) {
      throw Exception("PaintBoxView not found for this PaintEditor");
    }
    await PaintEditorHostApi(messageChannelSuffix: channelSuffix!).setEnable(enable);
  }

  Future<void> setPaintMode(PaintMode paintMode) async {
     if(channelSuffix == null) {
      throw Exception("PaintBoxView not found for this PaintEditor");
    }
    await PaintEditorHostApi(messageChannelSuffix: channelSuffix!).setPaintMode(paintMode.value);
  }

    Future<PaintMode> getPaintMode() async {
     if(channelSuffix == null) {
      throw Exception("PaintBoxView not found for this PaintEditor");
    }
    final response = await PaintEditorHostApi(messageChannelSuffix: channelSuffix!).getPaintMode();
    return PaintMode.fromValue(response);
    }
  
}