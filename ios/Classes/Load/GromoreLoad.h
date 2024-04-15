//
//  GromoreLoad.h


#import <Foundation/Foundation.h>
#import "GromoreBasePage.h"

@interface GromoreLoad : GromoreBasePage<BUNativeAdsManagerDelegate>
@property (strong,nonatomic,nonnull) FlutterResult result;
@property (strong,nonatomic,nullable) BUNativeAdsManager *adManager;
// 加载信息流广告列表
-(void) loadFeedAdList:(nonnull FlutterMethodCall *)call result:(nonnull FlutterResult) result eventSink:(nonnull FlutterEventSink )events;
@end
