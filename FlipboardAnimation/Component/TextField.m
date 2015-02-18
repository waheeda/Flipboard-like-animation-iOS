//
//  TextField.m
//  Guardian
//
//  Created by mohsin on 10/18/14.
//  Copyright (c) 2014 10Pearls. All rights reserved.
//

#import "TextField.h"
#import "Constant.h"

@implementation TextField

-(void)awakeFromNib{
    [super awakeFromNib];
    self.delegate = self;
    NSString *font = FONT_MATRIX[self.isBold][self.isCondensed];
    
    self.font = [UIFont fontWithName:font size:self.font.pointSize];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if(self.maxLength == 0)
        return YES;
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return (newLength > self.maxLength) ? NO : YES;
}



@end
