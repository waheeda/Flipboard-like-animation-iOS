//
//  Font.h
//  wusup
//
//  Created by mohsin on 3/11/14.
//  Copyright (c) 2014 SocialRadar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Font : NSObject

+(UIFont*)heading;

+(UIFont*)medium;

+(UIFont*)normal;

+(UIFont*)smallFont;

+(UIFont*)button;

+ (CGFloat)getHeight:(NSString*)text andFont:(UIFont *)font andWidth:(int)width;

@end
