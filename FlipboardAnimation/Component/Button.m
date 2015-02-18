//
//  Button.m
//  Guardian
//
//  Created by mohsin on 10/18/14.
//  Copyright (c) 2014 10Pearls. All rights reserved.
//

#import "Button.h"
#import "Constant.h"

@implementation Button

-(void)awakeFromNib{
    [super awakeFromNib];
    NSString *font = FONT_MATRIX[self.isBold][self.isCondensed];
    self.titleLabel.font = [UIFont fontWithName:font size:self.titleLabel.font.pointSize];
    
    if(self.cornerRadius > 0)
        self.layer.cornerRadius = self.cornerRadius;
    
}

@end
