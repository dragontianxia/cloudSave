//
//  CSAPIClient.m
//  CloudSave
//
//  Created by Ron on 16/1/23.
//  Copyright © 2016年 Ron. All rights reserved.
//

#import "CSAPIClient.h"

static NSString * const CSAPIBaseURLString = @"http://rd12-bbl.xuebadev.com/";

@implementation CSAPIClient

+ (instancetype)sharedInstance {
    static CSAPIClient *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CSAPIClient alloc] initWithBaseURL:[NSURL URLWithString:CSAPIBaseURLString]];
        instance.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    return instance;
}

- (void)requestGet:(NSString *)URLString
        parameters:(NSDictionary *)parameters
           success:(void (^)(id responseObject))success
           failure:(void (^)(NSInteger stateCode, NSString *message))failure
            finish:(void (^)())finish {
    NSString *fullURL = [CSAPIBaseURLString stringByAppendingString:URLString];
    NSLog(@"[HTTP-REQU]: %@ %@", fullURL, parameters);
    
    [self GET:fullURL
   parameters:parameters
     progress:^(NSProgress * _Nonnull downloadProgress) {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         [self handleRequestSuccess:responseObject
                 withSuccessHandler:success
                 withFailureHandler:failure
                  withFinishHandler:finish];
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         [self handleRequestFailureWithHandler:failure withFinishHandler:finish];
     }];
}

- (void)handleRequestSuccess:(id)response
          withSuccessHandler:(void (^)(id responseObject))success
          withFailureHandler:(void (^)(NSInteger status, NSString* msg))failure
           withFinishHandler:(void (^)())finish {
    // 服务器错误，返回内容为空
    if (!response) {
        if (failure) failure(10086, @"网络错误");
        if (finish) finish();
        return;
    }
    
    NSInteger status = [[response objectForKey:@"statusCode"] integerValue];
    NSString *msg = [response objectForKey:@"msg"];
    if (status == 0) {
        if (success) success(response);
    } else {
        if (failure) failure(status, msg);
    }
    if (finish) finish();
}

- (void)handleRequestFailureWithHandler:(void (^)(NSInteger status, NSString *message))failure withFinishHandler:(void (^)())finish {
    // HTTP error are handled here
    if (failure) failure(10086, @"网络错误");
    if (finish) finish();
}

@end
