
import 'radio_tool_flutter_platform_interface.dart';

class RadioToolFlutter {
  Future<String?> getPlatformVersion() {
    return RadioToolFlutterPlatform.instance.getPlatformVersion();
  }
  Future<List<String>?> listRadios() {
    return RadioToolFlutterPlatform.instance.listRadios();
  }
}
