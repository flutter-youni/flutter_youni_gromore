//


#import "GromoreBasePage.h"
#import "FlutterYouniGromorePlugin.h"

@interface GromoreBannerView : GromoreBasePage<FlutterPlatformView>
@property (strong,nonatomic,nullable) FlutterYouniGromorePlugin *plugin;
- (nonnull instancetype)initWithFrame:(CGRect)frame
                       viewIdentifier:(int64_t)viewId
                            arguments:(id _Nullable)args
                      binaryMessenger:(NSObject<FlutterBinaryMessenger>* _Nullable)messenger plugin:(FlutterYouniGromorePlugin* _Nullable) plugin;

- (nonnull UIView*)view;
@end
