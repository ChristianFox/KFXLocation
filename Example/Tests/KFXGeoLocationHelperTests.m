


#import <XCTest/XCTest.h>
#import <KFXLocation/KFXGeoLocationHelper.h>
#import <KFXUtilities/KFXMaths.h>
#import <KFXCore/KFXCommonConstants.h>

@interface KFXGeoLocationHelperTests : XCTestCase
@property (strong,nonatomic) KFXGeoLocationHelper *sut;
@end

@implementation KFXGeoLocationHelperTests

- (void)setUp {
    [super setUp];
    self.sut = [KFXGeoLocationHelper geoLocationHelper];
}

- (void)tearDown {
    self.sut = nil;
    [super tearDown];
}


//--------------------------------------------------------
#pragma mark - Test Initiliser
//--------------------------------------------------------
-(void)testGeoLocationHelperConvienenceInitiliser{
    XCTAssertNotNil(self.sut);
}

//======================================================
#pragma mark - ** Coordinates **
//======================================================
//--------------------------------------------------------
#pragma mark - -coordinatesFromCoordinates:withLatitudeAdjustmentByDegrees:
//--------------------------------------------------------
-(void)testCoordinatesWithDegreesAdjustment_WithInvalidCoordinates_ShouldReturnInvalid{
    
    CLLocationCoordinate2D originalCoord = kCLLocationCoordinate2DInvalid;
    CLLocationDegrees latAdjust = 10.0;
    CLLocationDegrees longAdjust = 10.0;
    CLLocationCoordinate2D newCoord = [self.sut coordinatesFromCoordinates:originalCoord
                                           withLatitudeAdjustmentByDegrees:latAdjust
                                              longitudeAdjustmentByDegrees:longAdjust];
    XCTAssertFalse(CLLocationCoordinate2DIsValid(newCoord));
}

-(void)testCoordinatesWithDegreesAdjustment_WithInvalidLatitude_ShouldReturnInvalid{
    
    CLLocationCoordinate2D originalCoord = CLLocationCoordinate2DMake(0.0, 0.0);
    CLLocationDegrees latAdjust = 100.0;
    CLLocationDegrees longAdjust = 10.0;
    CLLocationCoordinate2D newCoord = [self.sut coordinatesFromCoordinates:originalCoord
                                           withLatitudeAdjustmentByDegrees:latAdjust
                                              longitudeAdjustmentByDegrees:longAdjust];
    XCTAssertFalse(CLLocationCoordinate2DIsValid(newCoord));
}

-(void)testCoordinatesWithDegreesAdjustment_WithInvalidLongitiude_ShouldReturnInvalid{
    
    CLLocationCoordinate2D originalCoord = CLLocationCoordinate2DMake(0.0, 0.0);
    CLLocationDegrees latAdjust = 10.0;
    CLLocationDegrees longAdjust = 181.0;
    CLLocationCoordinate2D newCoord = [self.sut coordinatesFromCoordinates:originalCoord
                                           withLatitudeAdjustmentByDegrees:latAdjust
                                              longitudeAdjustmentByDegrees:longAdjust];
    XCTAssertFalse(CLLocationCoordinate2DIsValid(newCoord));
}

-(void)testCoordinatesWithDegreesAdjustment_WithValidPositiveArguments_ShouldReturnValidCoordinates{
    
    CLLocationCoordinate2D originalCoord = CLLocationCoordinate2DMake(0.0, 0.0);
    CLLocationDegrees latAdjust = 90.000;
    CLLocationDegrees longAdjust = 180.0000;
    CLLocationCoordinate2D newCoord = [self.sut coordinatesFromCoordinates:originalCoord
                                           withLatitudeAdjustmentByDegrees:latAdjust
                                              longitudeAdjustmentByDegrees:longAdjust];
    XCTAssertTrue(CLLocationCoordinate2DIsValid(newCoord));
}

-(void)testCoordinatesWithDegreesAdjustment_WithValidNegativeArguments_ShouldReturnValidCoordinates{
    
    CLLocationCoordinate2D originalCoord = CLLocationCoordinate2DMake(0.0, 0.0);
    CLLocationDegrees latAdjust = -90.000;
    CLLocationDegrees longAdjust = -180.0000;
    CLLocationCoordinate2D newCoord = [self.sut coordinatesFromCoordinates:originalCoord
                                           withLatitudeAdjustmentByDegrees:latAdjust
                                              longitudeAdjustmentByDegrees:longAdjust];
    XCTAssertTrue(CLLocationCoordinate2DIsValid(newCoord));
}






//--------------------------------------------------------
#pragma mark - -coordinatesFromCoordinates:withLatitudeAdjustmentByMetres:
//--------------------------------------------------------
-(void)testCoordinatesWithMetresAdjustment_WithInvalidCoordinates_ShouldReturnInvalid{
    
    CLLocationCoordinate2D originalCoord = kCLLocationCoordinate2DInvalid;
    double latAdjust = 100.0;
    double longAdjust = 100.0;
    CLLocationCoordinate2D newCoord = [self.sut coordinatesFromCoordinates:originalCoord
                                           withLatitudeAdjustmentByMetres:latAdjust
                                              longitudeAdjustmentByMetres:longAdjust];
    XCTAssertFalse(CLLocationCoordinate2DIsValid(newCoord));
}

