//


#import <Foundation/Foundation.h>
#import "GromoreBasePage.h"

// 开屏广告
@interface GromoreSplashPage :GromoreBasePage
// 开屏
@property (strong,nonatomic) BUSplashAd *ad;
@property (strong,nonatomic) UIView *bottomView;
@property (assign,nonatomic ) BOOL fullScreenAd;
// 广告是否展示中
@property (assign,nonatomic ) BOOL isDisplay;
@end
