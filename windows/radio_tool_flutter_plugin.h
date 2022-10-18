#ifndef FLUTTER_PLUGIN_RADIO_TOOL_FLUTTER_PLUGIN_H_
#define FLUTTER_PLUGIN_RADIO_TOOL_FLUTTER_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace radio_tool_flutter {

	class RadioToolFlutterPlugin : public flutter::Plugin {
	public:
		static void RegisterWithRegistrar(flutter::PluginRegistrarWindows* registrar);

		RadioToolFlutterPlugin();

		virtual ~RadioToolFlutterPlugin();

		// Disallow copy and assign.
		RadioToolFlutterPlugin(const RadioToolFlutterPlugin&) = delete;
		RadioToolFlutterPlugin& operator=(const RadioToolFlutterPlugin&) = delete;

	private:
		// Called when a method is called on this plugin's channel from Dart.
		void HandleMethodCall(
			const flutter::MethodCall<flutter::EncodableValue>& method_call,
			std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);

		auto GetWindowsVersion()->std::string;
		auto ListRadios()->std::vector<flutter::EncodableValue>;
	};

}  // namespace radio_tool_flutter

#endif  // FLUTTER_PLUGIN_RADIO_TOOL_FLUTTER_PLUGIN_H_
