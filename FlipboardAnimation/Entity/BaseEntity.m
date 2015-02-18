//
//  BaseEntity.m
//  Guardian
//
//  Created by mohsin on 10/16/14.
//  Copyright (c) 2014 10Pearls. All rights reserved.
//

#import "BaseEntity.h"

@implementation BaseEntity

-(void)set:(NSDictionary*)input{
    @throw [NSString stringWithFormat:@"Set method should be implemented in child class (%@)",self.description];
}

@end
