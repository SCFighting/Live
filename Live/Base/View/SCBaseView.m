//
//  SCBaseView.m
//  Live
//
//  Created by SC on 2018/5/5.
//  Copyright © 2018年 SC. All rights reserved.
//

#import "SCBaseView.h"

@implementation SCBaseView

-(instancetype)initWithViewManager:(id<SCViewManagerProtocol>)viewManager
{
    if (self = [super init]) {
        self.viewManager = viewManager;
    }
    return self;
}

@end
