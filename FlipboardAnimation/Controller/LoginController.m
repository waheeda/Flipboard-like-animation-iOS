//
//  LoginController.m
//  iOSTemplate
//
//  Created by mohsin on 4/3/14.
//  Copyright (c) 2014 mohsin. All rights reserved.
//

#import "LoginController.h"
#import "LoginView.h"
#import "AuthService.h"
#import "User.h"
#import "UsersResponse.h"

@interface LoginController ()

@end

@implementation LoginController

- (void)viewDidLoad{
    [super viewDidLoad];
    [super loadServices:@[@(ServiceTypeAuth)]];
//    [service.auth signup:@"11" andPhone:@"123" andSuccess:^(id response) {
//        UsersResponse *user = (UsersResponse*)response;
//        [user getList];
//        
//    } andfailure:^(NSError *error) {
//        [super onServiceResponseFailure:error];
//    }];
}



-(void)authServiceOnLoginSuccess:(id)data{

}

-(void)authServiceOnLoginFail:(NSError *)error{

}


-(void)userServiceOnGetUserSuccess:(NSArray *)users{

}

-(void)userServiceOnGetUserFailure:(NSError *)error{

}


@end
