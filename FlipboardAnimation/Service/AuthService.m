//
//  AuthService.m
//  10Pearls
//
//  Created by mohsin on 3/19/14.
//  Copyright (c) 2014 SocialRadar. All rights reserved.
//

#import "AuthService.h"
#import "User.h"

#define kSignup @"signin"
#define kGetFacities @"facility"

@implementation AuthService

-(void)signup:(NSString*)pin andPhone:(NSString*)phone andSuccess:(successCallback)success andfailure:(failureCallback)failure{
    NSDictionary *json = @{
                           @"pin_code"  : pin,
                           @"phone_number"  : phone,
                           @"device_push_token" : @"9999999999",
                           @"device_type" : @"iphone"
                           };
    
    [http post:kSignup postJSON:json success:success failure:failure entity:[User new]];
    
}

-(void)getFacilities:(successCallback)success andfailure:(failureCallback)failure{
    [http get:kGetFacities success:success failure:failure entity:[User new]];
}


@end