-(void)testCoordinatesWithMetresAdjustment_WithInvalidLatitude_ShouldReturnInvalid{
    
    CLLocationCoordinate2D originalCoord = CLLocationCoordinate2DMake(0.0, 0.0);
    double latAdjust = 90.1*KFXCOREMetresPerDegreeLatitude;
    double longAdjust = 100.0;
    CLLocationCoordinate2D newCoord = [self.sut coordinatesFromCoordinates:originalCoord
                                            withLatitudeAdjustmentByMetres:latAdjust
                                               longitudeAdjustmentByMetres:longAdjust];
    XCTAssertFalse(CLLocationCoordinate2DIsValid(newCoord));
}

-(void)testCoordinatesWithMetresAdjustment_WithInvalidLongitude_ShouldReturnInvalid{
    
    CLLocationCoordinate2D originalCoord = CLLocationCoordinate2DMake(0.0, 0.0);
    double latAdjust = 10.0;
    double longAdjust = 180.1*KFXCOREMetresPerDegreeLongitude;
    CLLocationCoordinate2D newCoord = [self.sut coordinatesFromCoordinates:originalCoord
                                            withLatitudeAdjustmentByMetres:latAdjust
                                               longitudeAdjustmentByMetres:longAdjust];
    XCTAssertFalse(CLLocationCoordinate2DIsValid(newCoord));
}

-(void)testCoordinatesWithMetresAdjustment_WithValidPositiveArguments_ShouldReturnValidCoordinates{
    
    CLLocationCoordinate2D originalCoord = CLLocationCoordinate2DMake(0.0, 0.0);
    double latAdjust = 89.9*KFXCOREMetresPerDegreeLatitude;
    double longAdjust = 179.9*KFXCOREMetresPerDegreeLongitude;
    CLLocationCoordinate2D newCoord = [self.sut coordinatesFromCoordinates:originalCoord
                                            withLatitudeAdjustmentByMetres:latAdjust
                                               longitudeAdjustmentByMetres:longAdjust];
    XCTAssertTrue(CLLocationCoordinate2DIsValid(newCoord));
}

-(void)testCoordinatesWithMetresAdjustment_WithValidNegativeArguments_ShouldReturnValidCoordinates{
    
    CLLocationCoordinate2D originalCoord = CLLocationCoordinate2DMake(0.0, 0.0);
    double latAdjust = -89.9*KFXCOREMetresPerDegreeLatitude;
    double longAdjust = -179.9*KFXCOREMetresPerDegreeLongitude;
    CLLocationCoordinate2D newCoord = [self.sut coordinatesFromCoordinates:originalCoord
                                            withLatitudeAdjustmentByMetres:latAdjust
                                               longitudeAdjustmentByMetres:longAdjust];
    XCTAssertTrue(CLLocationCoordinate2DIsValid(newCoord));
}



//======================================================
#pragma mark - ** Get Data from array of locations **
//======================================================

//--------------------------------------------------------
#pragma mark - Test -totalDistanceFromLocations
//--------------------------------------------------------
-(void)testTotalDistanceFromLocations_WithNilArray_ShouldReturnZero{
    
    NSArray *locations = nil;
    CLLocationDistance totalDistance = [self.sut totalDistanceFromLocations:locations];
    XCTAssertTrue(dequal(totalDistance, 0.0));
}

-(void)testTotalDistanceFromLocations_WithSingleLocation_ShouldReturnZero{
    
    CLLocation *location1 = [[CLLocation alloc]initWithLatitude:50.0 longitude:-2.0];
    NSArray *locations = @[location1];
    CLLocationDistance totalDistance = [self.sut totalDistanceFromLocations:locations];
    XCTAssertTrue(dequal(totalDistance, 0.0));
}

-(void)testTotalDistanceFromLocations_WithTwoLocations_ShouldReturnDistance{
    
    CLLocation *location1 = [self locationWithLatitude:51.319664
                                             longitude:-2.2088530
                                  timeIntervalSinceNow:-1000];
    CLLocation *location2 = [self locationWithLatitude:51.454513
                                             longitude:-2.587910
                                  timeIntervalSinceNow:-500];

    NSArray *locations = @[location1, location2];
    CLLocationDistance totalDistance = [self.sut totalDistanceFromLocations:locations];

    /*
     Correct distance according to: http://www.movable-type.co.uk/scripts/latlong.html
     is 30280m
     */
    XCTAssertTrue(totalDistance < 31000 && totalDistance > 30000);
}

-(void)testTotalDistanceFromLocations_WithThreeLocations_ShouldReturnDistance{
    
    CLLocation *location1 = [self locationWithLatitude:51.319664
                                             longitude:-2.2088530
                                  timeIntervalSinceNow:-1000];
    CLLocation *location2 = [self locationWithLatitude:51.454513
                                             longitude:-2.587910
                                  timeIntervalSinceNow:-500];
    CLLocation *location3 = [self locationWithLatitude:51.375801
                                             longitude:-2.359904
                                  timeIntervalSinceNow:-200];

    NSArray *locations = @[location1, location2, location3];
    CLLocationDistance totalDistance = [self.sut totalDistanceFromLocations:locations];
    NSLog(@"TotalDistance = %f",totalDistance);
    /*
     Correct distance according to: http://www.movable-type.co.uk/scripts/latlong.html
     is 30280m + 18070m = 48350m
     */

    XCTAssertTrue(totalDistance < 49000 && totalDistance > 48000);
}




