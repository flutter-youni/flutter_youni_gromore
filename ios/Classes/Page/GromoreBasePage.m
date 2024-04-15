//

#import "GromoreBasePage.h"

@implementation GromoreBasePage
- (void)showAd:(FlutterMethodCall *)call eventSink:(FlutterEventSink)events{
    self.codeId=call.arguments[@"codeId"];
    self.eventSink=events;
    // 获取控制器
    self.mainWin=[[UIApplication sharedApplication] keyWindow];
    self.rootController=[self.mainWin rootViewController];
    //加载广告
    [self loadAd:call];
}

- (void)loadAd:(FlutterMethodCall *)call{
    NSLog(@"%s",__FUNCTION__);
    
}

- (void)sendEvent:(GromoreEvent *)event{
    if(self.eventSink){
        self.eventSink(event.toMap);
    }
}

- (void)sendEventAction:(NSString *)action{
    GromoreEvent *event=[[GromoreEvent alloc] initWithAdId:self.codeId action:action];
    [self sendEvent:event];

}

- (void)sendErrorEvent:(NSError *)error{
    if (self.eventSink) {
        GromoreErrorEvent *event=[[GromoreErrorEvent alloc] initWithAdId:self.codeId error:error];
        self.eventSink(event.toMap);
    }
}
@end
