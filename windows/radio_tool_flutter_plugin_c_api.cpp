#include "include/radio_tool_flutter/radio_tool_flutter_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "radio_tool_flutter_plugin.h"

void RadioToolFlutterPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  radio_tool_flutter::RadioToolFlutterPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
