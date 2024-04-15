//


#import "GromoreRewardVideoPage.h"
#import <BUAdSDK/BUNativeExpressRewardedVideoAd.h>
#import <BUAdSDK/BURewardedVideoModel.h>
#import <BUAdSDK/BUNativeExpressRewardedVideoAd+Mediation.h>

@interface GromoreRewardVideoPage()<BUMNativeExpressRewardedVideoAdDelegate>

@end

@implementation GromoreRewardVideoPage

- (void)loadAd:(FlutterMethodCall *)call{
    BUAdSlot *adslot = [[BUAdSlot alloc] init];
    adslot.ID = self.codeId;
    // [可选]配置：设置是否静音
    adslot.mediation.mutedIfCan = NO;
    
    
    // [可选]配置：设置奖励信息
    BURewardedVideoModel *model = [[BURewardedVideoModel alloc] init];
    //    model.userId = @"123";
    model.rewardName = @"金币";
    model.rewardAmount = 100;
    
    self.ad= [[BUNativeExpressRewardedVideoAd alloc] initWithSlot:adslot rewardedVideoModel:model];
    self.ad.delegate=self;
    [self.ad loadAdData];
}

#pragma mark - BUMNativeExpressRewardedVideoAdDelegate
- (void)nativeExpressRewardedVideoAdDidLoad:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    NSLog(@"%s",__FUNCTION__);
    if(self.ad && self.ad.mediation.isReady){
        [self.ad showAdFromRootViewController:self.rootController];
    }
    // 发送事件
    [self sendEventAction:onAdLoaded];
}

- (void)nativeExpressRewardedVideoAd:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *_Nullable)error {
    // 发送事件
    [self sendErrorEvent:error];
}

- (void)nativeExpressRewardedVideoAdViewRenderSuccess:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    // 发送事件
    [self sendEventAction:onAdExposure];
}

- (void)nativeExpressRewardedVideoAdDidShowFailed:(BUNativeExpressRewardedVideoAd *_Nonnull)rewardedVideoAd error:(NSError *_Nonnull)error{
    NSLog(@"%s-error:%@", __FUNCTION__, error);
    // 发送事件
    [self sendErrorEvent:error];
}

- (void)nativeExpressRewardedVideoAdDidDownLoadVideo:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {    NSLog(@"%s",__FUNCTION__);
}

- (void)nativeExpressRewardedVideoAdDidVisible:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    
}

- (void)nativeExpressRewardedVideoAdDidClick:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    // 发送事件
    [self sendEventAction:onAdClicked];
}

- (void)nativeExpressRewardedVideoAdDidClose:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    // 发送事件
    [self sendEventAction:onAdClosed];
}


- (void)nativeExpressRewardedVideoAdDidClickSkip:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    // 发送事件
    [self sendEventAction:onAdComplete];
}



- (void)nativeExpressRewardedVideoAdDidPlayFinish:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *_Nullable)error {
    NSLog(@"%s",__func__);
}

- (void)nativeExpressRewardedVideoAdServerRewardDidSucceed:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd verify:(BOOL)verify {
   
   
}

- (void)nativeExpressRewardedVideoAdServerRewardDidFail:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd error:(NSError *_Nullable)error {
    
}

@end
