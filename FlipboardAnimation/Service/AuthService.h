//
//  AuthService.h
//  10Pearls
//
//  Created by mohsin on 3/19/14.
//  Copyright (c) 2014 SocialRadar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseService.h"


@interface AuthService : BaseService

-(void)signup:(NSString*)pin andPhone:(NSString*)phone andSuccess:(successCallback)success andfailure:(failureCallback)failure;
-(void)getFacilities:(successCallback)success andfailure:(failureCallback)failure;
@end
