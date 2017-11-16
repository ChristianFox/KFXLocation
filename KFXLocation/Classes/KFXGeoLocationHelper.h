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
/// Initilise an instance of KFXGeoLocationHelper
+(instancetype)geoLocationHelper;


//--------------------------------------------------------
#pragma mark - Coordinates
//--------------------------------------------------------
/**
 * @brief Create a new CLLocationCoordinate2D by adjusting the given coordinates
 * @param originalCoordinates The original coordinates to add the adjustments to
 * @param latitudeAdjustment The latitude in degrees to adjust the originalCoordinates by
 * @param longitudeAdjustment The longitude in degrees to adjust the originalCoordinates by
 * @return A new CLLocationCoordinate2D. If any of the combined values are invalid then the constant kCLLocationCoordinate2DInvalid will be returned.
 **/
-(CLLocationCoordinate2D)coordinatesFromCoordinates:(CLLocationCoordinate2D)originalCoordinates
                    withLatitudeAdjustmentByDegrees:(CLLocationDegrees)latitudeAdjustment
                       longitudeAdjustmentByDegrees:(CLLocationDegrees)longitudeAdjustment;

/**
 * @brief Create a new CLLocationCoordinate2D by adjusting the given coordinates
 * @param originalCoordinates The original coordinates to add the adjustments to
 * @param latitudeAdjustment The latitude in metres to adjust the originalCoordinates by
 * @param longitudeAdjustment The longitude in metres to adjust the originalCoordinates by
 * @return A new CLLocationCoordinate2D. If any of the combined values are invalid then the constant kCLLocationCoordinate2DInvalid will be returned.
 **/
-(CLLocationCoordinate2D)coordinatesFromCoordinates:(CLLocationCoordinate2D)originalCoordinates
                     withLatitudeAdjustmentByMetres:(double)latitudeAdjustment
                        longitudeAdjustmentByMetres:(double)longitudeAdjustment;

//--------------------------------------------------------
#pragma mark - Data from an NSArray of CLLocations
//--------------------------------------------------------
#pragma mark Distance
/**
 * @brief Calculate the total distance when combining the distances between the locations in the array
 * @param locations An array of CLLocations objects as points on a journey
 * @return The total CLLocationDistance between all locations
 **/
-(CLLocationDistance)totalDistanceFromLocations:(NSArray<CLLocation*>*)locations;

/**
 * @brief Calculate the shortest distance between any two locations in an array of CLLocations
 * @param locations An array of CLLocations objects.
 * @return The shortest CLLocationDistance between all locations
 **/
-(CLLocationDistance)shortestDistanceBetweenTwoLocationsFromLocations:(NSArray<CLLocation*>*)locations;

/**
 * @brief Calculate the longest distance between any two locations in an array of CLLocations
 * @param locations An array of CLLocations objects.
 * @return The longest CLLocationDistance between all locations
 **/
-(CLLocationDistance)longestDistanceBetweenTwoLocationsFromLocations:(NSArray<CLLocation*>*)locations;

/**
 * @brief Calculate the distance between two coordinates
 * @param coordA The first coordinate of the two
 * @param coordB The second coordinate of the two
 * @return The distance between coordinates
 **/
-(CLLocationDistance)distanceBetweenCoordinate:(CLLocationCoordinate2D)coordA andCoordinate:(CLLocationCoordinate2D)coordB;

#pragma mark Average Speed
/**
 * @brief Read the speed property of each CLLocation and determine the average of all
 * @param locations An array of CLLocations objects.
 * @return The average speed
 **/
-(CLLocationSpeed)averageSpeedReadFromLocations:(NSArray<CLLocation*>*)locations;

/**
 * @brief Calculate the average speed between locations after sorting chronologically
 * @param locations An array of CLLocations objects.
 * @return The average speed
 **/
-(CLLocationSpeed)averageSpeedCalculatedFromLocations:(NSArray<CLLocation*>*)locations;

