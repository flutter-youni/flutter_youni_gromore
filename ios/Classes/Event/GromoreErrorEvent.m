//
//  GromoreErrorEvent.m
//
//

#import "GromoreErrorEvent.h"

@implementation GromoreErrorEvent
- (id)initWithAdId:(NSString *)adId errCode:(NSInteger)errCode errMsg:(NSString *)errMsg{
    self.adId=adId;
    self.action=onAdError;
    self.errCode=errCode;
    self.errMsg=errMsg;
    return self;
}

- (id)initWithAdId:(NSString *)adId error:(NSError *)error{
    return [self initWithAdId:adId errCode:error.code errMsg:error.localizedDescription];
}

- (NSDictionary *)toMap{
    NSMutableDictionary *errData=[[NSMutableDictionary alloc] initWithDictionary:[super toMap]];
    [errData setObject:@(self.errCode) forKey:@"errCode"];
    [errData setObject:self.errMsg forKey:@"errMsg"];
    return errData;
}
@end
