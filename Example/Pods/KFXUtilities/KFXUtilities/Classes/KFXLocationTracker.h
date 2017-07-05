/********************************
 *
 * Copyright © 2016-2017 Christian Fox
 * All Rights Reserved
 * Full licence details can be found in the file 'LICENSE' or in the Pods-{yourProjectName}-acknowledgements.markdown
 *
 * This file is included with KFXUtilities
 *
 ************************************/

// # Imports
// Cocoa Frameworks
@import Foundation;
@import CoreLocation;

// # Enums
typedef NS_ENUM(NSInteger, KFXLocationRejectionReason) {
	KFXLocationAccepted = -1,
	KFXLocationRejectionReasonUndefined = 0,
	KFXLocationRejectionReasonOlderThanLastKnownLocation,
	KFXLocationRejectionReasonOlderThanMaxAge,
	KFXLocationRejectionReasonLessAccurateThanMinAccuracy,
};

// # Block defintions
typedef void(^KFXLocationAuthorisationBlock)(CLAuthorizationStatus status);
typedef void(^KFXLocationUpdatesBlock)(NSArray<CLLocation*> *locations);

// # Delegate
@class KFXLocationTracker;
@protocol KFXLocationTrackerDelegate <NSObject>
@optional
-(void)locationTracker:(KFXLocationTracker*)locationTracker didUpdateLocations:(NSArray<CLLocation*>*)locations;
-(void)locationTracker:(KFXLocationTracker*)locationTracker didFailWithError:(NSError*)error;
-(void)locationTracker:(KFXLocationTracker*)locationTracker didRejectLocation:(CLLocation*)location forReason:(KFXLocationRejectionReason)reason;
-(void)locationTrackerDidPauseLocationUpdates:(KFXLocationTracker*)tracker;
-(void)locationTrackerDidResumeLocationUpdates:(KFXLocationTracker*)tracker;
-(void)locationTracker:(KFXLocationTracker*)locationTracker didChangeAuthrizationStatus:(CLAuthorizationStatus)status;

@end

// # Interface
@interface KFXLocationTracker : NSObject

@property (weak, nonatomic) id<KFXLocationTrackerDelegate> delegate;
// CoreLocation
@property (strong,nonatomic) CLLocationManager *locationManager;
@property (strong,atomic) CLLocation *lastKnownLocation;
// Settings
@property (nonatomic) NSTimeInterval maximumLocationAge;
@property (nonatomic) CLLocationAccuracy minimumHorizontalAccuracy;

//--------------------------------------------------------
#pragma mark - Initilisers
//--------------------------------------------------------
-(instancetype)init;
+(instancetype)locationTrackerWithDefaults;
+(instancetype)locationTrackerWithDesiredAccuracy:(CLLocationAccuracy)accuracy
								   distanceFilter:(CLLocationDistance)distance;

//--------------------------------------------------------
#pragma mark Blocks based API
//--------------------------------------------------------
-(void)requestLocationTrackingAuthorisationWithBlock:(KFXLocationAuthorisationBlock)callbackBlock;

/**
 * Block based API to receive location updates. Will receive same data as conforming to locationTracker:didUpdateLocations:
 * @warning The block is stored as a single private property, as such there can be only one object receiving location updates in this fashion.
 * @param callbackBlock the block to execute anytime there are locations to share
 **/
-(void)locationUpdatesWithBlock:(KFXLocationUpdatesBlock)callbackBlock;

//--------------------------------------------------------
#pragma mark Helpers
//--------------------------------------------------------
+(NSString*)descriptionForRejectionReason:(KFXLocationRejectionReason)rejectionReason;


@end
