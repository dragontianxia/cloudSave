//
//  UIViewController+MBProgress.m
//  CloudSave
//
//  Created by Ron on 16/1/24.
//  Copyright © 2016年 Ron. All rights reserved.
//

#import "UIViewController+MBProgress.h"
#import <MBProgressHUD/MBProgressHUD.h>

@implementation UIViewController (MBProgress)

- (void)showProgressView {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)hideProgressView {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)showErrorMessage:(NSString *)message {
    [[XBMessage sharedMessage] showMessage:message withType:XBMessageTypeError];
}

@end
