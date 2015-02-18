//
//  BaseView.h
//  iOSTemplate
//
//  Created by mohsin on 4/3/14.
//  Copyright (c) 2014 mohsin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseController;

@interface BaseView : UIView

@property(nonatomic,retain) BaseController *controller;
@property(nonatomic, retain) UINavigationController *navigationController;

@end
