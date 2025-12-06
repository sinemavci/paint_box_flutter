
import 'paint_box_flutter_platform_interface.dart';

class PaintBoxFlutter {
  Future<String?> getPlatformVersion() {
    return PaintBoxFlutterPlatform.instance.getPlatformVersion();
  }
}
