//
//  StringUtils.h
//  Guardian
//
//  Created by mohsin on 10/17/14.
//  Copyright (c) 2014 10Pearls. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringUtils : NSObject

+(BOOL)isEmptyOrNull:(NSString*)value;

+(NSString*)validateForNull:(NSString*)value;

@end
