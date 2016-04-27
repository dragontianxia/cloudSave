//
//  CSAPIClient.h
//  CloudSave
//
//  Created by Ron on 16/1/23.
//  Copyright © 2016年 Ron. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef void (^NoParamSuccessHander) ();
typedef void (^ArrayRespSuccessHandler) (NSArray *array);
typedef void (^DictRespSuccessHandler) (NSDictionary *dict);
typedef void (^ProgressHandler) (CGFloat progress);
typedef void (^FailureHandler) (NSInteger statusCode, NSString *msg);
typedef void (^FinishHandler) ();

@interface CSAPIClient : AFHTTPSessionManager

+ (instancetype)sharedInstance;

- (void)requestGet:(NSString *)URLString
        parameters:(NSDictionary *)parameters
           success:(void (^)(id responseObject))success
           failure:(void (^)(NSInteger stateCode, NSString *message))failure
            finish:(void (^)())finish;
@end
