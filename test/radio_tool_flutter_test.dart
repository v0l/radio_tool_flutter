import 'package:flutter_test/flutter_test.dart';
import 'package:radio_tool_flutter/radio_tool_flutter.dart';
import 'package:radio_tool_flutter/radio_tool_flutter_platform_interface.dart';
import 'package:radio_tool_flutter/radio_tool_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockRadioToolFlutterPlatform
    with MockPlatformInterfaceMixin
    implements RadioToolFlutterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final RadioToolFlutterPlatform initialPlatform = RadioToolFlutterPlatform.instance;

  test('$MethodChannelRadioToolFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelRadioToolFlutter>());
  });

  test('getPlatformVersion', () async {
    RadioToolFlutter radioToolFlutterPlugin = RadioToolFlutter();
    MockRadioToolFlutterPlatform fakePlatform = MockRadioToolFlutterPlatform();
    RadioToolFlutterPlatform.instance = fakePlatform;

    expect(await radioToolFlutterPlugin.getPlatformVersion(), '42');
  });
}
