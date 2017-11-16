/********************************
 *
 * Copyright © 2016-2017 Christian Fox
 * All Rights Reserved
 * Full licence details can be found in the file 'LICENSE' or in the Pods-{yourProjectName}-acknowledgements.markdown
 *
 * This file is included with KFXLocation
 *
 ************************************/

#import "KFXGeoLocationHelper.h"
#import <KFXCore/KFXCore.h>

@implementation KFXGeoLocationHelper

//--------------------------------------------------------
#pragma mark - Initilisers
//--------------------------------------------------------
+(instancetype)geoLocationHelper{
    
    KFXGeoLocationHelper *helper = [[self alloc]init];
    return helper;
}


//--------------------------------------------------------
#pragma mark - Coordinates
//--------------------------------------------------------
-(CLLocationCoordinate2D)coordinatesFromCoordinates:(CLLocationCoordinate2D)originalCoordinates
                    withLatitudeAdjustmentByDegrees:(CLLocationDegrees)latitudeAdjustment
                       longitudeAdjustmentByDegrees:(CLLocationDegrees)longitudeAdjustment{
    
    if (!CLLocationCoordinate2DIsValid(originalCoordinates)) {
        return kCLLocationCoordinate2DInvalid;
    }
    CLLocationDegrees newLat = originalCoordinates.latitude + latitudeAdjustment;
    CLLocationDegrees newLong = originalCoordinates.longitude + longitudeAdjustment;
    if (newLat > 90.000000000000 || newLat < -90.000000000000) {
        return kCLLocationCoordinate2DInvalid;
    }else if (newLong > 180.000000000000 || newLong < -180.000000000000){
        return kCLLocationCoordinate2DInvalid;
    }
    
    return CLLocationCoordinate2DMake(newLat, newLong);
}

-(CLLocationCoordinate2D)coordinatesFromCoordinates:(CLLocationCoordinate2D)originalCoordinates
                     withLatitudeAdjustmentByMetres:(double)latitudeAdjustment
                        longitudeAdjustmentByMetres:(double)longitudeAdjustment{
    
    CLLocationDegrees latDegrees = latitudeAdjustment * kDegreesPerMetreLatitude;
    CLLocationDegrees longDegrees = longitudeAdjustment * kDegreesPerMetreLongitude;
    return [self coordinatesFromCoordinates:originalCoordinates
            withLatitudeAdjustmentByDegrees:latDegrees
               longitudeAdjustmentByDegrees:longDegrees];
}


//--------------------------------------------------------
#pragma mark - Data from an NSArray of CLLocations
//--------------------------------------------------------
#pragma mark Distance
-(CLLocationDistance)totalDistanceFromLocations:(NSArray<CLLocation*>*)locations{
    
    if (locations.count < 2) {
        return 0.0;
    }
    
    NSArray <CLLocation*>*sortedLocations = [self sortLocationsChronologically:locations
                                                                     ascending:YES];
    
    CLLocationDistance totalDistance = 0.0;
    for (NSInteger idx = 1; idx < locations.count; idx++) {
        
        CLLocation *locationA = sortedLocations[idx-1];
        CLLocation *locationB = sortedLocations[idx];
        CLLocationDistance distance = [locationA distanceFromLocation:locationB];
        totalDistance += distance;
    }
    return totalDistance;
}



-(CLLocationDistance)shortestDistanceBetweenTwoLocationsFromLocations:(NSArray<CLLocation*>*)locations{
    
    if (locations.count < 2) {
        return 0.0;
    }
    
    NSMutableArray<NSNumber*> *shortDistances = [NSMutableArray arrayWithCapacity:locations.count];
    for (CLLocation *aLocation in locations) {
        
        NSMutableArray<CLLocation*> *otherLocations = [locations mutableCopy];
        [otherLocations removeObject:aLocation];
        NSArray<CLLocation*> *sortedLocations = [self sortLocations:otherLocations
                                               byDistanceToLocation:aLocation
                                                          ascending:YES];
        CLLocationDistance shortestDistance = [aLocation distanceFromLocation:sortedLocations.firstObject];
        [shortDistances addObject:@(shortestDistance)];
    }
    
    NSArray<NSNumber*> *sortedDistances = [shortDistances sortedArrayUsingSelector:@selector(compare:)];
    return [sortedDistances.firstObject doubleValue];
}

-(CLLocationDistance)longestDistanceBetweenTwoLocationsFromLocations:(NSArray<CLLocation*>*)locations{
    
    if (locations.count < 2) {
        return 0.0;
    }
    
    NSMutableArray<NSNumber*> *longDistances = [NSMutableArray arrayWithCapacity:locations.count];
    for (CLLocation *aLocation in locations) {
        
        NSMutableArray<CLLocation*> *otherLocations = [locations mutableCopy];
        [otherLocations removeObject:aLocation];
        NSArray<CLLocation*> *sortedLocations = [self sortLocations:otherLocations
                                               byDistanceToLocation:aLocation
                                                          ascending:YES];
        CLLocationDistance longestDistance = [aLocation distanceFromLocation:sortedLocations.lastObject];
        [longDistances addObject:@(longestDistance)];
    }
    
    NSArray<NSNumber*> *sortedDistances = [longDistances sortedArrayUsingSelector:@selector(compare:)];
    return [sortedDistances.lastObject doubleValue];
}

