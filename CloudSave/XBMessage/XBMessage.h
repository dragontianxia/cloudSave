//
//  XBMessageView.h
//  XueBa
//
//  Created by every2003 on 12/15/14.
//  Copyright (c) 2014 Wenba. All rights reserved.
//  Modified by Ron on 11/10/2015

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, XBMessageType) {
    XBMessageTypeSucceeded,
    XBMessageTypeError,
    XBMessageTypeWarning,   //deprecated
    XBMessageTypeDownloading,
    XBMessageTypeNotice
};

@interface XBMessage : NSObject

+ (instancetype)sharedMessage;

- (void)showMessage:(NSString *)message withType:(XBMessageType)type;

@end
