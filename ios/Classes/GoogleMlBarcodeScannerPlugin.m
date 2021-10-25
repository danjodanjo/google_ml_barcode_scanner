#import "GoogleMlBarcodeScannerPlugin.h"

@implementation GoogleMlBarcodeScannerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"google_ml_barcode_scanner"
                                     binaryMessenger:[registrar messenger]];
    GoogleMlBarcodeScannerPlugin* instance = [[GoogleMlBarcodeScannerPlugin alloc] init];
    
    // Add vision detectors
    NSMutableArray *handlers = [NSMutableArray new];
    [handlers addObject:[[BarcodeScanner alloc] init]];
    
    instance.handlers = [NSMutableDictionary new];
    for (id<Handler> detector in handlers) {
        for (NSString *key in detector.getMethodsKeys) {
            instance.handlers[key] = detector;
        }
    }
    
    [registrar addMethodCallDelegate:instance channel:channel];

}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
