//
//  RegistrationController.m
//  iOSTemplate
//
//  Created by mohsin on 11/5/14.
//  Copyright (c) 2014 mohsin. All rights reserved.
//

#import "RegistrationController.h"
#import "RegistrationView.h"
#import "Service.h"

@interface RegistrationController ()

@end

@implementation RegistrationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super loadServices:@[@(CheckInTypeService)]];
}



@end
