//


#import "GromoreNativeViewFactory.h"
#import "GromoreBannerView.h"

@implementation GromoreNativeViewFactory


- (instancetype)initWithViewName:(NSString *)viewName withMessenger:(NSObject<FlutterBinaryMessenger> *)messenger withPlugin:(FlutterYouniGromorePlugin *)plugin{
    self = [super init];
    if (self) {
        self.viewName = viewName;
        self.messenger = messenger;
        self.plugin = plugin;
    }
    return self;
}

- (NSObject<FlutterMessageCodec>*)createArgsCodec {
    return [FlutterStandardMessageCodec sharedInstance];
}

- (NSObject<FlutterPlatformView>*)createWithFrame:(CGRect)frame
                                   viewIdentifier:(int64_t)viewId
                                        arguments:(id _Nullable)args {
    if (self.viewName==kYNBannerViewId) {
        return [[GromoreBannerView alloc] initWithFrame:frame
                                    viewIdentifier:viewId
                                         arguments:args
                                   binaryMessenger:self.messenger
                                            plugin:self.plugin];
    }
    return nil;
}

@end
