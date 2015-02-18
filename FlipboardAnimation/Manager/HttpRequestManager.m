//
//  HttpRequestManager.m
//  10Pearls
//
//  Created by mohsin on 4/4/14.
//  Copyright (c) 2014 SocialRadar. All rights reserved.
//

#import "HttpRequestManager.h"
#import "ParserUtils.h"
#import "ASIFormDataRequest.h"
#import "CJSONDeserializer.h"
#import "CJSONSerializer.h"
#import "Constant.h"
#import "BaseEntity.h"
#import "StringUtils.h"
#import "BaseResponse.h"
#import "AppDelegate.h"

@implementation HttpRequestManager

- (id)init {
    if (self = [super init]) {
        self.queue = [[NSOperationQueue alloc] init];
        [self.queue setMaxConcurrentOperationCount:1];
    }
    return self;
}

- (void)cancelAllOperations {
    for (NSOperation *operation in self.queue.operations) {
        ASIHTTPRequest *request = (ASIHTTPRequest *) operation;
        [request clearDelegatesAndCancel];
    }
    [self.queue cancelAllOperations];
}

- (void)put:(NSString *)path postJSON:(id)json success:(void (^)(id response))success failure:(void (^)(NSError *error))failure entity:(BaseEntity*)entity{
    ASIHTTPRequest *request = [self requestFromBody:path postJSON:json andVerb:@"PUT" success:^(id response) {
        [entity set:response];
        success(entity);
    } failure:^(NSError *error) {
        failure(error);
    }];

    [self.queue addOperation:request];
}

