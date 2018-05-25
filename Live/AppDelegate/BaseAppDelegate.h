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
    NSString *_ttttttt;
    @private
    NSString *_privateOne;
    NSString *_privateTwo;
    @protected
    NSString *_protectOne;
    NSString *_protectTwo;
    @public
    NSString *_publicOne;
    NSString *_publicTwo;
    
}
@property (strong, nonatomic) UIWindow *window;

/**
 进入应用
 */
-(void)enterApplication;
@end
