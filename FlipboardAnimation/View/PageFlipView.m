//
//  PageFlipView.m
//  MBO
//
//  Created by Waheeda on 2/10/15.
//  Copyright (c) 2015 mohsin. All rights reserved.
//

#import "PageFlipView.h"
#import "MPFlipTransition.h"

@implementation PageFlipView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code


    }
    return self;
}


//-(void) awakeFromNib
//{
//    [super awakeFromNib];
//
//
//        [self addGestureRecognizers];
//
//}
//
//
//
//-(void) addGestureRecognizers
//{
//
//    UISwipeGestureRecognizer *left = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeNext)];
//    left.direction =  UISwipeGestureRecognizerDirectionUp;
//    left.delegate = self;
//    [self addGestureRecognizer:left];
//
//    UISwipeGestureRecognizer *right = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipePrev)];
//    right.direction =  UISwipeGestureRecognizerDirectionDown;
//    right.delegate = self;
//    [self addGestureRecognizer:right];
//}
//
//
//-(void) handleSwipeNext
//{
//    [MPFlipTransition transitionFromView:self.view1 toView:self.view2 duration:1.0 style:MPFlipStyleOrientationVertical transitionAction:MPTransitionActionShowHide completion:nil];
//}
//
//-(void) handleSwipePrev
//{
// [MPFlipTransition transitionFromView:self.view2 toView:self.view1 duration:1.0 style:MPFlipStyleOrientationVertical transitionAction:MPTransitionActionShowHide completion:nil];
//}


@end
