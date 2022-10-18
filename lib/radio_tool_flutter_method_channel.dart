import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'radio_tool_flutter_platform_interface.dart';

/// An implementation of [RadioToolFlutterPlatform] that uses method channels.
class MethodChannelRadioToolFlutter extends RadioToolFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('radio_tool_flutter');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<List<String>?> listRadios() async {
    final radios = await methodChannel.invokeListMethod<String>('listRadios');
    return radios;
  }
}
