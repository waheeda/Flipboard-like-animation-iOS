//
//  BaseResponse.m
//  iOSTemplate
//
//  Created by mohsin on 11/5/14.
//  Copyright (c) 2014 mohsin. All rights reserved.
//

#import "BaseResponse.h"

@implementation BaseResponse

-(id)init{
    list = [[NSMutableArray alloc] init];
    return self;
}

-(void)set:(NSDictionary*)input{
    @throw [NSString stringWithFormat:@"Set method should be implemented in child class (%@)",self.description];
}

-(NSArray*)getList{
    return list;
}

-(id)get{
    return nil;
}


@end
