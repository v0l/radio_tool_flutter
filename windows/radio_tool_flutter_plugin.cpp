#include "radio_tool_flutter_plugin.h"

// This must be included before many other Windows headers.
#include <windows.h>

// For getPlatformVersion; remove unless needed for your plugin implementation.
#include <VersionHelpers.h>

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>

#include <radio_tool/radio/radio_factory.hpp>
#include <memory>
#include <sstream>
#include <codecvt>

using namespace radio_tool_flutter;
using namespace radio_tool::radio;

// static
void RadioToolFlutterPlugin::RegisterWithRegistrar(
	flutter::PluginRegistrarWindows* registrar) {
	auto channel =
		std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
			registrar->messenger(), "radio_tool_flutter",
			&flutter::StandardMethodCodec::GetInstance());

	auto plugin = std::make_unique<RadioToolFlutterPlugin>();

	channel->SetMethodCallHandler(
		[plugin_pointer = plugin.get()](const auto& call, auto result) {
		plugin_pointer->HandleMethodCall(call, std::move(result));
	});

	registrar->AddPlugin(std::move(plugin));
}

RadioToolFlutterPlugin::RadioToolFlutterPlugin() {}

RadioToolFlutterPlugin::~RadioToolFlutterPlugin() {}

void RadioToolFlutterPlugin::HandleMethodCall(
	const flutter::MethodCall<flutter::EncodableValue>& method_call,
	std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {
	if (method_call.method_name().compare("getPlatformVersion") == 0) {
		result->Success(flutter::EncodableValue(GetWindowsVersion()));
	}
	else if (method_call.method_name().compare("listRadios") == 0)
	{
		result->Success(flutter::EncodableList(ListRadios()));
	}
	else {
		result->NotImplemented();
	}
}

auto RadioToolFlutterPlugin::GetWindowsVersion() -> std::string
{
	std::ostringstream version_stream;
	version_stream << "Windows ";
	if (IsWindows10OrGreater()) {
		version_stream << "10+";
	}
	else if (IsWindows8OrGreater()) {
		version_stream << "8";
	}
	else if (IsWindows7OrGreater()) {
		version_stream << "7";
	}
	return version_stream.str();
}

auto RadioToolFlutterPlugin::ListRadios()->std::vector<flutter::EncodableValue>
{
	RadioFactory factory;

	auto ret = std::vector<flutter::EncodableValue>();
	for (const auto& info : factory.ListDevices()) {
		auto device_string = std::wstring_convert<std::codecvt_utf8<wchar_t>>().to_bytes(info->ToString());
		ret.push_back(device_string);
	}

	return ret;
}
