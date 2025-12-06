import 'package:flutter_test/flutter_test.dart';
import 'package:paint_box_flutter/paint_box_flutter.dart';
import 'package:paint_box_flutter/paint_box_flutter_platform_interface.dart';
import 'package:paint_box_flutter/paint_box_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPaintBoxFlutterPlatform
    with MockPlatformInterfaceMixin
    implements PaintBoxFlutterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final PaintBoxFlutterPlatform initialPlatform = PaintBoxFlutterPlatform.instance;

  test('$MethodChannelPaintBoxFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelPaintBoxFlutter>());
  });

  test('getPlatformVersion', () async {
    PaintBoxFlutter paintBoxFlutterPlugin = PaintBoxFlutter();
    MockPaintBoxFlutterPlatform fakePlatform = MockPaintBoxFlutterPlatform();
    PaintBoxFlutterPlatform.instance = fakePlatform;

    expect(await paintBoxFlutterPlugin.getPlatformVersion(), '42');
  });
}
