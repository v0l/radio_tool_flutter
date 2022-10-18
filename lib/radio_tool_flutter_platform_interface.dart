import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'radio_tool_flutter_method_channel.dart';

abstract class RadioToolFlutterPlatform extends PlatformInterface {
  /// Constructs a RadioToolFlutterPlatform.
  RadioToolFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static RadioToolFlutterPlatform _instance = MethodChannelRadioToolFlutter();

  /// The default instance of [RadioToolFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelRadioToolFlutter].
  static RadioToolFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [RadioToolFlutterPlatform] when
  /// they register themselves.
  static set instance(RadioToolFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<List<String>?> listRadios() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
