#import "NativeBridgePlugin.h"
#import <native_bridge/native_bridge-Swift.h>

@implementation NativeBridgePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftNativeBridgePlugin registerWithRegistrar:registrar];
}
@end
