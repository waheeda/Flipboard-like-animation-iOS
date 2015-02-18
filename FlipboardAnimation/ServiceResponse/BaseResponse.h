//
//  BaseResponse.h
//  iOSTemplate
//
//  Created by mohsin on 11/5/14.
//  Copyright (c) 2014 mohsin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseResponse : NSObject{
    NSMutableArray *list;
    NSString *key;
    id value;
}

-(void)set:(NSDictionary*)input;
-(NSArray*)getList;
-(id)get;

@end