-(void)testTotalDistanceFromLocations_WithFourLocations_ShouldReturnDistance{
    
    CLLocation *location1 = [self locationWithLatitude:51.319664
                                             longitude:-2.2088530
                                  timeIntervalSinceNow:-1000];
    CLLocation *location2 = [self locationWithLatitude:51.454513
                                             longitude:-2.587910
                                  timeIntervalSinceNow:-500];
    CLLocation *location3 = [self locationWithLatitude:51.375801
                                             longitude:-2.359904
                                  timeIntervalSinceNow:-200];
    CLLocation *location4 = [self locationWithLatitude:51.555774
                                             longitude:-1.779718
                                  timeIntervalSinceNow:-100];

    NSArray *locations = @[location1, location2, location3, location4];
    CLLocationDistance totalDistance = [self.sut totalDistanceFromLocations:locations];
    NSLog(@"TotalDistance = %f",totalDistance);
    /*
     Correct distance according to: http://www.movable-type.co.uk/scripts/latlong.html
     is 30280m + 18070m + 44900m = 93250
     */
    
    XCTAssertTrue(totalDistance < 94000 && totalDistance > 93000);
}

-(void)testTotalDistanceFromLocations_WithSevenLocations_ShouldReturnDistance{
    
    CLLocation *location1 = [self locationWithLatitude:51.319664
                                             longitude:-2.2088530
                                  timeIntervalSinceNow:-1000];
    CLLocation *location2 = [self locationWithLatitude:51.454513
                                             longitude:-2.587910
                                  timeIntervalSinceNow:-500];
    CLLocation *location3 = [self locationWithLatitude:51.375801
                                             longitude:-2.359904
                                  timeIntervalSinceNow:-200];
    CLLocation *location4 = [self locationWithLatitude:51.555774
                                             longitude:-1.779718
                                  timeIntervalSinceNow:-100];
    // Go in reverse
    CLLocation *location3B = [self locationWithLatitude:51.375801
                                             longitude:-2.359904
                                  timeIntervalSinceNow:200];
    CLLocation *location2B = [self locationWithLatitude:51.454513
                                             longitude:-2.587910
                                  timeIntervalSinceNow:500];
    CLLocation *location1B = [self locationWithLatitude:51.319664
                                             longitude:-2.2088530
                                  timeIntervalSinceNow:1000];

    
    
    NSArray *locations = @[location1, location2, location3, location4, location3B,location2B,location1B];
    CLLocationDistance totalDistance = [self.sut totalDistanceFromLocations:locations];
    NSLog(@"TotalDistance = %f",totalDistance);
    /*
     Correct distance according to: http://www.movable-type.co.uk/scripts/latlong.html
     is 30280m + 18070m + 44900m = 93250 x 2 = 186500
     */
    
    XCTAssertTrue(totalDistance < 187000 && totalDistance > 186000);
}


-(void)testTotalDistanceFromLocations_WithTenLocations_ShouldReturnDistance{
    
    CLLocation *location1A = [self locationWithLatitude:51.319664
                                             longitude:-2.2088530
                                  timeIntervalSinceNow:-1000];
    CLLocation *location2A = [self locationWithLatitude:51.454513
                                             longitude:-2.587910
                                  timeIntervalSinceNow:-500];
    CLLocation *location3A = [self locationWithLatitude:51.375801
                                             longitude:-2.359904
                                  timeIntervalSinceNow:-200];
    CLLocation *location4A = [self locationWithLatitude:51.555774
                                             longitude:-1.779718
                                  timeIntervalSinceNow:-100];
    // Go in reverse
    CLLocation *location3B = [self locationWithLatitude:51.375801
                                              longitude:-2.359904
                                   timeIntervalSinceNow:200];
    CLLocation *location2B = [self locationWithLatitude:51.454513
                                              longitude:-2.587910
                                   timeIntervalSinceNow:500];
    CLLocation *location1B = [self locationWithLatitude:51.319664
                                              longitude:-2.2088530
                                   timeIntervalSinceNow:1000];
    // And re-do journey leg
    CLLocation *location2C = [self locationWithLatitude:51.454513
                                             longitude:-2.587910
                                  timeIntervalSinceNow:1500];
    CLLocation *location3C = [self locationWithLatitude:51.375801
                                             longitude:-2.359904
                                  timeIntervalSinceNow:2000];
    CLLocation *location4C = [self locationWithLatitude:51.555774
                                             longitude:-1.779718
                                  timeIntervalSinceNow:2500];

    
    NSArray *locations = @[location1A, location2A, location3A, location4A, location3B,location2B,location1B,location2C,location3C,location4C];
    CLLocationDistance totalDistance = [self.sut totalDistanceFromLocations:locations];
    NSLog(@"TotalDistance = %f",totalDistance);
    /*
     Correct distance according to: http://www.movable-type.co.uk/scripts/latlong.html
     is 30280m + 18070m + 44900m = 93250 x 3 = 279750
     */
    
    XCTAssertTrue(totalDistance < 281000 && totalDistance > 280000);
}


//--------------------------------------------------------
#pragma mark - -shortestDistanceBetweenTwoLocationsFromLocations
//--------------------------------------------------------
-(void)testShortestDistance_WithNilArray_ShouldReturnZero{
    
    NSArray *locations = nil;
    CLLocationDistance distance = [self.sut shortestDistanceBetweenTwoLocationsFromLocations:locations];
    XCTAssertTrue(dequal(distance, 0.0));
}

