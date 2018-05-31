//
//  StyleAppDelegate.m
//  Live
//
//  Created by SC on 2018/5/25.
//  Copyright © 2018年 SC. All rights reserved.
//

#import "StyleAppDelegate.h"
#import "LoginViewController.h"

@implementation StyleAppDelegate

/**
 进入应用
 */
-(void)enterApplication
{
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    LoginViewController *mainVC = [[LoginViewController alloc] init];
    UINavigationController *NAV = [[UINavigationController alloc] initWithRootViewController:mainVC];
    self.window.rootViewController = NAV;
    [self.window makeKeyAndVisible];
}


/**
 初始化屏幕 log
 */
-(void)initScreenLog
{
    [[GHConsole sharedConsole] startPrintLog];
}

@end
