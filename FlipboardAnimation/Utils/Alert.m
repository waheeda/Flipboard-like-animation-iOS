//
//  Alert.m
//  Guardian
//
//  Created by mohsin on 10/22/14.
//  Copyright (c) 2014 10Pearls. All rights reserved.
//

#import "Alert.h"
#import <UIKit/UIKit.h>

@implementation Alert

+(void)show:(NSString*)title andMessage:(NSString*)message{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil, nil];
    [alert show];
}

@end
