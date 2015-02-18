//
//  LoginView.h
//  iOSTemplate
//
//  Created by mohsin on 4/3/14.
//  Copyright (c) 2014 mohsin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseView.h"
#import "RegistrationController.h"

@interface LoginView : BaseView
{
    RegistrationController *_registrationController;
}


-(void)setData:(NSArray*)data;
-(IBAction)openRegistrationController:(id)sender;
@end
