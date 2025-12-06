import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LineFluxView extends StatelessWidget {
  const LineFluxView({super.key});

  final String viewType = "paint_box_view";

  @override
  Widget build(BuildContext context) {
    print("android view build");
    return AndroidView(
      key: key,
      viewType: viewType,
      // onPlatformViewCreated: _onPlatformViewCreated,
      //creationParams: _creationParams(),
      creationParamsCodec: StandardMessageCodec(),
    );
  }
}