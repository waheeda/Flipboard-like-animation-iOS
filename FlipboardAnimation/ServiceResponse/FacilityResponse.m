//
//  FacilityResponse.m
//  iOSTemplate
//
//  Created by mohsin on 11/5/14.
//  Copyright (c) 2014 mohsin. All rights reserved.
//

#import "FacilityResponse.h"
#import "ParserUtils.h"
#import "Country.h"

@implementation FacilityResponse

-(void)set:(NSDictionary*)input{
    NSArray *countries = [ParserUtils array:input key:@"countries"];
    for (NSDictionary *object in countries) {
        Country *country = [Country new];
        [country set:object];
        [list addObject:country];
    }
}

@end
