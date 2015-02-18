//
//  Country.h
//  iOSTemplate
//
//  Created by mohsin on 11/5/14.
//  Copyright (c) 2014 mohsin. All rights reserved.
//

#import "BaseEntity.h"

@interface Country : BaseEntity

@property(nonatomic) NSInteger countryId;
@property(nonatomic,retain) NSString *name;

@end
