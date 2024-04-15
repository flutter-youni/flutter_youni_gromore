//


#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>
#import "YouNiGroMore.h"
#import "GromoreErrorEvent.h"
// 基础广告页面
@interface GromoreBasePage : NSObject
// 广告位 id
@property (strong,nonatomic) NSString *codeId;
// 回调事件
@property (strong,nonatomic) FlutterEventSink eventSink;
// 窗口
@property (strong,nonatomic) UIWindow *mainWin;
// 跟控制器
@property (strong,nonatomic) UIViewController *rootController;
//显示广告
- (void) showAd:(FlutterMethodCall*) call eventSink:(FlutterEventSink) events;
// 加载广告
- (void) loadAd:(FlutterMethodCall*) call;
// 发送广告事件
- (void) sendEvent:(GromoreEvent*) event;
// 发送广告事件
- (void) sendEventAction:(NSString*) action;
// 发送错误广告事件
- (void) sendErrorEvent:(NSError*) error;
@end
