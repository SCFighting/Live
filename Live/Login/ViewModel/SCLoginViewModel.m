//
//  SCLoginViewModel.m
//  Live
//
//  Created by SC on 2018/5/29.
//  Copyright © 2018年 SC. All rights reserved.
//

#import "SCLoginViewModel.h"

@implementation SCLoginViewModel

-(void)dealloc
{
    GGLog(@"%s",__FUNCTION__);
    if (self.requestArray.count > 0) {
        GGLog(@"############################");
    }
}

-(void)loginWithSuccess:(successLogin)success
{
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@"a@b.com",@"user[email]",@"aaaaaaaa",@"user[password]",@"iphone",@"platform",@"4.1.7",@"os_vision",@"4.1.7",@"version", nil];
    
    NSURLSessionDataTask *task = [self postDataToURL:SCLogin parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        GGLog(@"%lld",downloadProgress.completedUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        GGLog(@"%@",responseObject);
        [self.requestArray removeObject:task];
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        GGLog(@"%@",error.userInfo);
        [self.requestArray removeObject:task];
    }];
    if (self.requestArray == nil) {
        self.requestArray = [[SCSafeMutableArray alloc] init];
    }
    [self.requestArray addObject:task];
    NSLog(@"%ld",(long)self.requestArray.count);
}

@end
