//


#import "GromoreInterstitialPage.h"

@interface GromoreInterstitialPage()<BUMNativeExpressFullscreenVideoAdDelegate>

@end

@implementation GromoreInterstitialPage

- (void)loadAd:(FlutterMethodCall *)call{
    int width=[call.arguments[@"width"] intValue];
    int height=[call.arguments[@"height"] intValue];
    self.ad= [[BUNativeExpressFullscreenVideoAd alloc] initWithSlotID:self.codeId];
    self.ad.delegate=self;
    [self.ad loadAdData];
}

#pragma mark - BUMNativeExpressFullscreenVideoAdDelegate
- (void)nativeExpressFullscreenVideoAdDidLoad:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd {
    NSLog(@"%s",__FUNCTION__);
    if(self.ad && self.ad.mediation.isReady){
        [self.ad showAdFromRootViewController:self.rootController];
    }
    // 发送事件
    [self sendEventAction:onAdLoaded];
}

- (void)nativeExpressFullscreenVideoAd:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *_Nullable)error {
    NSLog(@"%s-error:%@", __FUNCTION__, error);
    // 发送事件
    [self sendErrorEvent:error];
}

- (void)nativeExpressFullscreenVideoAdViewRenderSuccess:(BUNativeExpressFullscreenVideoAd *)rewardedVideoAd {
    NSLog(@"%s",__FUNCTION__);
    // 发送事件
    [self sendEventAction:onAdExposure];
}

- (void)nativeExpressFullscreenVideoAdViewRenderFail:(BUNativeExpressFullscreenVideoAd *)rewardedVideoAd error:(NSError *_Nullable)error {
    NSLog(@"%s-error:%@", __FUNCTION__, error);
    // 发送事件
    [self sendErrorEvent:error];
}

- (void)nativeExpressFullscreenVideoAdDidDownLoadVideo:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd {
    NSLog(@"%s",__FUNCTION__);
}

- (void)nativeExpressFullscreenVideoAdWillVisible:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd {
    NSLog(@"%s",__FUNCTION__);
}

- (void)nativeExpressFullscreenVideoAdDidVisible:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd {
    NSLog(@"%s",__FUNCTION__);
}

- (void)nativeExpressFullscreenVideoAdDidClick:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd {
    NSLog(@"%s",__FUNCTION__);
    // 发送事件
    [self sendEventAction:onAdClicked];
}

- (void)nativeExpressFullscreenVideoAdDidClickSkip:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd {
    NSLog(@"%s",__FUNCTION__);
    // 发送事件
    [self sendEventAction:onAdComplete];
}

- (void)nativeExpressFullscreenVideoAdWillClose:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd {
    NSLog(@"%s",__FUNCTION__);
}

- (void)nativeExpressFullscreenVideoAdDidClose:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd {
    NSLog(@"%s",__FUNCTION__);
    // 发送事件
    [self sendEventAction:onAdClosed];
}

- (void)nativeExpressFullscreenVideoAdDidPlayFinish:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *_Nullable)error {
    NSLog(@"%s",__FUNCTION__);
}

- (void)nativeExpressFullscreenVideoAdCallback:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd withType:(BUNativeExpressFullScreenAdType) nativeExpressVideoAdType{
    NSLog(@"%s",__FUNCTION__);
}

- (void)nativeExpressFullscreenVideoAdDidCloseOtherController:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd interactionType:(BUInteractionType)interactionType {
    NSLog(@"%s",__FUNCTION__);
}

- (void)nativeExpressFullscreenVideoAdServerRewardDidSucceed:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd verify:(BOOL)verify {
    NSLog(@"%s",__FUNCTION__);
}

- (void)nativeExpressFullscreenVideoAdServerRewardDidFail:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd error:(NSError *)error {
    NSLog(@"%s",__FUNCTION__);
}

@end