#pragma mark Speed Between Locations
/**
 * @brief Calculate the speed between two locations
 * @param locationA a CLLocation
 * @param locationB a CLLocation
 * @return The CLLocationSpeed between the two locations
 **/
-(CLLocationSpeed)speedBetweenLocation:(CLLocation*)locationA andLocation:(CLLocation*)locationB;

/**
 * @brief Calculate the speed between all the locations after sorting chronologically
 * @param locations An array of CLLocations objects.
 * @return An array of NSNumbers where each number is the speed between two locations
 **/
-(NSArray<NSNumber*>*)speedsBetweenLocations:(NSArray<CLLocation*>*)locations;

/**
 * @brief Calculate the slowest speed between any two of all the locations after sorting chronologically
 * @param locations An array of CLLocations objects.
 * @return The slowest speed between any two locations
 **/
-(CLLocationSpeed)slowestSpeedBetweenTwoLocationsFromLocations:(NSArray<CLLocation*>*)locations;

/**
 * @brief Calculate the fastest speed between any two of all the locations after sorting chronologically
 * @param locations An array of CLLocations objects.
 * @return The fastest speed between any two locations
 **/
-(CLLocationSpeed)fastestSpeedBetweenTwoLocationsFromLocations:(NSArray<CLLocation*>*)locations;

#pragma mark Regions
/**
 * @brief Calculate the time spent in a region. This value is calculated by determining which of the locations are present in the region and using the timestamps to determine the time spent.
 * @param region The CLCircularRegion in question
 * @param locations An array of CLLocations objects.
 * @return The fastest speed between any two locations
 **/
-(NSTimeInterval)timeSpentInCircularRegion:(CLCircularRegion*)region
                             withLocations:(NSArray<CLLocation*>*)locations;


//--------------------------------------------------------
#pragma mark - Sorting Arrays of Locations
//--------------------------------------------------------
/**
 * @brief Sort an array of locations chronologically by time stamp
 * @param locations An array of CLLocations objects.
 * @param ascending YES if the locations should be ordered from low to high, NO if high to low
 * @return An array of CLLocations sorted by time stamp
 **/
-(NSArray<CLLocation*>*)sortLocationsChronologically:(NSArray<CLLocation*>*)locations
                                           ascending:(BOOL)ascending;

/**
 * @brief Sort an array of locations by distance to another location
 * @param locations An array of CLLocations objects.
 * @param theLocation The CLLocation to compare the other locations too
 * @param ascending YES if the locations should be ordered from low to high, NO if high to low
 * @return An array of CLLocations sorted by distance
 **/
-(NSArray<CLLocation*>*)sortLocations:(NSArray<CLLocation*>*)locations
                 byDistanceToLocation:(CLLocation*)theLocation
                            ascending:(BOOL)ascending;

/**
 * @brief Sort an array of objects with a CLLocation properry by distance to another location
 * @param key The key for the location property
 * @param theLocation The CLLocation to compare the other locations too
 * @param ascending YES if the locations should be ordered from low to high, NO if high to low
 * @return An array of objects sorted by distance
 **/
-(NSArray<id> *)sortObjects:(NSArray<id> *)objects
            withLocationKey:(NSString *)key
       byDistanceToLocation:(CLLocation *)theLocation
                  ascending:(BOOL)ascending;

/**
 * @brief Sort an array of objects with a CLLocation properry by distance to another location
 * @param key The key for the location property
 * @param theLocation The CLLocation to compare the other locations too
 * @param ascending YES if the locations should be ordered from low to high, NO if high to low
 * @param distances A pointer to an array of NSNumbers, each number represents the distance between the object at the same index and theLocation distance.
 * @return An array of objects sorted by distance
 **/
-(NSArray<id> *)sortObjects:(NSArray<id> *)objects
            withLocationKey:(NSString *)key
       byDistanceToLocation:(CLLocation *)theLocation
                  ascending:(BOOL)ascending
                  distances:(NSArray<NSNumber*>*__autoreleasing  _Nonnull*_Nonnull)distances;



@end
NS_ASSUME_NONNULL_END













