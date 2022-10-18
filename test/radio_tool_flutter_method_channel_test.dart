import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:radio_tool_flutter/radio_tool_flutter_method_channel.dart';

void main() {
  MethodChannelRadioToolFlutter platform = MethodChannelRadioToolFlutter();
  const MethodChannel channel = MethodChannel('radio_tool_flutter');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
