//
//  UIViewController+MBProgress.h
//  CloudSave
//
//  Created by Ron on 16/1/24.
//  Copyright © 2016年 Ron. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (MBProgress)

- (void)showProgressView;

- (void)hideProgressView;

- (void)showErrorMessage:(NSString *)message;

@end