-(void)testShortestDistance_WithFiveValidLocations_ShouldReturnShortestDistance{
    
    CLLocation *location1 = [[CLLocation alloc]initWithLatitude:0.0 longitude:0.0];
    CLLocation *location2 = [[CLLocation alloc]initWithLatitude:0.1 longitude:0.1];
    CLLocation *location3 = [[CLLocation alloc]initWithLatitude:0.3 longitude:0.3];
    CLLocation *location4 = [[CLLocation alloc]initWithLatitude:0.8 longitude:0.8];
    CLLocation *location5 = [[CLLocation alloc]initWithLatitude:1.0 longitude:1.0];
    NSArray *locations = @[location1,location2,location3,location4,location5];
    
    CLLocationDistance expected = [location1 distanceFromLocation:location2];
    CLLocationDistance received = [self.sut shortestDistanceBetweenTwoLocationsFromLocations:locations];
    XCTAssertTrue(dequal(received, expected),@"Received: %f != Expected: %f",received,expected);
    
}

//--------------------------------------------------------
#pragma mark - -longestDistanceBetweenTwoLocationsFromLocations
//--------------------------------------------------------
-(void)testLongestDistance_WithNilArray_ShouldReturnZero{
    
    NSArray *locations = nil;
    CLLocationDistance distance = [self.sut longestDistanceBetweenTwoLocationsFromLocations:locations];
    XCTAssertTrue(dequal(distance, 0.0));
}

-(void)testLongestDistance_WithFiveValidLocations_ShouldReturnShortestDistance{
    
    CLLocation *location1 = [[CLLocation alloc]initWithLatitude:0.0 longitude:0.0];
    CLLocation *location2 = [[CLLocation alloc]initWithLatitude:0.1 longitude:0.1];
    CLLocation *location3 = [[CLLocation alloc]initWithLatitude:0.3 longitude:0.3];
    CLLocation *location4 = [[CLLocation alloc]initWithLatitude:0.8 longitude:0.8];
    CLLocation *location5 = [[CLLocation alloc]initWithLatitude:1.0 longitude:1.0];
    NSArray *locations = @[location1,location2,location3,location4,location5];
    
    CLLocationDistance expected = [location1 distanceFromLocation:location5];
    CLLocationDistance received = [self.sut longestDistanceBetweenTwoLocationsFromLocations:locations];
    XCTAssertTrue(dequal(received, expected),@"Received: %f != Expected: %f",received,expected);
    
}

//--------------------------------------------------------
#pragma mark - -averageSpeedReadFromLocations
//--------------------------------------------------------
-(void)testAverageSpeedReadFromLocations_WithNilArray_ShouldReturnZero{
    
    NSArray *locations = nil;
    CLLocationSpeed aveSpeed = [self.sut averageSpeedReadFromLocations:locations];
    XCTAssertTrue(dequal(aveSpeed, 0.0));
}

-(void)testAverageSpeedReadFromLocations_WithOneLocation_ShouldReturnZero{
    
    CLLocation *location1 = [self locationWithLatitude:0.0
                                             longitude:0.0
                                                 speed:999.0];
    
    NSArray *locations = @[location1];
    CLLocationSpeed aveSpeed = [self.sut averageSpeedReadFromLocations:locations];
    XCTAssertTrue(dequal(aveSpeed, 0.0));
}


-(void)testAverageSpeedReadFromLocations_WithFiveInValidSpeeds_ShouldReturnZero{
    
    CLLocation *location1 = [self locationWithLatitude:0.0
                                             longitude:0.0
                                                 speed:-1.0];
    CLLocation *location2 = [self locationWithLatitude:0.0
                                             longitude:0.0
                                                 speed:-1.0];
    CLLocation *location3 = [self locationWithLatitude:0.0
                                             longitude:0.0
                                                 speed:-1.0];
    CLLocation *location4 = [self locationWithLatitude:0.0
                                             longitude:0.0
                                                 speed:-1.0];
    CLLocation *location5 = [self locationWithLatitude:0.0
                                             longitude:0.0
                                                 speed:-1.0];
    
    NSArray *locations = @[location1,location2,location3,location4,location5];
    CLLocationSpeed expected = 0.0;
    CLLocationSpeed received = [self.sut averageSpeedReadFromLocations:locations];
    XCTAssertTrue(dequal(expected, received));
}

-(void)testAverageSpeedReadFromLocations_WithFiveValidSpeeds_ShouldReturnAverage{
    
    CLLocation *location1 = [self locationWithLatitude:0.0
                                             longitude:0.0
                                                 speed:10.0];
    CLLocation *location2 = [self locationWithLatitude:0.0
                                             longitude:0.0
                                                 speed:20.0];
    CLLocation *location3 = [self locationWithLatitude:0.0
                                             longitude:0.0
                                                 speed:30.0];
    CLLocation *location4 = [self locationWithLatitude:0.0
                                             longitude:0.0
                                                 speed:40.0];
    CLLocation *location5 = [self locationWithLatitude:0.0
                                             longitude:0.0
                                                 speed:0.0];
    
    NSArray *locations = @[location1,location2,location3,location4,location5];
    CLLocationSpeed expected = 20.0;
    CLLocationSpeed received = [self.sut averageSpeedReadFromLocations:locations];
    XCTAssertTrue(dequal(expected, received));
}

