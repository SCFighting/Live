//
//  NSObject+property.h
//  Live
//
//  Created by SC on 2018/5/29.
//  Copyright © 2018年 SC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (property)

@property (nonatomic , weak ) id <SCViewModelProtocol> viewModel;
@property (nonatomic , strong )SCSafeMutableArray  *requestArray;
@end