-(CLLocationDistance)distanceBetweenCoordinate:(CLLocationCoordinate2D)coordA andCoordinate:(CLLocationCoordinate2D)coordB{
    
    /*
     From
     //  CLLocation+measuring.h
     //  StreetWise
     //
     //  Created by Rotem Rubnov on 4/5/2011.
     //  Copyright 2011 100 grams. All rights reserved.
     // https://github.com/100grams/CoreLocationUtils
     */
    double earthRadius = 6371.01; // Earth's radius in Kilometers
    
    // Get the difference between our two points then convert the difference into radians
    double nDLat = (coordA.latitude - coordB.latitude) * kDegreesToRadians;
    double nDLon = (coordA.longitude - coordB.longitude) * kDegreesToRadians;
    
    double fromLat =  coordB.latitude * kDegreesToRadians;
    double toLat =  coordA.latitude * kDegreesToRadians;
    
    double nA =	pow ( sin(nDLat/2), 2 ) + cos(fromLat) * cos(toLat) * pow ( sin(nDLon/2), 2 );
    
    double nC = 2 * atan2( sqrt(nA), sqrt( 1 - nA ));
    double nD = earthRadius * nC;
    
    return nD * 1000; // Return our calculated distance in meters
    
}


#pragma mark Average Speed
-(CLLocationSpeed)averageSpeedReadFromLocations:(NSArray<CLLocation*>*)locations{
    
    if (locations.count < 2) {
        return 0.0;
    }
    
    CLLocationSpeed totalSpeed = 0.0;
    NSUInteger counted = 0;
    for (CLLocation *aLocation in locations) {
        CLLocationSpeed speed = aLocation.speed;
        if (speed >= 0.0) {
            totalSpeed += speed;
            counted++;
        }
    }
    if (counted == 0) {
        return 0.0;
    }
    return totalSpeed / counted;
}

-(CLLocationSpeed)averageSpeedCalculatedFromLocations:(NSArray<CLLocation*>*)locations{
    
    if (locations.count < 2) {
        return 0.0;
    }
    
    NSArray <CLLocation*>*sortedLocations = [self sortLocationsChronologically:locations
                                                                     ascending:YES];
    NSTimeInterval totalTime = [sortedLocations.lastObject.timestamp timeIntervalSinceDate:sortedLocations.firstObject.timestamp];
    CLLocationDistance totalDistance = [self totalDistanceFromLocations:sortedLocations];
    if (totalDistance <= 0.0) {
        return 0.0;
    }
    CLLocationSpeed totalSpeed = totalDistance / totalTime;
    return totalSpeed;
}


#pragma mark Speed Between Locations
-(CLLocationSpeed)speedBetweenLocation:(CLLocation *)locationA
                           andLocation:(CLLocation *)locationB{
    
    if (locationA == nil || locationB == nil) {
        return 0.0;
    }
    
    CLLocationDistance distance = [locationA distanceFromLocation:locationB];
    NSTimeInterval time = [locationA.timestamp timeIntervalSinceDate:locationB.timestamp];
    if (time < 0.0) {
        time = -time;
    }
    CLLocationSpeed speed = distance / time;
    return speed;
}

-(NSArray<NSNumber *> *)speedsBetweenLocations:(NSArray<CLLocation *> *)locations{
    
    if (locations.count < 2) {
        return nil;
    }
    
    NSArray<CLLocation*>*sortedLocations = [self sortLocationsChronologically:locations ascending:YES];
    NSMutableArray<NSNumber*> *mutArray = [NSMutableArray arrayWithCapacity:sortedLocations.count];
    
    for (NSInteger idx = 1; idx < sortedLocations.count ; idx++) {
        
        CLLocation *locationA = sortedLocations[idx-1];
        CLLocation *locationB = sortedLocations[idx];
        CLLocationSpeed speed = [self speedBetweenLocation:locationA
                                               andLocation:locationB];
        [mutArray addObject:@(speed)];
    }
    
    return [mutArray copy];
}

-(CLLocationSpeed)slowestSpeedBetweenTwoLocationsFromLocations:(NSArray<CLLocation *> *)locations{
    
    if (locations.count < 2) {
        return 0.0;
    }
    
    NSArray<NSNumber*> *speeds = [self speedsBetweenLocations:locations];
    NSArray<NSNumber*> *sortedSpeeds = [speeds sortedArrayUsingSelector:@selector(compare:)];
    return [sortedSpeeds.firstObject doubleValue];
    
}

