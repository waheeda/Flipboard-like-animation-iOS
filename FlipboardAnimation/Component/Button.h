//
//  Button.h
//  Guardian
//
//  Created by mohsin on 10/18/14.
//  Copyright (c) 2014 10Pearls. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Button : UIButton

@property(nonatomic) IBInspectable BOOL isBold;
@property(nonatomic) IBInspectable BOOL isCondensed;
@property(nonatomic) IBInspectable int cornerRadius;

@end
