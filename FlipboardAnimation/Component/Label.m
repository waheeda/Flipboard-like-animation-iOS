//
//  Label.m
//  Guardian
//
//  Created by mohsin on 10/18/14.
//  Copyright (c) 2014 10Pearls. All rights reserved.
//

#import "Label.h"
#import "Constant.h"

@implementation Label

-(void)awakeFromNib{
    [super awakeFromNib];
    
    NSString *font = FONT_MATRIX[self.isBold][self.isCondensed];
    
    self.font = [UIFont fontWithName:font size:self.font.pointSize];
}

@end
