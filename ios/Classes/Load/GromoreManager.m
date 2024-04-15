//


#import "GromoreManager.h"

@implementation GromoreManager

static GromoreManager *manager;
NSMutableDictionary *adList;// 已加载信息流广告列表


+ (instancetype)share{
    static dispatch_once_t once_token;
    dispatch_once(&once_token, ^{
        adList= [[NSMutableDictionary alloc]init];
        manager=[[GromoreManager alloc] init];
    });
    return manager;
}

- (void)putAd:(NSNumber*)key value:(id)value{
    [adList setObject:value forKey:key];
}

- (id)getAd:(NSNumber*)key{
    return adList[key];
}

- (void)removeAd:(NSNumber*)key{
    [adList removeObjectForKey:key];
}



@end
