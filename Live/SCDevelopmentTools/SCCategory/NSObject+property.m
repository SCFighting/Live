//
//  NSObject+property.m
//  Live
//
//  Created by SC on 2018/5/29.
//  Copyright © 2018年 SC. All rights reserved.
//

#import "NSObject+property.h"

@implementation NSObject (property)

-(void)setViewModel:(id<SCViewModelProtocol>)viewModel
{
    objc_setAssociatedObject(self, @selector(viewModel), viewModel, OBJC_ASSOCIATION_ASSIGN);
}

-(id<SCViewModelProtocol>)viewModel
{
    return objc_getAssociatedObject(self, @selector(viewModel));
}

-(void)setRequestArray:(SCSafeMutableArray *)requestArray
{
    objc_setAssociatedObject(self, @selector(requestArray), requestArray, OBJC_ASSOCIATION_RETAIN);
}

-(SCSafeMutableArray *)requestArray
{
    return objc_getAssociatedObject(self, @selector(requestArray));
}

@end
