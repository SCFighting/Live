//
//  UIView+property.m
//  Live
//
//  Created by SC on 2018/5/5.
//  Copyright © 2018年 SC. All rights reserved.
//

#import "UIView+property.h"
#import <objc/runtime.h>

@implementation UIView (property)
-(void)setViewManager:(id<SCViewManagerProtocol>)viewManager
{
    objc_setAssociatedObject(self, @selector(viewManager), viewManager, OBJC_ASSOCIATION_ASSIGN);
}

-(id<SCViewManagerProtocol>)viewManager
{
    return objc_getAssociatedObject(self, @selector(viewManager));
}



@end
