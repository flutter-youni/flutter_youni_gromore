//


#import <Foundation/Foundation.h>
#import "YouNiGroMore.h"

@interface GromoreManager : NSObject
+ (instancetype) share;
// 加入到缓存中
- (void) putAd:(NSNumber*) key value:(BUNativeExpressAdView*) value;
// 从缓存中获取
- (BUNativeExpressAdView*) getAd:(NSNumber*) key;
// 从缓存中删除
- (void) removeAd:(NSNumber*) key;

@end
