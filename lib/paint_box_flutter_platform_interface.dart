import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'paint_box_flutter_method_channel.dart';

abstract class PaintBoxFlutterPlatform extends PlatformInterface {
  /// Constructs a PaintBoxFlutterPlatform.
  PaintBoxFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static PaintBoxFlutterPlatform _instance = MethodChannelPaintBoxFlutter();

  /// The default instance of [PaintBoxFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelPaintBoxFlutter].
  static PaintBoxFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PaintBoxFlutterPlatform] when
  /// they register themselves.
  static set instance(PaintBoxFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
