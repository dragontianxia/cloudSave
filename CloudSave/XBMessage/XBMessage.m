//
//  XBMessageView.m
//  XueBa
//
//  Created by every2003 on 12/15/14.
//  Copyright (c) 2014 Wenba. All rights reserved.
//  Modified by Ron on 11/10/2015

#import "XBMessage.h"
#import <MBProgressHUD/MBProgressHUD.h>
@interface XBMessage ()

@property (weak, nonatomic) MBProgressHUD *currentShownHUD;

@end

@implementation XBMessage

+ (instancetype)sharedMessage {
    static XBMessage *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[XBMessage alloc] init];
    });
    
    return instance;
}

- (void)showMessage:(NSString *)message withType:(XBMessageType)type {
    if (self.currentShownHUD) {
        [self.currentShownHUD hide:YES];
    }
    [self createMessageViewWithMessage:message withType:type];
}

#pragma mark - private
- (void)createMessageViewWithMessage:(NSString *)message withType:(XBMessageType)type {
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow];
    [HUD setUserInteractionEnabled:NO];
    [HUD setRemoveFromSuperViewOnHide:YES];
    [[UIApplication sharedApplication].keyWindow addSubview:HUD];
    
    // Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
    switch (type) {
        case XBMessageTypeSucceeded:
            HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"message_succeed"]];
            HUD.mode = MBProgressHUDModeCustomView;
            break;
        case XBMessageTypeError:
            HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"message_error"]];
            HUD.mode = MBProgressHUDModeCustomView;
            break;
        case XBMessageTypeDownloading:
            HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"message_download"]];
            HUD.mode = MBProgressHUDModeCustomView;
            break;
        case XBMessageTypeNotice:
            HUD.mode = MBProgressHUDModeText;
            break;
        default:
            break;
    }
//    NSString *mutableLineString = [[message replaceAll:@"," with:@"\n"] replaceAll:@"，" with:@"\n"];
    HUD.detailsLabelFont = [UIFont systemFontOfSize:14.0f];
//    HUD.detailsLabelText = mutableLineString;
    HUD.detailsLabelText = message;
    
    [HUD show:YES];
    [HUD hide:YES afterDelay:2];
    self.currentShownHUD = HUD;
}

@end
