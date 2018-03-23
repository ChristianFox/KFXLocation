
/********************************
 *
 * Copyright © 2016-2018 Christian Fox
 *
 * MIT Licence - Full licence details can be found in the file 'LICENSE' or in the Pods-{yourProjectName}-acknowledgements.markdown
 *
 * This file is included with KFXLocation
 *
 ************************************/



#import "DEMOViewController.h"
#import <KFXLocation/KFXLocation.h>

@interface DEMOViewController ()

@end

@implementation DEMOViewController


-(IBAction)openAppleMapsApp1ButtonTapped:(id)sender{
    
    KFXGeoLocationHelper *helper = [KFXGeoLocationHelper geoLocationHelper];
    CLLocation *location = [[CLLocation alloc]initWithLatitude:51.0 longitude:-2.0];
    [helper openAppleMapsAppWithDirectionsToLocation:location directionsMode:MKLaunchOptionsDirectionsModeTransit completionBlock:^(BOOL success, NSError * _Nullable error) {
        
        if (error != nil) {
            NSLog(@"ERROR: %@",error);
        }
        
    }];
}

-(IBAction)openAppleMapsApp2ButtonTapped:(id)sender{
    
    KFXGeoLocationHelper *helper = [KFXGeoLocationHelper geoLocationHelper];
    CLLocation *location = [[CLLocation alloc]initWithLatitude:51.0 longitude:-2.0];
    NSDictionary *options = @{
                              MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,
                              MKLaunchOptionsMapTypeKey:@3,
                              MKLaunchOptionsShowsTrafficKey:@YES
                              };
    [helper openAppleMapsAppWithDirectionsToLocation:location
                               mapLaunchOptions:options
                                completionBlock:^(BOOL success, NSError * _Nullable error) {
        
        if (error != nil) {
            NSLog(@"ERROR: %@",error);
        }
        
    }];
}


- (IBAction)openGoogleMapsApp1ButtonTapped:(id)sender {
    
    KFXGeoLocationHelper *helper = [KFXGeoLocationHelper geoLocationHelper];
    CLLocation *location = [[CLLocation alloc]initWithLatitude:51.0 longitude:-2.0];
    [helper openGoogleMapsAppWithDirectionsToLocation:location
                                       directionsMode:@"driving"
                                      completionBlock:^(BOOL boolValue) {
                                          NSLog(@"Success %d",boolValue);
                                      }];

}




@end
