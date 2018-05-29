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
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.window.rootViewController = nil;
    });
}

@end
