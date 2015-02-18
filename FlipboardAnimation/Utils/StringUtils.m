//
//  StringUtils.m
//  Guardian
//
//  Created by mohsin on 10/17/14.
//  Copyright (c) 2014 10Pearls. All rights reserved.
//

#import "StringUtils.h"

@implementation StringUtils

+(BOOL)isEmptyOrNull:(NSString*)value{
    if([value isKindOfClass:[NSNull class]] || value.length == 0)
        return YES;
    
    return NO;
}

+(NSString*)validateForNull:(NSString*)value{
    if([self isEmptyOrNull:value])
        return nil;
    
    return value;
}

@end
