//
//  StringResponse.m
//  iOSTemplate
//
//  Created by mohsin on 11/5/14.
//  Copyright (c) 2014 mohsin. All rights reserved.
//

#import "StringResponse.h"
#import "StringUtils.h"
#import "ParserUtils.h"

@implementation StringResponse

-(void)init:(NSString*)responseKey{
    key = responseKey;
}

-(void)set:(NSDictionary*)input{
    if([StringUtils isEmptyOrNull:key]){
        value = input;
        return;
    }
    
    value = [ParserUtils object:input key:key];
}

-(id)get{
    return value;
}

@end
