#import "FlTwitterLoginPlugin.h"
#import <fl_twitter_login/fl_twitter_login-Swift.h>

@implementation FlTwitterLoginPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlTwitterLoginPlugin registerWithRegistrar:registrar];
}
@end
