//
//  PageFlipController.h
//  MBO
//
//  Created by Waheeda on 2/10/15.
//  Copyright (c) 2015 mohsin. All rights reserved.
//

#import "BaseController.h"
#import "MPFlipViewController.h"
#import "LoginController.h"
#import "RegistrationController.h"

@interface PageFlipController : BaseController <MPFlipViewControllerDataSource, MPFlipViewControllerDelegate >
{
    NSArray * _controllers;
    int _selectedControllerIndex;





}

@property(nonatomic, retain) MPFlipViewController * flipViewController;

@end
