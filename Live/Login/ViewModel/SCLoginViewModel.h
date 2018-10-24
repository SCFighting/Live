//
//  SCLoginViewModel.h
//  Live
//
//  Created by SC on 2018/5/29.
//  Copyright © 2018年 SC. All rights reserved.
//

#import "SCBaseViewModel.h"
typedef void (^successLogin)(id response);
@interface SCLoginViewModel : SCBaseViewModel
-(void)loginWithSuccess:(successLogin)success;
@end
