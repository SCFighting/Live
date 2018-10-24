//
//  UIView+property.h
//  Live
//
//  Created by SC on 2018/5/5.
//  Copyright © 2018年 SC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (property)
@property (nonatomic , weak) id <SCViewManagerProtocol>viewManager;
@property (nullable,readonly,copy) __kindof UIViewController *superController;
@end
