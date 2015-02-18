//
//  User.m
//  iOSTemplate
//
//  Created by mohsin on 4/3/14.
//  Copyright (c) 2014 mohsin. All rights reserved.
//

#import "User.h"
#import "ParserUtils.h"

@implementation User

-(void)set:(NSDictionary*)input{
    self.name   = [ParserUtils stringValue:input key:@"name"];
    self.userId = [[ParserUtils numberValue:input key:@"userId"] intValue];
}

@end
