#import <Flutter/Flutter.h>
#import "GromoreSplashPage.h"
#import "GromoreInterstitialPage.h"
#import "GromoreLoad.h"
#import "GromoreManager.h"
#import "GromoreRewardVideoPage.h"

@interface FlutterYouniGromorePlugin : NSObject<FlutterPlugin, FlutterStreamHandler>

@property (strong,nonatomic) FlutterEventSink eventSink;// 事件
@property (strong,nonatomic) GromoreSplashPage *sad;// 开屏广告
@property (strong,nonatomic) GromoreInterstitialPage *iad;// 插屏广告
@property (strong,nonatomic) GromoreRewardVideoPage *rad;// 激励视频广告

extern NSString *const kYNBannerViewId;


@end
