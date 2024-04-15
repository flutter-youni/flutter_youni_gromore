//
//  GromoreEvent.m


#import "GromoreEvent.h"

@implementation GromoreEvent
- (id)initWithAdId:(NSString *)adId action:(NSString *)action{
    self.adId=adId;
    self.action=action;
    return self;
}

- (NSDictionary *)toMap{
    NSDictionary *data=@{@"adId":self.adId,@"action":self.action};
    return  data;
}
@end
