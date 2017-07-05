/********************************
 *
 * Copyright © 2016-2017 Christian Fox
 * All Rights Reserved
 * Full licence details can be found in the file 'LICENSE' or in the Pods-{yourProjectName}-acknowledgements.markdown
 *
 * This file is included with KFXUtilities
 *
 ************************************/

#import "KFXPhotoPickerManager.h"
@import MobileCoreServices;
@import UIKit.UIImagePickerController;

@interface KFXPhotoPickerManager () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation KFXPhotoPickerManager


//======================================================
#pragma mark - ** Public Methods **
//======================================================
-(void)presentImagePickerFromView:(UIView *)view inViewController:(UIViewController *)viewController{
    
    [self presentImagePickerFromSourceRect:view.bounds inViewController:viewController];
    
}


-(void)presentImagePickerFromSourceRect:(CGRect)sourceRect inViewController:(UIViewController *)viewController{
    
    // If no camera/photo access then return
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]
        && ![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
        return;
    }
    
    // setup action sheet with cancel button
    UIAlertController *alertController =
	[UIAlertController alertControllerWithTitle:NSLocalizedString(@"Choose Photo", @"")
                                        message:@""
                                 preferredStyle:UIAlertControllerStyleActionSheet];
	UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", @"")
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction *action) {
                                                       
                                                   }];
    [alertController addAction:cancelAction];
    
    // configure alertController for iPad
    alertController.popoverPresentationController.sourceView = viewController.view;
    alertController.popoverPresentationController.sourceRect = sourceRect;
    alertController.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    
    
    // Start configuring the Image Picker
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    imagePicker.mediaTypes = @[(NSString*)kUTTypeImage];
    
    // give user option to take new photo
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
		UIAlertAction *takePhoto = [UIAlertAction actionWithTitle:NSLocalizedString(@"Take Photo", @"")
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {
                                                              // Access the camera
                                                              imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                                                              // Present imagePicker
                                                              [viewController presentViewController:imagePicker animated:YES completion:nil];
                                                          }];
        [alertController addAction:takePhoto];
    }
    // give user option to use existing photo
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
        

		UIAlertAction *openPhotos = [UIAlertAction actionWithTitle:NSLocalizedString(@"Open Photo Library", @"")
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction *action) {
                                                               // Access the photos album
                                                               imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                                                               // Present imagePicker
                                                               [viewController presentViewController:imagePicker animated:YES completion:nil];
                                                           }];
        [alertController addAction:openPhotos];
        
    }
    
    // present ActionSheet
    [viewController presentViewController:alertController animated:YES completion:^{
        //xx //xxNSLog(@"Alert sheet presented");
    }];
    
}


//======================================================
#pragma mark - ** Delegates **
//======================================================
//--------------------------------------------------------
#pragma mark - UIImagePickerControllerDelegate
//--------------------------------------------------------
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString*)kUTTypeImage]) {
        
        UIImage *imageEdited = info[UIImagePickerControllerEditedImage];
        if (imageEdited) {
            [self.delegate photoPickerManager:self didSelectImage:imageEdited];
        }else{
            UIImage *imageOriginal = info[UIImagePickerControllerOriginalImage];
            [self.delegate photoPickerManager:self didSelectImage:imageOriginal];
        }
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

@end
