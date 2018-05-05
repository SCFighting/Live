//
//  LoginViewManager.m
//  Live
//
//  Created by SC on 2018/5/5.
//  Copyright © 2018年 SC. All rights reserved.
//

#import "LoginViewManager.h"

@implementation LoginViewManager
-(void)handelEvent:(NSString *)eventName info:(NSDictionary *)info
{
    NSLog(@"eventName=%@",eventName);
    [self performSelector:NSSelectorFromString([NSString stringWithFormat:@"%@:",eventName]) withObject:info];
}

-(void)handelTouchBegin:(NSDictionary *)info
{
    NSLog(@"###############################%@",info);
}

@end
