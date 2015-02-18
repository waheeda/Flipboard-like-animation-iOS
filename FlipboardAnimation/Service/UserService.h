//
//  UserService.h
//  iOSTemplate
//
//  Created by mohsin on 4/3/14.
//  Copyright (c) 2014 mohsin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseService.h"


@interface UserService : BaseService

-(void)getUsers:(successCallback)success andfailure:(failureCallback)failure;

@end
