//
//  LocationManager.m
//  10Pearls
//
//  Created by mohsin on 3/18/14.
//  Copyright (c) 2014 SocialRadar. All rights reserved.
//

#import "LocationManager.h"

@implementation LocationManager
@synthesize location;

+(LocationManager*)getInstance{
    static LocationManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[LocationManager alloc] init];
    });
    return sharedInstance;
}

-(void)start{
    _lastUpdatedOn = nil;
    if(_manager == nil){
        _manager = [[CLLocationManager alloc] init];
        _manager.delegate = self;
    }
#ifdef __IPHONE_8_0
    NSUInteger code = [CLLocationManager authorizationStatus];
    if (code == kCLAuthorizationStatusNotDetermined && ([_manager respondsToSelector:@selector(requestAlwaysAuthorization)] || [_manager respondsToSelector:@selector(requestWhenInUseAuthorization)])) {
        // choose one request according to your business.
        if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"]){
            [_manager requestAlwaysAuthorization];
        } else if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"]) {
            [_manager  requestWhenInUseAuthorization];
        } else {
            NSLog(@"Info.plist does not contain NSLocationAlwaysUsageDescription or NSLocationWhenInUseUsageDescription");
        }
    }
#endif
    [_manager startUpdatingLocation];
}

-(void)update{
    [_manager startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    [_manager stopUpdatingLocation];
    NSLog(@"----------- trigger -------------");
    
    if(![self isDue]){
       // [self scheduleNext];
        return;
    }

    if(locations.count == 0){
        [self notifyCallback:nil];
        return;
    }

    [self onLocationUpdate];
    
    self.location = [[locations lastObject] coordinate];
    NSLog(@"%f-%f",self.location.latitude,self.location.longitude);
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    [_manager stopUpdatingLocation];
    //NSLog(@"----------- fail ------------");
    [self onLocationUpdate];
    [self notifyCallback:nil];
}

-(void)onLocationUpdate{
    _lastUpdatedOn = [NSDate date];
    [self scheduleNext];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"OnLocationUpdate" object:nil];
}

-(void)scheduleNext{
   // [self performSelector:@selector(update) withObject:nil afterDelay:30.0];
}

-(BOOL)isDue{
    if(_lastUpdatedOn == nil)
        return YES;
    
    NSDate *current = [NSDate date];
    
    NSTimeInterval interval = [current timeIntervalSinceDate:_lastUpdatedOn] / 60;
    if(interval < 0)
        interval = interval * -1;
    
    NSLog(@"%f",interval);
    return (interval > 1);
}

-(void)stop{
    
}

-(BOOL)hasLocation{
    if(self.location.latitude == 0 && self.location.longitude == 0)
        return NO;
    
    return YES;
}

-(void)getCurrentLocation:(successCallback)success andFailure:(failureCallback)failure{
    _onSuccessCallback = success;
    _onFailureCallback = failure;
    [self start];
}

-(void)notifyCallback:(Location*)newLocation{
    if(_onSuccessCallback == nil)
        return;
    
    if(newLocation == nil){
        _onFailureCallback(nil);
        return;
    }
    
        _onSuccessCallback(newLocation);
}

@end
