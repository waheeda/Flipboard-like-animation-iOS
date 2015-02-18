//
//  BaseController.h
//  iOSTemplate
//
//  Created by mohsin on 4/3/14.
//  Copyright (c) 2014 mohsin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Service.h"

@interface BaseController : UIViewController{
    Service *service;
}

-(void)loadServices:(NSArray*)services;
-(void)showLoader;
-(void)showLoader:(NSString*)message;
-(void)hideLoader;
-(void)onServiceResponseFailure:(NSError*)error;
@end
