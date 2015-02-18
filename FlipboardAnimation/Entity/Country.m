//
//  Country.m
//  iOSTemplate
//
//  Created by mohsin on 11/5/14.
//  Copyright (c) 2014 mohsin. All rights reserved.
//

#import "Country.h"
#import "ParserUtils.h"

@implementation Country
@synthesize countryId,name;

-(void)set:(NSDictionary*)input{
    self.name   = [ParserUtils stringValue:input key:@"name"];
    self.countryId = [[ParserUtils numberValue:input key:@"userId"] intValue];
}
@end
