//
//  DrawLineInfo.m
//  Live
//
//  Created by SC on 2018/6/5.
//  Copyright © 2018年 SC. All rights reserved.
//

#import "DrawLineInfo.h"

@implementation DrawLineInfo
- (instancetype)init {
    if (self=[super init]) {
        self.linePoints = [[NSMutableArray alloc] initWithCapacity:10];
    }
    return self;
}
@end
