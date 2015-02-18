//
// Created by mohsin on 8/14/13.
//


#import <Foundation/Foundation.h>
#import "HttpRequestManager.h"
#import "CoreDataManager.h"
typedef void (^successCallback)(id response);
typedef void (^failureCallback)(NSError *error);

@interface BaseService : NSObject{
    HttpRequestManager *http;
    CoreDataManager *core;
}

@end