-(void)testAverageSpeedReadFromLocations_WithMixtureOfTenValidAndInvalidSpeeds_ShouldReturnAverageForValidOnly{
    
    CLLocation *location1 = [self locationWithLatitude:0.0
                                             longitude:0.0
                                                 speed:-1.0];
    CLLocation *location2 = [self locationWithLatitude:0.0
                                             longitude:0.0
                                                 speed:-1.0];
    CLLocation *location3 = [self locationWithLatitude:0.0
                                             longitude:0.0
                                                 speed:-1.0];
    CLLocation *location4 = [self locationWithLatitude:0.0
                                             longitude:0.0
                                                 speed:-1.0];
    CLLocation *location5 = [self locationWithLatitude:0.0
                                             longitude:0.0
                                                 speed:-1.0];
    CLLocation *location6 = [self locationWithLatitude:0.0
                                             longitude:0.0
                                                 speed:10.0];
    CLLocation *location7 = [self locationWithLatitude:0.0
                                             longitude:0.0
                                                 speed:20.0];
    CLLocation *location8 = [self locationWithLatitude:0.0
                                             longitude:0.0
                                                 speed:30.0];
    CLLocation *location9 = [self locationWithLatitude:0.0
                                             longitude:0.0
                                                 speed:40.0];
    CLLocation *location10 = [self locationWithLatitude:0.0
                                             longitude:0.0
                                                 speed:50.0];
    
    NSArray *locations = @[location1,location2,location3,location4,location5,location6,location7,location8,location9,location10];
    CLLocationSpeed expected = 30.0;
    CLLocationSpeed received = [self.sut averageSpeedReadFromLocations:locations];
    XCTAssertTrue(dequal(expected, received));
}


//--------------------------------------------------------
#pragma mark - -averageSpeedCalculatedFromLocations
//--------------------------------------------------------
-(void)testAverageSpeedCalculatedFromLocations_WithNilArray_ShouldReturnZero{
    
    NSArray *locations = nil;
    CLLocationSpeed aveSpeed = [self.sut averageSpeedCalculatedFromLocations:locations];
    XCTAssertTrue(dequal(aveSpeed, 0.0));
}

-(void)testAverageSpeedCaluculatedFromLocations_WithOneLocation_ShouldReturnZero{
    
    CLLocation *location1 = [self locationWithLatitude:0.0
                                             longitude:0.0
                                                 speed:999.0];

    NSArray *locations = @[location1];
    CLLocationSpeed aveSpeed = [self.sut averageSpeedCalculatedFromLocations:locations];
    XCTAssertTrue(dequal(aveSpeed, 0.0));
}

-(void)testAverageSpeedCaluculatedFromLocations_WithTwoValidLocations_ShouldReturnAverageSpeed{

    CLLocation *location1 = [self locationWithLatitude:51.319664
                                             longitude:-2.2088530
                                  timeIntervalSinceNow:0.0];
    CLLocation *location2 = [self locationWithLatitude:51.454513
                                             longitude:-2.587910
                                  timeIntervalSinceNow:3600];

    NSArray *locations = @[location1, location2];
    CLLocationSpeed received = [self.sut averageSpeedCalculatedFromLocations:locations];
    XCTAssertTrue(received < 8.5 && received > 8.0);
}

-(void)testAverageSpeedCaluculatedFromLocations_WithTenValidLocations_ShouldReturnAverageSpeed{
    
    
    CLLocation *location1A = [self locationWithLatitude:51.319664
                                              longitude:-2.2088530
                                   timeIntervalSinceNow:0.0];
    CLLocation *location2A = [self locationWithLatitude:51.454513
                                              longitude:-2.587910
                                   timeIntervalSinceNow:100.0];
    CLLocation *location3A = [self locationWithLatitude:51.375801
                                              longitude:-2.359904
                                   timeIntervalSinceNow:200.0];
    CLLocation *location4A = [self locationWithLatitude:51.555774
                                              longitude:-1.779718
                                   timeIntervalSinceNow:300.0];
    // Go in reverse
    CLLocation *location3B = [self locationWithLatitude:51.375801
                                              longitude:-2.359904
                                   timeIntervalSinceNow:500.0];
    CLLocation *location2B = [self locationWithLatitude:51.454513
                                              longitude:-2.587910
                                   timeIntervalSinceNow:1500.0];
    CLLocation *location1B = [self locationWithLatitude:51.319664
                                              longitude:-2.2088530
                                   timeIntervalSinceNow:2000];
    // And re-do journey leg
    CLLocation *location2C = [self locationWithLatitude:51.454513
                                              longitude:-2.587910
                                   timeIntervalSinceNow:2500];
    CLLocation *location3C = [self locationWithLatitude:51.375801
                                              longitude:-2.359904
                                   timeIntervalSinceNow:3000];
    CLLocation *location4C = [self locationWithLatitude:51.555774
                                              longitude:-1.779718
                                   timeIntervalSinceNow:3600];
    
    
    NSArray *locations = @[location1A, location2A, location3A, location4A, location3B,location2B,location1B,location2C,location3C,location4C];
    CLLocationSpeed received = [self.sut averageSpeedCalculatedFromLocations:locations];
    
    /*
     Correct distance according to: http://www.movable-type.co.uk/scripts/latlong.html
     is 30280m + 18070m + 44900m = 93250 x 3 = 279750
     So expected speed is approx 279750/3600 = 25.903
     */

    XCTAssertTrue(received < 78.5 && received > 77.5);
}


