//
//  SCBaseViewModel.m
//  Live
//
//  Created by SC on 2018/5/29.
//  Copyright © 2018年 SC. All rights reserved.
//

#import "SCBaseViewModel.h"

@interface SCBaseViewModel()
{
    AFHTTPSessionManager *_manager;
}

@end

@implementation SCBaseViewModel

-(NSURLSessionDataTask *)getDataFromURL:(NSString *)url parameters:(id)parameters progress:(requestProgress)progress success:(requestSuccess)success failure:(requestFailure)failure
{
    [self initAFN];
    NSURLSessionDataTask *task = [_manager GET:url parameters:parameters progress:progress success:success failure:failure];
    return task;
}

-(NSURLSessionDataTask *)postDataToURL:(NSString *)url parameters:(id)parameters progress:(requestProgress)progress success:(requestSuccess)success failure:(requestFailure)failure
{
    [self initAFN];
    NSURLSessionDataTask *task = [_manager POST:url parameters:parameters progress:progress success:success failure:failure];
    return task;
}

-(void)initAFN
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:ProductServiceAdd] sessionConfiguration:configuration];
}

-(void)cancelAllRequest
{
    for (NSURLSessionDataTask *task in self.requestArray.safeArray) {
        [task cancel];
    }
}


@end
