//
//  User.h
//  iOSTemplate
//
//  Created by mohsin on 4/3/14.
//  Copyright (c) 2014 mohsin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseEntity.h"

@interface User : BaseEntity

@property(nonatomic,retain) NSString *name;
@property(nonatomic) int userId;


@end