//--------------------------------------------------------
#pragma mark - -speedBetweenLocations
//--------------------------------------------------------
-(void)testSpeedBetweenLocationAndLocation_WithFirstLocationIsNil_ShouldReturnZero{
    
    CLLocation *location1 = nil;
    CLLocation *location2 = [self locationWithLatitude:51.454513
                                             longitude:-2.587910
                                  timeIntervalSinceNow:100.0];
    CLLocationSpeed speed = [self.sut speedBetweenLocation:location1
                                               andLocation:location2];
    XCTAssertTrue(dequal(speed, 0.0));
}

-(void)testSpeedBetweenLocationAndLocation_WithSecondLocationIsNil_ShouldReturnZero{
    
    CLLocation *location1 = [self locationWithLatitude:51.319664
                                             longitude:-2.2088530
                                  timeIntervalSinceNow:0.0];
    CLLocation *location2 = nil;
    CLLocationSpeed speed = [self.sut speedBetweenLocation:location1
                                               andLocation:location2];
    XCTAssertTrue(dequal(speed, 0.0));
}

-(void)testSpeedBetweenLocationAndLocation_WithTwoValidLocations_ShouldReturnSpeed{
    
    CLLocation *location1 = [self locationWithLatitude:51.319664
                                             longitude:-2.2088530
                                  timeIntervalSinceNow:0.0];
    CLLocation *location2 = [self locationWithLatitude:51.454513
                                             longitude:-2.587910
                                  timeIntervalSinceNow:10000.0];
    CLLocationSpeed speed = [self.sut speedBetweenLocation:location1
                                               andLocation:location2];
    /*
     Correct distance according to: http://www.movable-type.co.uk/scripts/latlong.html
     is 30280m
     So speed: 30280 / 10000 = 3.0280
     */

    XCTAssertTrue(speed > 3.0 && speed < 3.5);
}

//--------------------------------------------------------
#pragma mark - -speedsBetweenLocations:
//--------------------------------------------------------
-(void)testSpeedsBetweenLocations_WithNilArray_ShouldReturnNil{
    
    NSArray *locations = nil;
    NSArray *speeds = [self.sut speedsBetweenLocations:locations];
    XCTAssertNil(speeds);
}

-(void)testSpeedsBetweenLocations_WithTwoLocations_ShouldReturnOneSpeed{
    
    CLLocation *location1 = [self locationWithLatitude:51.319664
                                             longitude:-2.2088530
                                  timeIntervalSinceNow:0.0];
    CLLocation *location2 = [self locationWithLatitude:51.454513
                                             longitude:-2.587910
                                  timeIntervalSinceNow:10000.0];

    NSArray *locations = @[location1,location2];
    NSArray *speeds = [self.sut speedsBetweenLocations:locations];
    XCTAssertEqual(speeds.count, 1);
}

-(void)testSpeedsBetweenLocations_WithTenLocations_ShouldReturnNineSpeeds{
    
    CLLocation *location1 = [self locationWithLatitude:0.0
                                             longitude:0.0
                                                 speed:-1.0];
    CLLocation *location2 = [self locationWithLatitude:0.0
                                             longitude:0.0
                                                 speed:-1.0];
    CLLocation *location3 = [self locationWithLatitude:0.0
                                             longitude:0.0
                                                 speed:-1.0];
    CLLocation *location4 = [self locationWithLatitude:0.0
                                             longitude:0.0
                                                 speed:-1.0];
    CLLocation *location5 = [self locationWithLatitude:0.0
                                             longitude:0.0
                                                 speed:-1.0];
    CLLocation *location6 = [self locationWithLatitude:0.0
                                             longitude:0.0
                                                 speed:10.0];
    CLLocation *location7 = [self locationWithLatitude:0.0
                                             longitude:0.0
                                                 speed:20.0];
    CLLocation *location8 = [self locationWithLatitude:0.0
                                             longitude:0.0
                                                 speed:30.0];
    CLLocation *location9 = [self locationWithLatitude:0.0
                                             longitude:0.0
                                                 speed:40.0];
    CLLocation *location10 = [self locationWithLatitude:0.0
                                              longitude:0.0
                                                  speed:50.0];
    
    NSArray *locations = @[location1,location2,location3,location4,location5,location6,location7,location8,location9,location10];
    NSArray *speeds = [self.sut speedsBetweenLocations:locations];
    XCTAssertEqual(speeds.count, 9);
}

//--------------------------------------------------------
#pragma mark - -slowestSpeedBetweenTwoLocations
//--------------------------------------------------------
-(void)testSlowestSpeedBetweenTwoLocations_WithNilArray_ShouldReturnZero{
    
    NSArray *locations = nil;
    CLLocationSpeed speed = [self.sut slowestSpeedBetweenTwoLocationsFromLocations:locations];
    XCTAssertTrue(dequal(speed, 0.0));
}

