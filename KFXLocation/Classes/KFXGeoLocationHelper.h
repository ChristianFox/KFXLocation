/********************************
 *
 * Copyright © 2016-2017 Christian Fox
 * All Rights Reserved
 * Full licence details can be found in the file 'LICENSE' or in the Pods-{yourProjectName}-acknowledgements.markdown
 *
 * This file is included with KFXLocation
 *
 ************************************/

#import <Foundation/Foundation.h>
@import CoreLocation;

NS_ASSUME_NONNULL_BEGIN
@interface KFXGeoLocationHelper : NSObject

//--------------------------------------------------------
#pragma mark - Initilisers
//--------------------------------------------------------
+(instancetype)geoLocationHelper;


//--------------------------------------------------------
#pragma mark - Coordinates
//--------------------------------------------------------
-(CLLocationCoordinate2D)coordinatesFromCoordinates:(CLLocationCoordinate2D)originalCoordinates
                    withLatitudeAdjustmentByDegrees:(CLLocationDegrees)latitudeAdjustment
                       longitudeAdjustmentByDegrees:(CLLocationDegrees)longitudeAdjustment;
-(CLLocationCoordinate2D)coordinatesFromCoordinates:(CLLocationCoordinate2D)originalCoordinates
                     withLatitudeAdjustmentByMetres:(double)latitudeAdjustment
                        longitudeAdjustmentByMetres:(double)longitudeAdjustment;

//--------------------------------------------------------
#pragma mark - Data from an NSArray of CLLocations
//--------------------------------------------------------
#pragma mark Distance
-(CLLocationDistance)totalDistanceFromLocations:(NSArray<CLLocation*>*)locations;
-(CLLocationDistance)shortestDistanceBetweenTwoLocationsFromLocations:(NSArray<CLLocation*>*)locations;
-(CLLocationDistance)longestDistanceBetweenTwoLocationsFromLocations:(NSArray<CLLocation*>*)locations;
-(CLLocationDistance)distanceBetweenCoordinate:(CLLocationCoordinate2D)coordA andCoordinate:(CLLocationCoordinate2D)coordB;

#pragma mark Average Speed
-(CLLocationSpeed)averageSpeedReadFromLocations:(NSArray<CLLocation*>*)locations;
-(CLLocationSpeed)averageSpeedCalculatedFromLocations:(NSArray<CLLocation*>*)locations;

#pragma mark Speed Between Locations
-(CLLocationSpeed)speedBetweenLocation:(CLLocation*)locationA andLocation:(CLLocation*)locationB;
-(NSArray<NSNumber*>*)speedsBetweenLocations:(NSArray<CLLocation*>*)locations;
-(CLLocationSpeed)slowestSpeedBetweenTwoLocationsFromLocations:(NSArray<CLLocation*>*)locations;
-(CLLocationSpeed)fastestSpeedBetweenTwoLocationsFromLocations:(NSArray<CLLocation*>*)locations;

#pragma mark Regions
-(NSTimeInterval)timeSpentInCircularRegion:(CLCircularRegion*)region
                             withLocations:(NSArray<CLLocation*>*)locations;

//--------------------------------------------------------
#pragma mark - Sorting Arrays of Locations
//--------------------------------------------------------
-(NSArray<CLLocation*>*)sortLocationsChronologically:(NSArray<CLLocation*>*)locations
                                           ascending:(BOOL)ascending;

-(NSArray<CLLocation*>*)sortLocations:(NSArray<CLLocation*>*)locations
                 byDistanceToLocation:(CLLocation*)theLocation
                            ascending:(BOOL)ascending;
-(NSArray<id> *)sortObjects:(NSArray<id> *)objects
            withLocationKey:(NSString *)key
       byDistanceToLocation:(CLLocation *)theLocation
                  ascending:(BOOL)ascending;
-(NSArray<id> *)sortObjects:(NSArray<id> *)objects
            withLocationKey:(NSString *)key
       byDistanceToLocation:(CLLocation *)theLocation
                  ascending:(BOOL)ascending
                  distances:(NSArray<NSNumber*>*__autoreleasing  _Nonnull*_Nonnull)distances;
@end
NS_ASSUME_NONNULL_END
