//
//  FavorRequest.h
//  CloudSave
//
//  Created by Ron on 16/1/23.
//  Copyright © 2016年 Ron. All rights reserved.
//

#import "CSAPIClient.h"
#define kFavorListPageLimit 10

typedef NS_ENUM(NSInteger, FavorListType) {
    FavorListTypeAll        = 0,    //  全部
    FavorListTypeArticle    = 1,    //  文章
    FavorListTypeNoArticle  = 2     //  非文章
};

@interface FavorRequest : CSAPIClient

+ (instancetype)request;

/// get favor list
- (void)favorListType:(FavorListType)type
             withPage:(NSInteger)page
            onSuccess:(ArrayRespSuccessHandler)successHandler
            onFailure:(FailureHandler)failureHandler
             onFinish:(FinishHandler)finishHandler;

/// add new favor
- (void)favorAddURL:(NSString *)URLString
          withTitle:(NSString *)title
          onSuccess:(DictRespSuccessHandler)successHandler
          onFailure:(FailureHandler)failureHandler
           onFinish:(FinishHandler)finishHandler;

/// delete one favor
- (void)unfavorID:(NSString *)favorID
        onSuccess:(DictRespSuccessHandler)successHandler
        onFailure:(FailureHandler)failureHandler
         onFinish:(FinishHandler)finishHandler;

@end
