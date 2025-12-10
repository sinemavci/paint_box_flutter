import 'package:pigeon/pigeon.dart';

@HostApi()
abstract class PaintEditorHostApi {

  @async
  bool undo();
}  