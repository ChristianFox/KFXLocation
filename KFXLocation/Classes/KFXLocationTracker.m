/********************************
 *
 * Copyright © 2016-2017 Christian Fox
 * All Rights Reserved
 * Full licence details can be found in the file 'LICENSE' or in the Pods-{yourProjectName}-acknowledgements.markdown
 *
 * This file is included with KFXLocation
 *
 ************************************/


#import "KFXLocationTracker.h"
// Pods
#import <KFXAdditions/NSDate+KFXAdditions.h>
#import <KFXAdditions/CLLocation+KFXAdditions.h>

@interface KFXLocationTracker () <CLLocationManagerDelegate>
@property (copy,nonatomic) KFXLocationAuthorisationBlock authorisationCallback;
@property (copy,nonatomic) KFXLocationUpdatesBlock locationUpdatesCallback;
@end

@implementation KFXLocationTracker


//======================================================
#pragma mark - ** Public Methods **
//======================================================
//--------------------------------------------------------
#pragma mark Initilisers
//--------------------------------------------------------
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+(instancetype)locationTrackerWithDefaults{
    
    KFXLocationTracker *tracker = [self locationTrackerWithDesiredAccuracy:kCLLocationAccuracyHundredMeters
                                                            distanceFilter:100];
    return tracker;
}

+(instancetype)locationTrackerWithDesiredAccuracy:(CLLocationAccuracy)accuracy distanceFilter:(CLLocationDistance)distance{
    
    KFXLocationTracker *tracker = [[KFXLocationTracker alloc]init];
    CLLocationManager  *locationManager = [[CLLocationManager alloc]init];
    locationManager.desiredAccuracy = accuracy;
    locationManager.distanceFilter = distance;
    locationManager.delegate = tracker;
    locationManager.pausesLocationUpdatesAutomatically = YES;
    tracker.locationManager = locationManager;
    tracker.maximumLocationAge = 60.0;
    tracker.minimumHorizontalAccuracy = 200.0;
    return tracker;
}

//--------------------------------------------------------
#pragma mark Inject Dependencies
//--------------------------------------------------------


//======================================================
#pragma mark - ** Primary Public Functionality **
//======================================================
//--------------------------------------------------------
#pragma mark CLLocationManager wrappers
//--------------------------------------------------------
-(void)startUpdatingLocation{
    [self.locationManager startUpdatingLocation];
}

-(void)stopUpdatingLocation{
    [self.locationManager stopUpdatingLocation];
}

-(void)startMonitoringSignificantLocationChanges{
    [self.locationManager startMonitoringSignificantLocationChanges];
}
-(void)stopMonitoringSignificantLocationChanges{
    [self.locationManager stopMonitoringSignificantLocationChanges];
}
-(void)startMonitoringVisits{
    [self.locationManager startMonitoringVisits];
}
-(void)stopMonitoringVisits{
    [self.locationManager stopMonitoringVisits];
}
-(void)startMonitoringForRegion:(CLRegion *)region{
    [self.locationManager startMonitoringForRegion:region];
}
-(void)stopMonitoringForRegion:(CLRegion *)region{
    [self.locationManager stopMonitoringForRegion:region];
}

//--------------------------------------------------------
#pragma mark Blocks based
//--------------------------------------------------------
-(void)requestLocationTrackingAuthorisationWithBlock:(KFXLocationAuthorisationBlock)callbackBlock{
    
    self.authorisationCallback = callbackBlock;
    
    if ([[NSBundle mainBundle]objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"] != nil) {
        if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedAlways) {
            [self.locationManager requestAlwaysAuthorization];
        }else{
            self.authorisationCallback([CLLocationManager authorizationStatus]);
        }
    }else if ([[NSBundle mainBundle]objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"] != nil){
        if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse) {
            [self.locationManager requestWhenInUseAuthorization];
        }else{
            self.authorisationCallback([CLLocationManager authorizationStatus]);
        }
    }
}

-(void)locationUpdatesWithBlock:(KFXLocationUpdatesBlock)callbackBlock{
    
    self.locationUpdatesCallback = callbackBlock;
    [self.locationManager startUpdatingLocation];
}

//--------------------------------------------------------
#pragma mark Helpers
//--------------------------------------------------------
+(NSString*)descriptionForRejectionReason:(KFXLocationRejectionReason)rejectionReason{
    
    NSString *rejectionDescription;
    switch (rejectionReason) {
        case KFXLocationAccepted:{
            rejectionDescription = @"NOT rejected, was accepted";
            break;
        }
        case KFXLocationRejectionReasonUndefined:{
            rejectionDescription = @"Undefined";
            break;
        }
        case KFXLocationRejectionReasonOlderThanLastKnownLocation:{
            rejectionDescription = @"Older than last known location";
            break;
        }
        case KFXLocationRejectionReasonOlderThanMaxAge:{
            rejectionDescription = @"Older than max age";
            break;
        }
        case KFXLocationRejectionReasonLessAccurateThanMinAccuracy:{
            rejectionDescription = @"Less accurate than min accuracy";
            break;
        }
        default:
            NSAssert(NO,@"Hit default case of a switch statement. %s",__PRETTY_FUNCTION__);
            
            break;
    }
    return rejectionDescription;
}

//======================================================
#pragma mark - ** Inherited Methods **
//======================================================




