//
//  LoginView.m
//  iOSTemplate
//
//  Created by mohsin on 4/3/14.
//  Copyright (c) 2014 mohsin. All rights reserved.
//

#import "LoginView.h"
#import "LoginController.h"

@implementation LoginView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setData:(NSArray*)data{

}


-(IBAction)openRegistrationController:(id)sender
{
    if(_registrationController == nil)
        _registrationController = [[RegistrationController alloc] init];
    
    [self.navigationController pushViewController:_registrationController animated:YES];


    [self setBackgroundColor:[UIColor purpleColor]];
    
}




@end