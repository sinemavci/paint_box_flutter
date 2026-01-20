import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paint_box_flutter/common/paint_box_reference.dart';
import 'package:paint_box_flutter/common/paint_editor.dart';
import 'package:uuid/uuid.dart';

class PaintBoxView extends StatefulWidget {
  final PaintEditor paintEditor;
  final void Function()? onPaintBoxViewReady;

  const PaintBoxView({
    super.key,
    required this.paintEditor,
    this.onPaintBoxViewReady,
  });

  @override
  State<PaintBoxView> createState() => PaintBoxViewState();
}

class PaintBoxViewState extends State<PaintBoxView> {
  final String suffix = Uuid().v4();

  final String viewType = "paint_box_view";

  final reference = PaintBoxReference.instance;

  void _onPlatformViewCreated(int id) {
    reference.addPaintBoxReference(this, widget.paintEditor);
    widget.onPaintBoxViewReady?.call();
  }

  @override
  dispose() {
    reference.removePaintBoxReference(this);
    super.dispose();
  }

  Map<String, String> _creationParams() {
    return {"channelSuffix": suffix};
  }

  @override
  Widget build(BuildContext context) {
    return AndroidView(
      key: widget.key,
      viewType: viewType,
      onPlatformViewCreated: _onPlatformViewCreated,
      creationParams: _creationParams(),
      creationParamsCodec: StandardMessageCodec(),
    );
  }
}
