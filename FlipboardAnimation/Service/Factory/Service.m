//
//  Service.m
//  10Pearls
//
//  Created by mohsin on 3/11/14.
//  Copyright (c) 2014 SocialRadar. All rights reserved.
//

#import "Service.h"

@implementation Service
@synthesize delegate;

-(void)loadAuthService{
    if(self.auth != nil)
        return;
    
    self.auth = [[AuthService alloc] init];
}

-(void)loadUserService{
    if(self.user != nil)
        return;

    self.user = [[UserService alloc] init];
}

-(void)loadCheckInService{
    if(self.checkIn != nil)
        return;
    
    self.checkIn = [[CheckInService alloc] init];
}

#pragma mark setup

- (void)load:(NSArray*)services{
    [self loadServiceFromPList];
    
    for (NSNumber *object in services) {
        NSString *key = [NSString stringWithFormat:@"%d",[object intValue]];
        NSString *selectorString = [_servicesMap objectForKey:key];
        if(![selectorString isKindOfClass:[NSString class]]){
            NSLog(@"%@",[NSString stringWithFormat:@"service enum(%@) is not available", object]);
            @throw @"service not availble";
        }
        
        SEL selector = NSSelectorFromString([_servicesMap objectForKey:key]);
        
        if(![self respondsToSelector:selector]){
            NSLog(@"%@",[NSString stringWithFormat:@"%@ load method  not created",selectorString]);
            @throw @"service load method not created";
        }
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        
        [self performSelector:selector];
        
#pragma clang diagnostic pop
    }
    //    while( value = va_arg( args, NSNumber * ) )
}

-(void)loadServiceFromPList {
    if(_servicesMap != nil)
        return;
    
    _servicesMap = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Service" ofType:@"plist"]];
}

+ (Service*)get:(id)_delegate{
    Service *instance = [Service new];
    instance.delegate = _delegate;
    return instance;
}

@end
