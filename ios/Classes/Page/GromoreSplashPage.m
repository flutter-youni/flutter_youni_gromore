//


#import "GromoreSplashPage.h"

@interface GromoreSplashPage ()<BUSplashAdDelegate>

@end

@implementation GromoreSplashPage

- (void)loadAd:(FlutterMethodCall *)call{
    NSLog(@"%s，%@",__FUNCTION__,self.codeId);
    self.isDisplay=YES;
    NSString* logo=call.arguments[@"logo"];
    double timeout=[call.arguments[@"timeout"] doubleValue];
    // logo 判断为空，则全屏展示
    self.fullScreenAd=[logo isKindOfClass:[NSNull class]]||[logo length]==0;
    
    // 创建广告
    self.ad =[[BUSplashAd alloc] initWithSlotID:self.codeId adSize:CGSizeZero];
    self.ad.delegate=self;
    self.ad.supportCardView = YES;
    self.ad.supportZoomOutView = YES;
    self.ad.tolerateTimeout=timeout;
    if (!self.fullScreenAd) {
        CGSize size=[[UIScreen mainScreen] bounds].size;
        CGFloat width=size.width;
        CGFloat height=112.5;// 这里按照 15% 进行logo 的展示，防止尺寸不够的问题，750*15%=112.5
        // 设置底部 logo
        self.bottomView=nil;
        self.bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,width, height)];
        self.bottomView.backgroundColor=[UIColor whiteColor];
        UIImageView *logoView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:logo]];
        logoView.frame=CGRectMake(0, 0, width, height);
        logoView.contentMode=UIViewContentModeCenter;
        logoView.center=self.bottomView.center;
        [self.bottomView addSubview:logoView];
        [self.ad.mediation setCustomBottomView:self.bottomView];
    }
    [self.ad loadAdData];
}

- (void)splashAdLoadSuccess:(nonnull BUSplashAd *)splashAd {
    NSLog(@"%s",__FUNCTION__);
    [self.ad showSplashViewInRootViewController:self.rootController];
    // 发送事件
    [self sendEventAction:onAdLoaded];
}
- (void)splashAdLoadFail:(nonnull BUSplashAd *)splashAd error:(BUAdError * _Nullable)error {
    NSLog(@"%s-error:%@", __func__, error);
    // 发送事件
    [self sendErrorEvent:error];
    self.isDisplay=NO;
}

- (void)splashAdDidShow:(nonnull BUSplashAd *)splashAd {
    NSLog(@"%s",__FUNCTION__);
    // 发送事件
    [self sendEventAction:onAdExposure];
}

- (void)splashAdDidShowFailed:(BUSplashAd *)splashAd error:(NSError *)error{
    NSLog(@"%s",__FUNCTION__);
    // 发送事件
    [self sendErrorEvent:error];
    self.isDisplay=NO;
}

- (void)splashAdDidClick:(nonnull BUSplashAd *)splashAd {
    NSLog(@"%s",__FUNCTION__);
    // 发送事件
    [self sendEventAction:onAdClicked];
}

- (void)splashAdDidClose:(nonnull BUSplashAd *)splashAd closeType:(BUSplashAdCloseType)closeType {
    NSLog(@"%s",__FUNCTION__);
    // 发送事件
    [self sendEventAction:onAdClosed];
    // 销毁广告
    if (self.ad) {
        [self.ad.mediation destoryAd];
    }
    self.isDisplay=NO;
}


- (void)splashCardReadyToShow:(nonnull BUSplashAd *)splashAd {
    NSLog(@"%s",__FUNCTION__);
    [self.ad showSplashViewInRootViewController:self.rootController];
    // 发送事件
    [self sendEventAction:onAdLoaded];
}

- (void)splashCardViewDidClick:(nonnull BUSplashAd *)splashAd {
    NSLog(@"%s",__FUNCTION__);
    // 发送事件
    [self sendEventAction:onAdClicked];
}

- (void)splashCardViewDidClose:(nonnull BUSplashAd *)splashAd {
    NSLog(@"%s",__FUNCTION__);
    // 发送事件
    [self sendEventAction:onAdClosed];
    // 销毁广告
    if (self.ad) {
        [self.ad.mediation destoryAd];
    }
    self.isDisplay=NO;
}

- (void)splashAdViewControllerDidClose:(BUSplashAd *)splashAd {
    NSLog(@"%s",__FUNCTION__);
}

- (void)splashDidCloseOtherController:(nonnull BUSplashAd *)splashAd interactionType:(BUInteractionType)interactionType {
    NSLog(@"%s",__FUNCTION__);
}


- (void)splashVideoAdDidPlayFinish:(BUSplashAd *)splashAd didFailWithError:(NSError *)error {
    NSLog(@"%s",__FUNCTION__);
}




- (void)splashZoomOutViewDidClick:(nonnull BUSplashAd *)splashAd {
    NSLog(@"%s",__FUNCTION__);
    // 发送事件
    [self sendEventAction:onAdClicked];
}


- (void)splashZoomOutViewDidClose:(nonnull BUSplashAd *)splashAd {
    NSLog(@"%s",__FUNCTION__);
    // 发送事件
    [self sendEventAction:onAdClosed];
    // 销毁广告
    if (self.ad) {
        [self.ad.mediation destoryAd];
    }
    self.isDisplay=NO;
}

- (void)splashZoomOutReadyToShow:(nonnull BUSplashAd *)splashAd {
    NSLog(@"%s",__FUNCTION__);
    // 接入方法一：使用SDK提供动画接入
    if (self.ad.zoomOutView) {
        [self.ad showZoomOutViewInRootViewController:self.rootController];
    }
}

@end
