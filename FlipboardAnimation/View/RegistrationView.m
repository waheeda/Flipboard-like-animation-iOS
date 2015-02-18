//
//  RegistrationView.m
//  iOSTemplate
//
//  Created by mohsin on 11/5/14.
//  Copyright (c) 2014 mohsin. All rights reserved.
//

#import "RegistrationView.h"

@implementation RegistrationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)set:(User*)user{
    self.label.text = user.name;
}


-(IBAction)onSubmit:(id)sender{

}


@end
