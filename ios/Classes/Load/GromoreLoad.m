//
//  GromoreLoad.m


#import "GromoreLoad.h"
#import "GromoreManager.h"
#import "FlutterYouniGromorePlugin.h"

@implementation GromoreLoad

- (void)loadFeedAdList:(FlutterMethodCall *)call result:(FlutterResult)result eventSink:(FlutterEventSink)events{
    self.result=result;
    // 这里复用整个加载流程
    [self showAd:call eventSink:events];
}

// 加载广告
- (void)loadAd:(FlutterMethodCall *)call{
    int width = [call.arguments[@"width"] intValue];
    int height = [call.arguments[@"height"] intValue];
    int count = [call.arguments[@"count"] intValue];
    // 配置广告加载
    if(!self.adManager){
//        ABUNativeAdSlot slot=[[ABUNativeAdSlot alloc] ini];
        BUAdSlot* slot=[[BUAdSlot alloc] init];
        slot.ID = self.codeId;
        slot.AdType = BUAdSlotAdTypeFeed;
        slot.position = BUAdSlotPositionMiddle;
        slot.imgSize = [BUSize sizeBy:BUProposalSize_Banner600_400];
        self.adManager= [[BUNativeAdsManager alloc] initWithSlot:slot];
    }
    self.adManager.adSize=CGSizeMake(width, height);
//    self.adManager.rootViewController=self.rootController;
//    self.adManager.startMutedIfCan= YES;
    self.adManager.delegate=self;
    // 加载广告
    [self.adManager loadAdDataWithCount:count];
}

#pragma mark ABUNativeAdsManagerDelegate

- (void)nativeAdsManager:(BUNativeAdsManager *)adsManager didFailWithError:(NSError *)error{
    NSLog(@"%s",__FUNCTION__);
    // 发送广告错误事件
    [self sendErrorEvent:error];
}

- (void)nativeAdsManagerSuccessToLoad:(BUNativeAdsManager *)adsManager nativeAds:(NSArray<BUNativeAd *> *)views{
    NSLog(@"%s",__FUNCTION__);
    if (views.count) {
        // 广告列表，用于返回 Flutter 层
        NSMutableArray *adList= [[NSMutableArray alloc] init];
        [views enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            // 通过hash 来标识不同的原生广告 View
            NSNumber *key=[NSNumber numberWithInteger:[obj hash]];
            NSLog(@"FeedAdLoad idx:%lu obj:%p hash:%@",(unsigned long)[obj hash],obj,key);
            // 添加到返回列表中
            [adList addObject:key];
            // 添加到缓存广告列表中
            [GromoreManager.share putAd:key value:obj];
        }];
        // 返回广告列表
        self.result(adList);
    }
    // 发送广告事件
    [self sendEventAction:onAdLoaded];
}

// 发送消息
// 这里发送消息到信息流View，主要是适配信息流 View 的尺寸
//- (void) postNotificationMsg:(BUNativeExpressAdView *) adView userInfo:(NSDictionary *) userInfo{
//    NSLog(@"%s",__FUNCTION__);
//    NSNumber *key=[NSNumber numberWithInteger:[adView hash]];
//    NSString *name=[NSString stringWithFormat:@"%@/%@", kAdFeedViewId, key.stringValue];
//    [[NSNotificationCenter defaultCenter] postNotificationName:name object:adView userInfo:userInfo];
//}

@end
