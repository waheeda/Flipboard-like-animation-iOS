//
//  PageFlipView.h
//  MBO
//
//  Created by Waheeda on 2/10/15.
//  Copyright (c) 2015 mohsin. All rights reserved.
//

#import "BaseView.h"

@interface PageFlipView : BaseView <UIGestureRecognizerDelegate>

@property(nonatomic, weak) IBOutlet UIView * view1;
@property(nonatomic, weak) IBOutlet UIView * view2;




@end
