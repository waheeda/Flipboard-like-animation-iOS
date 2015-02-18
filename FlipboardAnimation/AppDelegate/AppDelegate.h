//
//  AppDelegate.h
//  iOSTemplate
//
//  Created by mohsin on 4/3/14.
//  Copyright (c) 2014 mohsin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LoginController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
}
@property (strong , nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) UIWindow *window;
+(AppDelegate*)getInstance;
@end
