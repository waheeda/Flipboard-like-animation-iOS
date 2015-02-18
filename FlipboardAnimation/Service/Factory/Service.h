//
//  Service.h
//  10Pearls
//
//  Created by mohsin on 3/11/14.
//  Copyright (c) 2014 SocialRadar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AuthService.h"
#import "UserService.h"
#import "CheckInService.h"

typedef enum {
    ServiceTypeAuth        = 0,
    ServiceTypeUser        = 1,
    CheckInTypeService     = 2,
    XYZSERVICE             = 3
}ServiceType;


@interface Service : NSObject{
    NSDictionary *_servicesMap;
    id _delegate;
}

@property(nonatomic,retain) id delegate;
@property(nonatomic,retain) AuthService *auth;
@property(nonatomic,retain) UserService *user;
@property(nonatomic,retain) CheckInService *checkIn;

- (void)load:(NSArray*)services;

+ (Service*)get:(id)_delegate;

@end
