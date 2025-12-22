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
  bool import(String bitmap);

  @async
  bool isEnable();

  @async
  bool setEnable(bool enable);
}  