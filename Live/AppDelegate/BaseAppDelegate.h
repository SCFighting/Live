//
//  BaseAppDelegate.h
//  Live
//
//  Created by SC on 2018/5/25.
//  Copyright © 2018年 SC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseAppDelegate : UIResponder<UIApplicationDelegate>
{
    
}
@property (strong, nonatomic) UIWindow *window;

/**
 进入应用
 */
-(void)enterApplication;


/**
 单例

 @return  appdelegate
 */
+(instancetype)shareDelegate;


/**
 初始化屏幕 log
 */
-(void)initScreenLog;

@end