-(void)testSlowestSpeedBetweenTwoLocations_WithTenValidLocations_ShouldReturnTheSlowestSpeed{
    
    CLLocation *location1A = [self locationWithLatitude:51.319664
                                              longitude:-2.2088530
                                   timeIntervalSinceNow:0.0];
    CLLocation *location2A = [self locationWithLatitude:51.454513
                                              longitude:-2.587910
                                   timeIntervalSinceNow:100.0];
    CLLocation *location3A = [self locationWithLatitude:51.375801
                                              longitude:-2.359904
                                   timeIntervalSinceNow:200.0];
    CLLocation *location4A = [self locationWithLatitude:51.555774
                                              longitude:-1.779718
                                   timeIntervalSinceNow:300.0];
    // Go in reverse
    CLLocation *location3B = [self locationWithLatitude:51.375801
                                              longitude:-2.359904
                                   timeIntervalSinceNow:500.0];
    CLLocation *location2B = [self locationWithLatitude:51.454513
                                              longitude:-2.587910
                                   timeIntervalSinceNow:1500.0];
    CLLocation *location1B = [self locationWithLatitude:51.319664
                                              longitude:-2.2088530
                                   timeIntervalSinceNow:2000];
    // And re-do journey leg
    CLLocation *location2C = [self locationWithLatitude:51.454513
                                              longitude:-2.587910
                                   timeIntervalSinceNow:2500];
    CLLocation *location3C = [self locationWithLatitude:51.375801
                                              longitude:-2.359904
                                   timeIntervalSinceNow:3000];
    CLLocation *location4C = [self locationWithLatitude:51.555774
                                              longitude:-1.779718
                                   timeIntervalSinceNow:23600];
    
    
    NSArray *locations = @[location1A, location2A, location3A, location4A, location3B,location2B,location1B,location2C,location3C,location4C];

    CLLocationSpeed expected = [self.sut speedBetweenLocation:location3C
                                                   andLocation:location4C];
    CLLocationSpeed recevied = [self.sut slowestSpeedBetweenTwoLocationsFromLocations:locations];
    XCTAssertTrue(dequal(recevied, expected));
}

//--------------------------------------------------------
#pragma mark - -fastestSpeedBetweenTwoLocations
//--------------------------------------------------------
-(void)testFastestSpeedBetweenTwoLocations_WithNilArray_ShouldReturnZero{
    
    NSArray *locations = nil;
    CLLocationSpeed speed = [self.sut fastestSpeedBetweenTwoLocationsFromLocations:locations];
    XCTAssertTrue(dequal(speed, 0.0));
}

-(void)testFastestSpeedBetweenTwoLocations_WithTenValidLocations_ShouldReturnTheFastestSpeed{
    
    CLLocation *location1A = [self locationWithLatitude:51.319664
                                              longitude:-2.2088530
                                   timeIntervalSinceNow:0.0];
    CLLocation *location2A = [self locationWithLatitude:51.454513
                                              longitude:-2.587910
                                   timeIntervalSinceNow:10.0];
    CLLocation *location3A = [self locationWithLatitude:51.375801
                                              longitude:-2.359904
                                   timeIntervalSinceNow:200.0];
    CLLocation *location4A = [self locationWithLatitude:51.555774
                                              longitude:-1.779718
                                   timeIntervalSinceNow:300.0];
    // Go in reverse
    CLLocation *location3B = [self locationWithLatitude:51.375801
                                              longitude:-2.359904
                                   timeIntervalSinceNow:500.0];
    CLLocation *location2B = [self locationWithLatitude:51.454513
                                              longitude:-2.587910
                                   timeIntervalSinceNow:1500.0];
    CLLocation *location1B = [self locationWithLatitude:51.319664
                                              longitude:-2.2088530
                                   timeIntervalSinceNow:2000];
    // And re-do journey leg
    CLLocation *location2C = [self locationWithLatitude:51.454513
                                              longitude:-2.587910
                                   timeIntervalSinceNow:2500];
    CLLocation *location3C = [self locationWithLatitude:51.375801
                                              longitude:-2.359904
                                   timeIntervalSinceNow:3000];
    CLLocation *location4C = [self locationWithLatitude:51.555774
                                              longitude:-1.779718
                                   timeIntervalSinceNow:23600];
    
    
    NSArray *locations = @[location1A, location2A, location3A, location4A, location3B,location2B,location1B,location2C,location3C,location4C];
    
    CLLocationSpeed expected = [self.sut speedBetweenLocation:location1A
                                                  andLocation:location2A];
    CLLocationSpeed recevied = [self.sut fastestSpeedBetweenTwoLocationsFromLocations:locations];
    XCTAssertTrue(dequal(recevied, expected));

}


//--------------------------------------------------------
#pragma mark - -timeSpentInCircularRegion
//--------------------------------------------------------
-(void)testTimeSpentInCircularRegion_WithNilArray_ShouldReturnZero{
    
    NSArray *locations = nil;
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(0.0, 0.0);
    CLCircularRegion *region = [[CLCircularRegion alloc]initWithCenter:coord
                                                                radius:100.0
                                                            identifier:@"testRegion"];
    NSTimeInterval expected = 0.0;
    NSTimeInterval received = [self.sut timeSpentInCircularRegion:region
                                             withLocations:locations];
    XCTAssertTrue(dequal(received, expected));
}

-(void)testTimeSpentInCircularRegion_WithNilRegion_ShouldReturnZero{

    CLLocation *location1 = [[CLLocation alloc]initWithLatitude:0.0
                                                      longitude:0.0];
    NSArray *locations = @[location1];
    CLCircularRegion *region = nil;
    
    NSTimeInterval expected = 0.0;
    NSTimeInterval received = [self.sut timeSpentInCircularRegion:region
                                                    withLocations:locations];
    XCTAssertTrue(dequal(received, expected));
}

