//


#import "GromoreBannerView.h"

@interface GromoreBannerView()<FlutterPlatformView,BUMNativeExpressBannerViewDelegate>
@property (strong,nonatomic) BUNativeExpressBannerView *bad;
@property (strong,nonatomic) UIView *bannerView;

@end

@implementation GromoreBannerView

- (instancetype)initWithFrame:(CGRect)frame
               viewIdentifier:(int64_t)viewId
                    arguments:(id _Nullable)args
              binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger
                       plugin:(FlutterYouniGromorePlugin*) plugin{
    if (self = [super init]) {
        self.bannerView = [[UIView alloc] init];
        FlutterMethodCall *call=[FlutterMethodCall methodCallWithMethodName:@"AdBannerView" arguments:args];
        [self showAd:call eventSink:plugin.eventSink];
    }
    return self;
}

- (UIView*)view {
    return self.bannerView;
}
// 加载广告
- (void)loadAd:(FlutterMethodCall *)call{
    // 刷新间隔
    int width = [call.arguments[@"width"] intValue];
    int height = [call.arguments[@"height"] intValue];
    self.bad=[[BUNativeExpressBannerView alloc] initWithSlotID:self.codeId rootViewController:self.rootController adSize:CGSizeMake(width, height)];
    self.bad.delegate=self;
    [self.bad loadAdData];
}


#pragma mark ----- ABUBannerAdDelegate -----
/// 加载成功回调
- (void)nativeExpressBannerAdViewDidLoad:(BUNativeExpressBannerView *)bannerAdView {
    NSLog(@"%s",__FUNCTION__);
    [self.bannerView addSubview:bannerAdView];
    // 发送事件
    [self sendEventAction:onAdLoaded];
}

/// 加载失败回调
- (void)nativeExpressBannerAdView:(BUNativeExpressBannerView *)bannerAdView didLoadFailWithError:(NSError *)error {
    NSLog(@"%s-error:%@", __FUNCTION__, error);
    // 发送事件
    [self sendErrorEvent:error];
    // 销毁广告
    [self destoryAd:nil];
}

/// 展示成功回调
- (void)nativeExpressBannerAdViewDidBecomeVisible:(BUNativeExpressBannerView *)bannerAdView {
    NSLog(@"%s",__FUNCTION__);
    // 发送事件
    [self sendEventAction:onAdExposure];
}

/// 广告点击回调
- (void)nativeExpressBannerAdViewDidClick:(BUNativeExpressBannerView *)bannerAdView {
    NSLog(@"%s",__FUNCTION__);
    // 发送事件
    [self sendEventAction:onAdClicked];
}

- (void)nativeExpressBannerAdView:(BUNativeExpressBannerView *)bannerAdView dislikeWithReason:(NSArray<BUDislikeWords *> *)filterwords {
    NSLog(@"%s",__FUNCTION__);
}

- (void)nativeExpressBannerAdViewDidCloseOtherController:(BUNativeExpressBannerView *)bannerAdView interactionType:(BUInteractionType)interactionType {
    NSLog(@"%s",__FUNCTION__);
}

- (void)nativeExpressBannerAdViewDidRemoved:(BUNativeExpressBannerView *)nativeExpressAdView {
    NSLog(@"%s",__FUNCTION__);
    // 可于此处移除广告view
    [self destoryAd:self.bannerView];
    // 发送事件
    [self sendEventAction:onAdClosed];
}

// 销毁广告
- (void)destoryAd:(UIView *)bannerView{
        if(bannerView){
            [bannerView removeFromSuperview];
        }
        self.bad.delegate=nil;
        self.bad=nil;
}

@end
