//
// Created by mohsin on 8/14/13.
//


#import "BaseService.h"

@implementation BaseService

- (id)init {
    if (self = [super init]) {
        http = [HttpRequestManager new];
        core = [CoreDataManager new];
    }
    return self;
}


@end