-(void)testTimeSpentInCircularRegion_WithValidRegionAndLocations_ShouldReturnTime{
    
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(0.000, 0.000);
    CLCircularRegion *region = [[CLCircularRegion alloc]initWithCenter:coord
                                                                radius:10000.0
                                                            identifier:@"testRegion"];
    
    CLLocation *location1 = [self locationWithLatitude:0.00000
                                             longitude:0.00000
                                  timeIntervalSinceNow:0.00000];
    CLLocation *location2 = [self locationWithLatitude:0.00001
                                             longitude:0.00000
                                  timeIntervalSinceNow:100.00000];
    CLLocation *location3 = [self locationWithLatitude:0.00001
                                             longitude:0.00001
                                  timeIntervalSinceNow:3600.00000];
    CLLocation *location4 = [self locationWithLatitude:10.00000
                                             longitude:10.00000
                                  timeIntervalSinceNow:7200.00000];
    CLLocation *location5 = [self locationWithLatitude:10.00000
                                             longitude:10.00000
                                  timeIntervalSinceNow:100000.00000];
    NSArray<CLLocation*> *locations = @[location1,location2,location3,location4,location5];
    
    NSTimeInterval received = [self.sut timeSpentInCircularRegion:region
                                                    withLocations:locations];
    /*
     The intention is that the first 3 location points are within the region and the last two are not.
     So the result should be about 3600 seconds
     */
    XCTAssertTrue(received < 4000.0 && received > 3000, @"Received: %f",received);
}














//======================================================
#pragma mark - ** Sorting **
//======================================================
//--------------------------------------------------------
#pragma mark - -sortLocationsChronologically
//--------------------------------------------------------
-(void)testSortingLocationsChronologically_WithNilArray_ShouldReturnNil{
    
    NSArray *originalLocations = nil;
    NSArray *sortedLocations = [self.sut sortLocationsChronologically:originalLocations
                                                            ascending:NO];
    XCTAssertNil(sortedLocations);
}

-(void)testSortingLocationsChronologically_WithFiveLocations_ShouldReturnSortedLocations{
    
    CLLocation *location1 = [self locationWithLatitude:51.319664
                                              longitude:-2.2088530
                                   timeIntervalSinceNow:-2000];
    CLLocation *location2 = [self locationWithLatitude:51.454513
                                              longitude:-2.587910
                                   timeIntervalSinceNow:-1500];
    CLLocation *location3 = [self locationWithLatitude:51.375801
                                              longitude:-2.359904
                                   timeIntervalSinceNow:-1000];
    CLLocation *location4 = [self locationWithLatitude:51.555774
                                              longitude:-1.779718
                                   timeIntervalSinceNow:500];
    CLLocation *location5 = [self locationWithLatitude:51.375801
                                              longitude:-2.359904
                                   timeIntervalSinceNow:2000];

    NSArray *originalLocations = @[location4,location2,location1,location5,location3];
    NSArray *sortedLocations = [self.sut sortLocationsChronologically:originalLocations
                                                            ascending:YES];
    XCTAssertEqualObjects(location1, sortedLocations[0]);
    XCTAssertEqualObjects(location2, sortedLocations[1]);
    XCTAssertEqualObjects(location3, sortedLocations[2]);
    XCTAssertEqualObjects(location4, sortedLocations[3]);
    XCTAssertEqualObjects(location5, sortedLocations[4]);
    
    sortedLocations = [self.sut sortLocationsChronologically:originalLocations
                                                            ascending:NO];
    XCTAssertEqualObjects(location5, sortedLocations[0]);
    XCTAssertEqualObjects(location4, sortedLocations[1]);
    XCTAssertEqualObjects(location3, sortedLocations[2]);
    XCTAssertEqualObjects(location2, sortedLocations[3]);
    XCTAssertEqualObjects(location1, sortedLocations[4]);
}




//--------------------------------------------------------
#pragma mark - Helpers
//--------------------------------------------------------
-(CLLocation*)locationWithLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude timeIntervalSinceNow:(NSTimeInterval)timeInterval{
    
    NSDate *timeStamp = [NSDate dateWithTimeIntervalSinceNow:timeInterval];
    CLLocation *location = [self locationWithLatitude:latitude
                                            longitude:longitude
                                            timeStamp:timeStamp];
    return location;
};

-(CLLocation*)locationWithLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude timeStamp:(NSDate*)timeStamp{
    
    CLLocation *location = [[CLLocation alloc]initWithCoordinate:CLLocationCoordinate2DMake(latitude, longitude) altitude:0.0 horizontalAccuracy:0.0 verticalAccuracy:0.0 timestamp:timeStamp];
    return location;
};

-(CLLocation*)locationWithLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude speed:(CLLocationSpeed)speed{
    
    CLLocation *location = [[CLLocation alloc]initWithCoordinate:CLLocationCoordinate2DMake(latitude, longitude)
                                                        altitude:0.0
                                              horizontalAccuracy:0.0
                                                verticalAccuracy:0.0
                                                          course:0.0
                                                           speed:speed
                                                       timestamp:[NSDate date]];
    return location;
}





@end















