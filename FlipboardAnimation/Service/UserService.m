//
//  UserService.m
//  iOSTemplate
//
//  Created by mohsin on 4/3/14.
//  Copyright (c) 2014 mohsin. All rights reserved.
//

#import "UserService.h"
#import "User.h"
#import "UsersResponse.h"

#define kMethodGetUsers @"v1/users"

@implementation UserService

-(void)getUsers:(successCallback)success andfailure:(failureCallback)failure{
    [http get:kMethodGetUsers success:success failure:false response:[UsersResponse new]];
}

@end
