//
//  FavorRequest.m
//  CloudSave
//
//  Created by Ron on 16/1/23.
//  Copyright © 2016年 Ron. All rights reserved.
//

#import "FavorRequest.h"

@implementation FavorRequest

+ (instancetype)request {
    static FavorRequest *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[FavorRequest alloc] init];
    });
    
    return instance;
}

- (void)favorListType:(FavorListType)type
             withPage:(NSInteger)page
            onSuccess:(ArrayRespSuccessHandler)successHandler
            onFailure:(FailureHandler)failureHandler
             onFinish:(FinishHandler)finishHandler {
    
    NSDictionary *parameterDic = @{@"type"  : @(type),
                                   @"page"  : @(page),
                                   @"limit" : @(kFavorListPageLimit)};
    
    [[CSAPIClient sharedInstance] requestGet:@"fav"
                                  parameters:parameterDic
                                     success:^(id responseObject) {
                                         NSLog(@"success %@", responseObject);
                                         successHandler(responseObject[@"favList"]);
                                     } failure:^(NSInteger stateCode, NSString *message) {
                                         NSLog(@"failure %@", message);
                                         failureHandler(stateCode, message);
                                     } finish:^{
                                         NSLog(@"finish");
                                         finishHandler();
                                     }];
}

- (void)favorAddURL:(NSString *)URLString
          withTitle:(NSString *)title
            onSuccess:(DictRespSuccessHandler)successHandler
            onFailure:(FailureHandler)failureHandler
             onFinish:(FinishHandler)finishHandler {
    
    NSDictionary *parameterDic = @{@"url"   : URLString,
                                   @"title" : title};
    
    [[CSAPIClient sharedInstance] requestGet:@"fav/add"
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

- (void)unfavorID:(NSString *)favorID
        onSuccess:(DictRespSuccessHandler)successHandler
        onFailure:(FailureHandler)failureHandler
         onFinish:(FinishHandler)finishHandler {
    
    NSDictionary *parameterDic = @{@"favId" : favorID};
    
    [[CSAPIClient sharedInstance] requestGet:@"fav/deleteByFavId"
                                  parameters:parameterDic
                                     success:^(id responseObject) {
                                         NSLog(@"success %@", responseObject);
                                         successHandler(responseObject);
                                     }
                                     failure:failureHandler
                                      finish:finishHandler
     ];
}

@end
