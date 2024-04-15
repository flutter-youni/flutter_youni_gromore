//


#import <Flutter/Flutter.h>
#import <Foundation/Foundation.h>
#import "FlutterYouniGromorePlugin.h"

NS_ASSUME_NONNULL_BEGIN

@interface GromoreNativeViewFactory : NSObject<FlutterPlatformViewFactory>
@property (strong,nonatomic) NSObject<FlutterBinaryMessenger> *messenger;
@property (strong,nonatomic) FlutterYouniGromorePlugin *plugin;
@property (strong,nonatomic) NSString *viewName;
- (instancetype)initWithViewName:(NSString*) viewName withMessenger:(NSObject<FlutterBinaryMessenger>*)messenger withPlugin:(FlutterYouniGromorePlugin*) plugin;

@end

NS_ASSUME_NONNULL_END