-(CLLocationSpeed)fastestSpeedBetweenTwoLocationsFromLocations:(NSArray<CLLocation *> *)locations{
    
    if (locations.count < 2) {
        return 0.0;
    }
    
    NSArray<NSNumber*> *speeds = [self speedsBetweenLocations:locations];
    NSArray<NSNumber*> *sortedSpeeds = [speeds sortedArrayUsingSelector:@selector(compare:)];
    return [sortedSpeeds.lastObject doubleValue];
    
}



#pragma mark Regions
-(NSTimeInterval)timeSpentInCircularRegion:(CLCircularRegion*)region
                             withLocations:(NSArray<CLLocation*>*)locations{
    
    if (locations.count == 0 || region == nil) {
        return 0.0;
    }
    
    NSArray<CLLocation*> *sortedLocations = [self sortLocationsChronologically:locations
                                                                     ascending:YES];
    // Find all locations that are withing the region
    NSMutableArray<CLLocation*> *locationsInRegion = [NSMutableArray arrayWithCapacity:sortedLocations.count];
    
    for (CLLocation *aLocation in sortedLocations) {
        
        if (![region containsCoordinate:aLocation.coordinate]) {
            continue;
        }else{
            // This location is within the region so store it in the array
            [locationsInRegion addObject:aLocation];
        }
    }
    
    // If only one location was in the region then we cannot determine the time so return 0.0
    if (locationsInRegion.count == 1) {
        return 0.0;
    }
    // Now we have all the locations that are within the region we can determine how long was spent within the region. Locations should be in chronological order any way so we can just take the first and last to determine time interval.
    NSTimeInterval timeSpent = [locationsInRegion.lastObject.timestamp timeIntervalSinceDate:locationsInRegion.firstObject.timestamp];
    return timeSpent;   
}


//--------------------------------------------------------
#pragma mark - Sorting Arrays of Locations
//--------------------------------------------------------
-(NSArray<CLLocation*>*)sortLocationsChronologically:(NSArray<CLLocation*>*)locations
                                           ascending:(BOOL)ascending{
    
    NSSortDescriptor *sorter = [NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:ascending];
    NSArray <CLLocation*>*sortedLocations = [locations sortedArrayUsingDescriptors:@[sorter]];
    return sortedLocations;
}

-(NSArray<CLLocation*>*)sortLocations:(NSArray<CLLocation*>*)locations
                 byDistanceToLocation:(CLLocation*)theLocation
                            ascending:(BOOL)ascending{
    
    NSArray *sorted = [locations sortedArrayUsingComparator:^NSComparisonResult(CLLocation*_Nonnull loc1, CLLocation*_Nonnull loc2) {
        
        double dist1 = [theLocation distanceFromLocation:loc1];
        double dist2 = [theLocation distanceFromLocation:loc2];
        
        if ( dist1 < dist2 ) {
            return (NSComparisonResult)NSOrderedAscending;
        } else if ( dist1 > dist2) {
            return (NSComparisonResult)NSOrderedDescending;
        } else {
            return (NSComparisonResult)NSOrderedSame;
        }
    }];
    
    if (!ascending) {
        sorted = [[sorted reverseObjectEnumerator]allObjects];
    }
    return sorted;
}

-(NSArray<id> *)sortObjects:(NSArray<id> *)objects
            withLocationKey:(NSString *)key
       byDistanceToLocation:(CLLocation *)theLocation
                  ascending:(BOOL)ascending{
	
	
	NSArray *sorted = [objects sortedArrayUsingComparator:^NSComparisonResult(id _Nonnull obj1, id _Nonnull obj2) {
		
		double dist1 = [theLocation distanceFromLocation:[obj1 valueForKey:key]];
		double dist2 = [theLocation distanceFromLocation:[obj2 valueForKey:key]];
		
		if ( dist1 < dist2 ) {
			return (NSComparisonResult)NSOrderedAscending;
		} else if ( dist1 > dist2) {
			return (NSComparisonResult)NSOrderedDescending;
		} else {
			return (NSComparisonResult)NSOrderedSame;
		}
	}];
	
	if (!ascending) {
		sorted = [[sorted reverseObjectEnumerator]allObjects];
	}
	return sorted;
	
	
}

-(NSArray<id> *)sortObjects:(NSArray<id> *)objects
            withLocationKey:(NSString *)key
       byDistanceToLocation:(CLLocation *)theLocation
                  ascending:(BOOL)ascending
                  distances:(NSArray<NSNumber *> *__autoreleasing  _Nonnull *)distances{
    
    NSArray *sorted = [self sortObjects:objects
                        withLocationKey:key
                   byDistanceToLocation:theLocation
                              ascending:ascending];
    if (distances != nil) {
        
        NSMutableArray *mutArray = [NSMutableArray arrayWithCapacity:sorted.count];
        for (id anObj in sorted) {
            
            double dist = [theLocation distanceFromLocation:[anObj valueForKey:key]];
            [mutArray addObject:@(dist)];

        }
        *distances = [mutArray copy];
    }
    return sorted;
}



@end











