/********************************
 *
 * Copyright © 2016-2017 Christian Fox
 * All Rights Reserved
 * Full licence details can be found in the file 'LICENSE' or in the Pods-{yourProjectName}-acknowledgements.markdown
 *
 * This file is included with KFXUtilities
 *
 ************************************/


#import <Foundation/Foundation.h>
@import UIKit.UIViewController;

NS_ASSUME_NONNULL_BEGIN
@protocol KFXPhotoPickerManagerDelegate;

@interface KFXPhotoPickerManager : NSObject

@property (weak,nonatomic) id<KFXPhotoPickerManagerDelegate> delegate;

/**
 *  @brief Presents the standard UIImagePickerController via an Action Sheet.
 *
 *  @description Checks for device capabilities and user priviledges; returns if neither camera or photos album is available. Gives the user the option to choose to take a photo or pick one from the photos album.
 *
 *  Handles UIImagePickerControllerDelegateMethods and sends any selected image to the PhotoPickerManagerDelegate.
 *  On iPad uses the view and viewController arguments to determine where to the popover view should originate from.
 *
 *  @param view           The view that the image Picker action sheet should originate from.
 *  @param viewController Needed to do the presenting of the action sheet and Image Picker.
 */
-(void)presentImagePickerFromView:(UIView*)view inViewController:(UIViewController*)viewController;

/**
 *  @brief Presents the standard UIImagePickerController via an Action Sheet.
 *
 *  @description Checks for device capabilities and user priviledges; returns if neither camera or photos album is available. Gives the user the option to choose to take a photo or pick one from the photos album.
 *
 *  Handles UIImagePickerControllerDelegateMethods and sends any selected image to the PhotoPickerManagerDelegate.
 *  On iPad uses the sourceRect and viewController arguments to determine where to the popover view should originate from.
 *
 *  @param sourceRect   The area of the viewController's view that the image Picker action sheet should originate from.
 *  @param viewController Needed to do the presenting of the action sheet and Image Picker.
 */
-(void)presentImagePickerFromSourceRect:(CGRect)sourceRect inViewController:(UIViewController*)viewController;

@end






//======================================================
#pragma mark - ** Delegate **
//======================================================
@protocol KFXPhotoPickerManagerDelegate <NSObject>

/**
 *  Returns the image selected by the user.
 *
 *  @param manager The PhotoPickerManager object that called the method.
 *  @param image   The image that the user selected.
 */
-(void)photoPickerManager:(KFXPhotoPickerManager*)manager didSelectImage:(UIImage*)image;

@end



NS_ASSUME_NONNULL_END
