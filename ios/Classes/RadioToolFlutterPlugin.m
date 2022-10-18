#import "RadioToolFlutterPlugin.h"
#if __has_include(<radio_tool_flutter/radio_tool_flutter-Swift.h>)
#import <radio_tool_flutter/radio_tool_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "radio_tool_flutter-Swift.h"
#endif

@implementation RadioToolFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftRadioToolFlutterPlugin registerWithRegistrar:registrar];
}
@end
