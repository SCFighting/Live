//
//  SCViewManagerProtocol.h
//  Live
//
//  Created by SC on 2018/5/4.
//  Copyright © 2018年 SC. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SCViewManagerProtocol <NSObject>

/**
 处理 view的事件

 @param eventName 事件名称(将来用作处理事件的方法名)
 @param info 事件信息
 */
-(void)handelEvent:(NSString *)eventName info:(NSDictionary *)info;
@end
