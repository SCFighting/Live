//
//  LoginView.m
//  Live
//
//  Created by SC on 2018/5/5.
//  Copyright © 2018年 SC. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView

-(instancetype)initWithViewManager:(id<SCViewManagerProtocol>)viewManager
{
    self = [super initWithViewManager:viewManager];
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    if ([self.viewManager respondsToSelector:@selector(handelEvent:info:)]) {
        [self.viewManager handelEvent:@"handelTouchBegin:info:" view:self info:[NSDictionary dictionaryWithObjectsAndKeys:@"objc",@"key", nil]];
    }
}

-(void)dealloc
{
    NSLog(@"%s",__func__);
}

@end
