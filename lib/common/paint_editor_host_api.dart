import 'package:pigeon/pigeon.dart';

@HostApi()
abstract class PaintEditorHostApi {

  @async
  bool undo();

  @async
  bool redo();

  @async
  bool reset();

  @async
  bool import(String path, double? width, double? height);

  @async
  bool export(String path, String mimeType, String fileName);

  @async
  bool isEnable();

  @async
  bool setEnable(bool enable);

  @async
  bool setPaintMode(String paintMode);

  @async
  String getPaintMode();

  @async 
  String getStrokeColor();

  @async
  bool setStrokeColor(String color);

  @async 
  double getStrokeSize();

  @async
  bool setStrokeSize(double size);
}  