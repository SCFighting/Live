//
//  LoginViewManager.m
//  Live
//
//  Created by SC on 2018/5/5.
//  Copyright © 2018年 SC. All rights reserved.
//

#import "LoginViewManager.h"
#import "AppDelegate.h"

@implementation LoginViewManager
-(void)handelEvent:(NSString *)eventName view:(UIView *)eventView info:(NSDictionary *)info
{
    NSLog(@"eventName=%@",eventName);
    [self performSelector:NSSelectorFromString(eventName) withObject:eventView withObject:info];
}

-(void)handelTouchBegin:(UIView *)eventView info:(NSDictionary *)info
{
    NSLog(@"############%@###################%@",[NSThread currentThread],info);
    UITableViewController *ta = [[UITableViewController alloc] init];
    [eventView.superController.navigationController pushViewController:ta animated:YES];
}

-(void)dealloc
{
    NSLog(@"%s",__func__);
}

@end
