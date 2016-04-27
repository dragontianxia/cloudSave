//
//  AccountRequest.m
//  CloudSave
//
//  Created by Ron on 16/1/23.
//  Copyright © 2016年 Ron. All rights reserved.
//

#import "AccountRequest.h"

@implementation AccountRequest

+ (instancetype)request {
    static AccountRequest *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[AccountRequest alloc] init];
    });
    return instance;
}

- (void)signUpUserEmail:(NSString *)email
           withPassword:(NSString *)password
              onSuccess:(DictRespSuccessHandler)successHandler
              onFailure:(FailureHandler)failureHandler
               onFinish:(FinishHandler)finishHandler {
    
    NSDictionary *parameterDic = @{@"email"    : email,
                                   @"password" : password};
    
    [[CSAPIClient sharedInstance] requestGet:@"account/register"
                                  parameters:parameterDic
                                     success:^(id responseObject) {
                                         NSLog(@"success %@", responseObject);
                                         successHandler(responseObject);
                                     } failure:^(NSInteger stateCode, NSString *message) {
                                         NSLog(@"failure %@", message);
                                         failureHandler(stateCode, message);
                                     } finish:^{
                                         NSLog(@"finish");
                                         finishHandler();
                                     }];
}

- (void)signInUserEmail:(NSString *)email
           withPassword:(NSString *)password
              onSuccess:(DictRespSuccessHandler)successHandler
              onFailure:(FailureHandler)failureHandler
               onFinish:(FinishHandler)finishHandler {
    
    NSDictionary *parameterDic = @{@"email"    : email,
                                   @"password" : password};
    
    [[CSAPIClient sharedInstance] requestGet:@"account/login"
                                  parameters:parameterDic
                                     success:^(id responseObject) {
                                         NSLog(@"success %@", responseObject);
                                         successHandler(responseObject);
                                     } failure:^(NSInteger stateCode, NSString *message) {
                                         NSLog(@"failure %@", message);
                                         failureHandler(stateCode, message);
                                     } finish:^{
                                         NSLog(@"finish");
                                         finishHandler();
                                     }];
}

@end