- (void)put:(NSString *)path postJSON:(id)json success:(void (^)(id response))success failure:(void (^)(NSError *error))failure response:(BaseResponse*)responseObject{
    ASIHTTPRequest *request = [self requestFromBody:path postJSON:json andVerb:@"PUT" success:^(id response) {
        [responseObject set:response];
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
    [self.queue addOperation:request];
}

- (void)post:(NSString *)path postJSON:(id)json success:(void (^)(id response))success failure:(void (^)(NSError *error))failure entity:(BaseEntity*)entity{
    ASIHTTPRequest *request = [self requestFromBody:path postJSON:json andVerb:@"POST" success:^(id response) {
        [entity set:response];
        success(entity);
    } failure:^(NSError *error) {
        failure(error);
    }];
    [self.queue addOperation:request];
}


- (void)post:(NSString *)path postJSON:(id)json success:(void (^)(id response))success failure:(void (^)(NSError *error))failure response:(BaseResponse*)responseObject{
    ASIHTTPRequest *request = [self requestFromBody:path postJSON:json andVerb:@"POST" success:^(id response) {
        [responseObject set:response];
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
    [self.queue addOperation:request];

}

- (void)get:(NSString *)string success:(void (^)(id response))success failure:(void (^)(NSError *error))failure entity:(BaseEntity*)entity{
    
    NSString *urlString = [self urlWithString:string];
    ASIHTTPRequest *request = [self requestFromUrlString:urlString andVerb:@"GET" success:^(id response) {
        [entity set:response];
        success(entity);
    } failure:^(NSError *error) {
        failure(error);
    }];
    [self.queue addOperation:request];
}


- (void)get:(NSString *)string success:(void (^)(id response))success failure:(void (^)(NSError *error))failure response:(BaseResponse*)responseObject{
    NSString *urlString = [self urlWithString:string];
    ASIHTTPRequest *request = [self requestFromUrlString:urlString andVerb:@"GET" success:^(id response) {
        [responseObject set:response];
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
    [self.queue addOperation:request];

}

- (void)delete:(NSString *)string success:(void (^)(id response))success failure:(void (^)(NSError *error))failure entity:(BaseEntity*)entity{
    NSString *urlString = [self urlWithString:string];
    ASIHTTPRequest *request = [self requestFromUrlString:urlString andVerb:@"DELETE" success:^(id response) {
        [entity set:response];
        success(entity);
    } failure:^(NSError *error) {
        failure(error);
    }];
    [self.queue addOperation:request];
}

- (void)delete:(NSString *)string success:(void (^)(id response))success failure:(void (^)(NSError *error))failure response:(BaseResponse*)responseObject{
    NSString *urlString = [self urlWithString:string];
    ASIHTTPRequest *request = [self requestFromUrlString:urlString andVerb:@"DELETE" success:^(id response) {
        [responseObject set:response];
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
    [self.queue addOperation:request];
}

- (id)processResponse:(ASIHTTPRequest *)req err:(NSError **)error {
    // (1) parse JSON
    NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:req.responseData options:(NSJSONReadingOptions) kNilOptions error:error];
    if (!responseDict) {
        NSLog(@"no response: %@", req.responseString);
        if (error != NULL) {
            *error = [NSError errorWithDomain:@"Error" code:-9991 userInfo:@{NSLocalizedDescriptionKey : @"Empty response"}];
        }
        return nil;
    }
    
    if (*error) {
        NSLog(@"Wrong data: %@ Headers:%@", req.responseString, req.responseHeaders);
        return nil;
    }
    
    // (2) check for API errors
    *error = [self checkError:responseDict];
    if (*error) {
        NSLog(@"API Error: %@", responseDict);
        return nil;
    }
    
    // (3) read response
    
    id results = [ParserUtils object:responseDict key:@"result"];
    
    if(results == nil) {
        results = responseDict;
    }
    return results;
}

#pragma mark - ASI Callback

- (void)abstractDataLoaded:(ASIHTTPRequest *)req {
    NSError *err = nil;
    //id result = [self processResponse:req err:&err];
    id result =  [self processResponse:req err:&err];

    if (req.responseStatusCode != 200 && err) {
        [self onLoadFailed:err req:req];
        return;
    }
    
    // (4) delegate
    [self onLoaded:result req:req];
}

- (void)abstractDataLoadFailed:(ASIHTTPRequest *)req {
    if (req.responseData.length == 0) {
        [self onLoadFailed:req.error req:req];
        return;
    }
    NSError *err = nil;
    NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:req.responseData options:(NSJSONReadingOptions) kNilOptions error:&err];
    if (err) {
        NSError *parseError = [NSError errorWithDomain:@"Response Parsing Error" code:-9991 userInfo:err.userInfo];
        [self onLoadFailed:parseError req:req];
        return;
    }
    
    err = [self checkError:responseDict];
    if (err) {
        [self onLoadFailed:err req:req];
        return;
    }
    
    NSString *responseString = [NSString stringWithFormat:@"Request Failed: %@", req.responseString];
    NSDictionary *info = @{NSLocalizedDescriptionKey : responseString};
    err = [NSError errorWithDomain:@"Abstract Service" code:-9991 userInfo:info];
    [self onLoadFailed:err req:req];
}


#pragma mark - Private

- (NSString *)urlWithString:(NSString *)url {
    return SERVICE_URL;
}

- (NSError *)checkError:(NSDictionary *)dictionary {
    NSDictionary *result = [ParserUtils object:dictionary key:@"result"];
    if(result == nil) {
        result = dictionary;
    }
    
    if(result == nil)
        return [NSError errorWithDomain:@"Service Error" code:-1 userInfo:@{NSLocalizedDescriptionKey : @"result node is empty"}];

    NSDictionary *error = [ParserUtils object:result key:@"error"];
    
    if(error == nil)
        return nil;
    
    NSString *message = [ParserUtils stringValue:error key:@"message"];
    if(message == nil)
        message = @"unknown error";
    
    return [NSError errorWithDomain:@"Service Error" code:-1 userInfo:@{NSLocalizedDescriptionKey : message}];
}

- (void)onLoaded:(id)result req:(ASIHTTPRequest *)req {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    req.onSuccessCallback(result);
    //onsuccess(result);
}

- (void)onLoadFailed:(NSError *)error req:(ASIHTTPRequest *)req {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    req.onFailureCallback(error);

//    int code = req.responseStatusCode;
//    if(code == 403)
//        [[AppDelegate getInstance] onAuthenticationFailure];
}



- (ASIHTTPRequest *)requestFromBody:(NSString *)path postJSON:(id)json andVerb:(NSString*)verb success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSString *urlString = [self urlWithString:path];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    CJSONSerializer *jsonSerializer = [CJSONSerializer serializer];
    NSError *error;
    NSData *data = [jsonSerializer serializeObject:json error:&error];
    if (!data || error) {
        NSLog(@"error: %@", error);
    }
    
    NSLog(@"POST:%@ \nDATA:%@ \nJSON:%@", urlString, json, [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    request.onSuccessCallback = success;
    request.onFailureCallback = failure;
    [request setTimeOutSeconds:60];
    [request setPersistentConnectionTimeoutSeconds:60];
    [request setShouldAttemptPersistentConnection:YES];
    [request setRequestMethod:verb];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request setTimeOutSeconds:HTTP_TIMEOUT];
    [request setResponseEncoding:NSUTF8StringEncoding];
   // [request setAllowCompressedResponse:YES];
    [request setPostBody:[data mutableCopy]];
    request.didFinishSelector = @selector(abstractDataLoaded:);
    request.didFailSelector = @selector(abstractDataLoadFailed:);
    request.delegate = self;
    [request addRequestHeader:@"X-ACCESS-TOKEN" value:_accessToken];
    
    return request;
}

- (ASIHTTPRequest *)requestFromUrlString:(NSString *)urlString andVerb:(NSString*)verb success:(void (^)(id response))success failure:(void (^)(NSError *error))failure{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    request.onSuccessCallback = success;
    request.onFailureCallback = failure;
    [request setTimeOutSeconds:REQUEST_TIMEOUT];
    [request setPersistentConnectionTimeoutSeconds:REQUEST_TIMEOUT];
    [request setShouldAttemptPersistentConnection:YES];
    [request setNumberOfTimesToRetryOnTimeout:2];
    [request setTimeOutSeconds:HTTP_TIMEOUT];
    [request setRequestMethod:verb];
    [request setResponseEncoding:NSUTF8StringEncoding];
    [request setAllowCompressedResponse:YES];
    request.didFinishSelector = @selector(abstractDataLoaded:);
    request.didFailSelector = @selector(abstractDataLoadFailed:);
    request.delegate = self;
    [request addRequestHeader:@"X-ACCESS-TOKEN" value:_accessToken];

    return request;
}

@end
