#import "FlutterYouniGromorePlugin.h"
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AdSupport/AdSupport.h>
#import "YouNiGroMore.h"
#import "GromoreNativeViewFactory.h"

@implementation FlutterYouniGromorePlugin

// AdBannerView
NSString *const kYNBannerViewId=@"flutter_gromore_banner";

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* methodChannel = [FlutterMethodChannel
                                     methodChannelWithName:@"flutter_youni_gromore"
                                     binaryMessenger:[registrar messenger]];
    
    FlutterEventChannel* eventChannel=[FlutterEventChannel eventChannelWithName:@"flutter_youni_gromore_event" binaryMessenger:[registrar messenger]];
    
    FlutterYouniGromorePlugin* instance = [[FlutterYouniGromorePlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:methodChannel];
    [eventChannel setStreamHandler:instance];

    // 注册平台View 工厂
    GromoreNativeViewFactory *bannerFactory=[[GromoreNativeViewFactory alloc] initWithViewName:kYNBannerViewId withMessenger:registrar.messenger withPlugin:instance];
    // 注册 View
    [registrar registerViewFactory:bannerFactory withId:kYNBannerViewId];
    

    
}
- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSString *methodStr=call.method;
    if ([@"getPlatformVersion" isEqualToString:methodStr]) {
        result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
    }else if ([@"requestIDFA" isEqualToString:methodStr]) {
        [self requestIDFA:call result:result];
    }else if ([@"init" isEqualToString:methodStr]){
        [self init:call result:result];
    }else if ([@"showSplash" isEqualToString:methodStr]) {
        [self showSplash:call result:result];
    }else if ([@"showInterstitial" isEqualToString:methodStr]) {
        [self showInterstitial:call result:result];
    } else if ([@"showReward" isEqualToString:methodStr]) {
        [self showReward:call result:result];
    }
    else {
        result(FlutterMethodNotImplemented);
    }
}

// 请求IDFA
- (void)requestIDFA:(FlutterMethodCall*) call result:(FlutterResult) result{
    if (@available(iOS 14, *)) {
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            BOOL requestResult=status == ATTrackingManagerAuthorizationStatusAuthorized;
            NSLog(@"FlutterYouniGromorePlugin requestIDFA:%@",requestResult?@"YES":@"NO");
            result(@(requestResult));
        }];
    } else {
        result(@(YES));
    }
}

// 初始化广告
- (void)init:(FlutterMethodCall*) call result:(FlutterResult) result{
    NSString *appId=call.arguments[@"appId"];
    NSString *config=call.arguments[@"config"];
    int limitPersonalAds=[call.arguments[@"limitPersonalAds"] intValue];
    BUAdSDKConfiguration *configuration = [BUAdSDKConfiguration configuration];
    // 是否开启调试
    #ifdef DEBUG
        configuration.debugLog = @(1);
    #endif
    // 配置 appid 和使用聚合
    configuration.appID = appId;
    configuration.useMediation = YES;
    // 隐私合规
    configuration.mediation.limitPersonalAds = @(limitPersonalAds);
    configuration.mediation.limitProgrammaticAds = @(limitPersonalAds);
    configuration.mediation.forbiddenCAID = @(limitPersonalAds);
    // 提前导入配置
    if (![config isKindOfClass:[NSNull class]] && [config length]!=0) {
        configuration.mediation.advanceSDKConfigPath = [[NSBundle mainBundle]pathForResource:config ofType:@"json"];
    }
    
    [BUAdSDKManager startWithAsyncCompletionHandler:^(BOOL success, NSError *error) {
        if (success) {
            result(@(YES));
        } else {
            result(@(NO));
            NSLog(@"FlutterYouniGromorePlugin init error:%@",error.description);
        }
    }];
    
}

// 开屏广告
- (void)showSplash:(FlutterMethodCall*) call result:(FlutterResult) result{
    if (self.sad!=nil&&self.sad.isDisplay) {
        result(@(NO));
        return;
    }
    self.sad=[[GromoreSplashPage alloc] init];
    [self.sad showAd:call eventSink:self.eventSink];
    result(@(YES));
}

// 插屏广告
- (void)showInterstitial:(FlutterMethodCall *)call result:(FlutterResult) result{
    self.iad=[[GromoreInterstitialPage alloc] init];
    [self.iad showAd:call eventSink:self.eventSink];
    result(@(YES));
}

// 激励视频广告
- (void)showReward:(FlutterMethodCall *)call result:(FlutterResult) result{
    self.rad= [[GromoreRewardVideoPage alloc] init];
    [self.rad showAd:call eventSink:self.eventSink];
    result(@(YES));
}

#pragma mark - FlutterStreamHandler

- (FlutterError *)onCancelWithArguments:(id)arguments{
    self.eventSink = nil;
    return nil;
}
- (FlutterError *)onListenWithArguments:(id)arguments eventSink:(FlutterEventSink)events{
    self.eventSink = events;
    return nil;
}

- (void) addEvent:(NSObject *) event{
    if(self.eventSink){
        self.eventSink(event);
    }
}
@end
