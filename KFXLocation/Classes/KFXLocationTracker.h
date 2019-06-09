/********************************
 *
 * Copyright © 2016-2017 Christian Fox
 * All Rights Reserved
 * Full licence details can be found in the file 'LICENSE' or in the Pods-{yourProjectName}-acknowledgements.markdown
 *
 * This file is included with KFXLocation
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
-(void)locationTracker:(KFXLocationTracker*)locationTracker didEnterRegion:(CLRegion *)region;
-(void)locationTracker:(KFXLocationTracker*)locationTracker didExitRegion:(CLRegion *)region;
-(void)locationTracker:(KFXLocationTracker*)locationTracker didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region;
-(void)locationTracker:(KFXLocationTracker*)locationTracker didStartMonitoringForRegion:(CLRegion *)region;
-(void)locationTracker:(KFXLocationTracker*)locationTracker monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error;
-(void)locationTracker:(KFXLocationTracker*)locationTracker didVisit:(CLVisit *)visit;
@end

// # Interface
@interface KFXLocationTracker : NSObject

@property (weak, nonatomic) id<KFXLocationTrackerDelegate> delegate;
// CoreLocation
@property (strong,nonatomic) CLLocationManager *locationManager;
@property (strong,atomic) CLLocation *lastKnownLocation;
// Settings
/// The maximum location age in seconds for a CLLocation. Any locations older than this will be rejected and the -locationTracker:didRejectLocation:forReason: delegate method will be called.
@property (nonatomic) NSTimeInterval maximumLocationAge;
/// The minimum horizontal accuracy in for a CLLocation. Any locations with an accuracy higher than this will be rejected and the -locationTracker:didRejectLocation:forReason: delegate method will be called.
@property (nonatomic) CLLocationAccuracy minimumHorizontalAccuracy;

//--------------------------------------------------------
#pragma mark - Initilisers
//--------------------------------------------------------
/// Initilise an instance
-(instancetype)init;

/// Initilise an instance of KFXLocationTracker with the default values
+(instancetype)locationTrackerWithDefaults;

/// Initilise an instance of KFXLocationTracker with the given desiredAccuracy and distanceFilter
+(instancetype)locationTrackerWithDesiredAccuracy:(CLLocationAccuracy)accuracy
                                   distanceFilter:(CLLocationDistance)distance;

//--------------------------------------------------------
#pragma mark CLLocationManager wrappers
//--------------------------------------------------------
-(void)startUpdatingLocation;
-(void)stopUpdatingLocation;
-(void)startMonitoringSignificantLocationChanges;
-(void)stopMonitoringSignificantLocationChanges;
-(void)startMonitoringVisits;
-(void)stopMonitoringVisits;
-(void)startMonitoringForRegion:(CLRegion *)region;
-(void)stopMonitoringForRegion:(CLRegion *)region;

//--------------------------------------------------------
#pragma mark Blocks based API
//--------------------------------------------------------
/**
 * @brief Request the user's authorisation to access the device's location
 * @param callbackBlock  A block object to be executed when the operation completes. This block has no return value and takes 1 argument: a CLAuthorizationStatus value
 **/
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
/// Returns an NSString description of the KFXLocationRejectionReason enum value
+(NSString*)descriptionForRejectionReason:(KFXLocationRejectionReason)rejectionReason;


@end

