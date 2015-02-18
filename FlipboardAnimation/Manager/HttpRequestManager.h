//
//  HttpRequestManager.h
//  10Pearls
//
//  Created by mohsin on 4/4/14.
//  Copyright (c) 2014 SocialRadar. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BaseEntity;
@class BaseResponse;

@class ASIHTTPRequest;
#define HTTP_TIMEOUT 40
#define REQUEST_TIMEOUT 60

@interface HttpRequestManager : NSObject{
}

typedef void (^successCallback)(id response);
typedef void (^failureCallback)(NSError *error);

@property(nonatomic, strong) NSOperationQueue *queue;
@property (nonatomic,retain) NSString *accessToken;

- (void)cancelAllOperations;

- (void)get:(NSString *)string success:(void (^)(id response))success failure:(void (^)(NSError *error))failure entity:(BaseEntity*)entity;

- (void)get:(NSString *)string success:(void (^)(id response))success failure:(void (^)(NSError *error))failure response:(BaseResponse*)responseObject;

- (void)delete:(NSString *)string success:(void (^)(id response))success failure:(void (^)(NSError *error))failure entity:(BaseEntity*)entity;

- (void)delete:(NSString *)string success:(void (^)(id response))success failure:(void (^)(NSError *error))failure response:(BaseResponse*)responseObject;

- (void)post:(NSString *)path postJSON:(id)json success:(void (^)(id response))success failure:(void (^)(NSError *error))failure entity:(BaseEntity*)entity;

- (void)post:(NSString *)path postJSON:(id)json success:(void (^)(id response))success failure:(void (^)(NSError *error))failure response:(BaseResponse*)responseObject;

- (void)put:(NSString *)path postJSON:(id)json success:(void (^)(id response))success failure:(void (^)(NSError *error))failure entity:(BaseEntity*)entity;

- (void)put:(NSString *)path postJSON:(id)json success:(void (^)(id response))success failure:(void (^)(NSError *error))failure response:(BaseResponse*)responseObject;

@end
