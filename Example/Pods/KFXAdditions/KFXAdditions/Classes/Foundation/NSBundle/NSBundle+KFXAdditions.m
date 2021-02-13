//
//  NSBundle+KFXAdditions.m
//  KFXAdditions
//
//  Created by Eyeye on 23/10/2019.
//

#import "NSBundle+KFXAdditions.h"

@implementation NSBundle (KFXAdditions)

+ (instancetype)kfx_podResourceBundleWithPodBundleIdentifier:(NSString *)identifier resourcesName:(NSString *)name {
	
	NSBundle *podBundle = [NSBundle bundleWithIdentifier:identifier];
	return [self kfx_resourceBundleForPodBundle:podBundle resourcesName:name];
}

+ (instancetype)kfx_podResourceBundleWithClass:(Class)aClass resourcesName:(NSString *)name {

	NSBundle *podBundle = [NSBundle bundleForClass:aClass];
	return [self kfx_resourceBundleForPodBundle:podBundle resourcesName:name];
}

//==========================
#pragma mark - ** Private **
//==========================
+ (instancetype _Nullable)kfx_resourceBundleForPodBundle:(NSBundle*)podBundle resourcesName:(NSString*)name {
	
	if (podBundle == nil) {
		return nil;
	}
	NSURL *resBundleURL = [podBundle URLForResource:name withExtension:@"bundle"];
	if (resBundleURL == nil) {
		return nil;
	}
	return [NSBundle bundleWithURL:resBundleURL];
}


@end
