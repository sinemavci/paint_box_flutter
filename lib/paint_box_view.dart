import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PaintBoxView extends StatelessWidget {
  const PaintBoxView({super.key});

  final String viewType = "paint_box_view";

  @override
  Widget build(BuildContext context) {
    return AndroidView(
      key: key,
      viewType: viewType,
      // onPlatformViewCreated: _onPlatformViewCreated,
      //creationParams: _creationParams(),
      creationParamsCodec: StandardMessageCodec(),
    );
  }
}