
//#import <AppKit/AppKit.h>

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (KFXAdditions)

+ (instancetype _Nullable)kfx_podResourceBundleWithPodBundleIdentifier:(NSString*)identifier resourcesName:(NSString*)name;

+ (instancetype _Nullable)kfx_podResourceBundleWithClass:(Class)aClass resourcesName:(NSString*)name;

@end

NS_ASSUME_NONNULL_END
