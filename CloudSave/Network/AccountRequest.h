//
//  AccountRequest.h
//  CloudSave
//
//  Created by Ron on 16/1/23.
//  Copyright © 2016年 Ron. All rights reserved.
//

#import "CSAPIClient.h"

@interface AccountRequest : CSAPIClient

+ (instancetype)request;

/// user sign up
- (void)signUpUserEmail:(NSString *)email
           withPassword:(NSString *)password
              onSuccess:(DictRespSuccessHandler)successHandler
              onFailure:(FailureHandler)failureHandler
               onFinish:(FinishHandler)finishHandler;

/// user sign in
- (void)signInUserEmail:(NSString *)email
           withPassword:(NSString *)password
              onSuccess:(DictRespSuccessHandler)successHandler
              onFailure:(FailureHandler)failureHandler
               onFinish:(FinishHandler)finishHandler;

@end
