//
//  BaseAppDelegate.m
//  Live
//
//  Created by SC on 2018/5/25.
//  Copyright © 2018年 SC. All rights reserved.
//

#import "BaseAppDelegate.h"

@implementation BaseAppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self initScreenLog];
    [self enterApplication];
    return YES;
}

/**
 进入应用
 */
-(void)enterApplication{}


/**
 Appdelegate

 @return return value Appdelegate
 */
+(instancetype)shareDelegate
{
    return (BaseAppDelegate *)[UIApplication sharedApplication].delegate;
}

/**
 初始化屏幕 log
 */
-(void)initScreenLog{}
@end
