//
//  RegistrationView.h
//  iOSTemplate
//
//  Created by mohsin on 11/5/14.
//  Copyright (c) 2014 mohsin. All rights reserved.
//

#import "BaseView.h"
#import "User.h"

@interface RegistrationView : BaseView


@property(nonatomic,retain) IBOutlet UILabel *label;


-(IBAction)onSubmit :(id)sender;
-(void)set:(User*)user;

@end