//======================================================
#pragma mark - ** Protocol Methods **
//======================================================
//--------------------------------------------------------
#pragma mark CLLocationManagerDelegate
//--------------------------------------------------------
//-----------------------------------
// Failure
//-----------------------------------
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(nonnull NSError *)error{
    
    if ([self.delegate respondsToSelector:@selector(locationTracker:didFailWithError:)]) {
        [self.delegate locationTracker:self didFailWithError:error];
    }
}

//-----------------------------------
// Location Updates
//-----------------------------------
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    NSMutableArray *acceptedLocations = [NSMutableArray arrayWithCapacity:locations.count];
    for (CLLocation *aLocation in locations) {
        
        KFXLocationRejectionReason reason;
        if (![self isLocationAcceptable:aLocation withRejectionReason:&reason]) {
            
            if ([self.delegate respondsToSelector:@selector(locationTracker:didRejectLocation:forReason:)]) {
                [self.delegate locationTracker:self didRejectLocation:aLocation forReason:reason];
            }
            
        }else{
            self.lastKnownLocation = aLocation;
            [acceptedLocations addObject:aLocation];
        }
    }
    
    if (acceptedLocations.count == 0) {
        return;
    }
    
    // Pass accepted locations to delegate & callback if needed
    if ([self.delegate respondsToSelector:@selector(locationTracker:didUpdateLocations:)]) {
        [self.delegate locationTracker:self didUpdateLocations:[acceptedLocations copy]];
    }
    
    if (self.locationUpdatesCallback != nil) {
        self.locationUpdatesCallback([acceptedLocations copy]);
    }
}

-(void)locationManagerDidPauseLocationUpdates:(CLLocationManager *)manager{
    
    if ([self.delegate respondsToSelector:@selector(locationTrackerDidPauseLocationUpdates:)]) {
        [self.delegate locationTrackerDidPauseLocationUpdates:self];
    }
}

-(void)locationManagerDidResumeLocationUpdates:(CLLocationManager *)manager{
    
    if ([self.delegate respondsToSelector:@selector(locationTrackerDidResumeLocationUpdates:)]) {
        [self.delegate locationTrackerDidResumeLocationUpdates:self];
    }
}


//-----------------------------------
// Region Updates
//-----------------------------------
-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    if ([self.delegate respondsToSelector:@selector(locationTracker:didEnterRegion:)]) {
        [self.delegate locationTracker:self didEnterRegion:region];
    }
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    if ([self.delegate respondsToSelector:@selector(locationTracker:didExitRegion:)]) {
        [self.delegate locationTracker:self didExitRegion:region];
    }
}

-(void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region{
    //    NSLog(@"%s",__PRETTY_FUNCTION__);
    if ([self.delegate respondsToSelector:@selector(locationTracker:didDetermineState:forRegion:)]) {
        [self.delegate locationTracker:self didDetermineState:state forRegion:region];
    }
}

-(void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region{
    //    NSLog(@"%s",__PRETTY_FUNCTION__);
    if ([self.delegate respondsToSelector:@selector(locationTracker:didStartMonitoringForRegion:)]) {
        [self.delegate locationTracker:self didStartMonitoringForRegion:region];
    }
}

-(void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error{
    //    NSLog(@"%s",__PRETTY_FUNCTION__);
    if ([self.delegate respondsToSelector:@selector(locationManager:monitoringDidFailForRegion:withError:)]) {
        [self.delegate locationTracker:self monitoringDidFailForRegion:region withError:error];
    }
}

//-----------------------------------
// Visits
//-----------------------------------
-(void)locationManager:(CLLocationManager *)manager didVisit:(CLVisit *)visit{
    //    NSLog(@"%s",__PRETTY_FUNCTION__);
    if ([self.delegate respondsToSelector:@selector(locationTracker:didVisit:)]) {
        [self.delegate locationTracker:self didVisit:visit];
    }
}

//-----------------------------------
// Authorization
//-----------------------------------
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    
    if (status == kCLAuthorizationStatusNotDetermined) {
        return;
    }
    if ([self.delegate respondsToSelector:@selector(locationTracker:didChangeAuthrizationStatus:)]) {
        [self.delegate locationTracker:self didChangeAuthrizationStatus:status];
    }
    
    if (self.authorisationCallback != nil) {
        self.authorisationCallback(status);
        self.authorisationCallback = nil;
    }
}

//======================================================
#pragma mark - ** Private Methods **
//======================================================
//--------------------------------------------------------
#pragma mark Data Validation
//--------------------------------------------------------
-(BOOL)isLocationAcceptable:(CLLocation*)location withRejectionReason:(KFXLocationRejectionReason*)reason{
    
    // ## Check new location against lastKnownLocation
    if (self.lastKnownLocation == nil) {
        // First location so store incoming
        self.lastKnownLocation = location;
        
    }else if (![location.timestamp kfx_isLaterThanDate:self.lastKnownLocation.timestamp]){
        
        *reason = KFXLocationRejectionReasonOlderThanLastKnownLocation;
        return NO;
    }
    
    // ## Check new location against settings
    if ([location kfx_isStale:self.maximumLocationAge]){
        *reason = KFXLocationRejectionReasonOlderThanMaxAge;
        return NO;
    }else if (![location kfx_isDesiredHorizontalAccuracy:self.minimumHorizontalAccuracy]){
        *reason = KFXLocationRejectionReasonLessAccurateThanMinAccuracy;
        return NO;
    }else{
        *reason = KFXLocationAccepted;
        return YES;
    }
}


//--------------------------------------------------------
#pragma mark Lazy Load
//--------------------------------------------------------



@end


























