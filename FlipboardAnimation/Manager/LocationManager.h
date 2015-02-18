//
//  LocationManager.h
//  10Pearls
//
//  Created by mohsin on 3/18/14.
//  Copyright (c) 2014 SocialRadar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@class Location;

typedef void (^successCallback)(id location);
typedef void (^failureCallback)(NSError *error);

@interface LocationManager : NSObject<CLLocationManagerDelegate>{
    CLLocationManager *_manager;
    NSDate *_lastUpdatedOn;
  //  CLLocationCoordinate2D _location;
}


+(LocationManager*)getInstance;

@property(nonatomic) CLLocationCoordinate2D location;
@property (copy) successCallback onSuccessCallback;
@property (copy) failureCallback onFailureCallback;

-(void)start;

-(void)stop;

-(BOOL)hasLocation;

-(void)getCurrentLocation:(successCallback)success andFailure:(failureCallback)failure;

@end
