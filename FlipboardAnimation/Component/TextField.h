//
//  TextField.h
//  Guardian
//
//  Created by mohsin on 10/18/14.
//  Copyright (c) 2014 10Pearls. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TextField : UITextField<UITextFieldDelegate>

@property(nonatomic) IBInspectable BOOL isBold;
@property(nonatomic) IBInspectable BOOL isCondensed;
@property(nonatomic) IBInspectable int maxLength;

@end
