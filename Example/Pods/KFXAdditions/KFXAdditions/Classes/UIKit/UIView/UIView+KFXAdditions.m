/********************************
 *
 * Copyright © 2016-2017 Christian Fox
 * All Rights Reserved
 * Full licence details can be found in the file 'LICENSE' or in the Pods-{yourProjectName}-acknowledgements.markdown
 *
 * This file is included with KFXAdditions
 *
 ************************************/


#import "UIView+KFXAdditions.h"

@implementation UIView (KFXAdditions)

//--------------------------------------------------------
#pragma mark Init
//--------------------------------------------------------
+(instancetype)kfx_instantiateFromNib{
	return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class])
										owner:nil
									  options:nil].firstObject;
}


//--------------------------------------------------------
#pragma mark - First Responder
//--------------------------------------------------------
-(UIView *)kfx_findFirstResponder{
    
    // Found it first time - yay!
    if ([self isFirstResponder]) {
        return self;
    }
    
    // Look through subviews
    for (UIView *subview in [self subviews]) {
        UIView *firstResponder = [subview kfx_findFirstResponder];
        if (firstResponder != nil) {
            return firstResponder;
        }
    }
    
    // Cannot be found
    return nil;
}



//--------------------------------------------------------
#pragma mark - Border
//--------------------------------------------------------
-(void)kfx_addBorderWithRadius:(CGFloat)radius width:(CGFloat)borderWidth colour:(UIColor *)colour{
	
	self.layer.cornerRadius = radius;
	self.layer.borderWidth = borderWidth;
	self.layer.masksToBounds = YES;
	self.layer.borderColor = colour.CGColor;
	
}



@end
