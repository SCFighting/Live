//
//  LoginViewController.m
//  Live
//
//  Created by SC on 2018/5/5.
//  Copyright © 2018年 SC. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "LoginViewManager.h"
#import "AppDelegate.h"
#import "SCLoginViewModel.h"
#import "AppDelegate.h"
#import <TXLivePush.h>

@interface LoginViewController ()
@property (nonatomic , strong ) LoginView *loginView;
@property (nonatomic , strong ) LoginViewManager *loginViewManager;
@property (nonatomic , strong ) SCLoginViewModel *loginViewModel;
@property (nonatomic , strong ) TXLivePush *txLivePush;
@end

@implementation LoginViewController

-(void)loadView
{
    [super loadView];
    [self.view addSubview:self.loginView];
    [self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    @weakify(self);
    [self.loginViewModel loginWithSuccess:^(id response) {
        //请求推流地址
        @strongify(self);
        [self.loginView removeFromSuperview];
        self.loginView = nil;
        [self.txLivePush startPreview:self.view];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)dealloc
{
    NSLog(@"%s",__func__);
    if (self.loginViewModel.requestArray.count > 0) {
        [self.loginViewModel cancelAllRequest];
    }
}

#pragma mark - getter

-(LoginView *)loginView
{
    if (_loginView == nil) {
        _loginView = [[LoginView alloc] initWithViewManager:self.loginViewManager];
    }
    return _loginView;
}

-(LoginViewManager *)loginViewManager
{
    if (_loginViewManager == nil) {
        _loginViewManager = [[LoginViewManager alloc] init];
    }
    return _loginViewManager;
}

-(SCLoginViewModel *)loginViewModel
{
    if (_loginViewModel == nil) {
        _loginViewModel = [[SCLoginViewModel alloc] init];
    }
    return _loginViewModel;
}

-(TXLivePush *)txLivePush
{
    if (_txLivePush == nil) {
        _txLivePush = [[TXLivePush alloc] initWithConfig:[[TXLivePushConfig alloc] init]];
    }
    return _txLivePush;
}

@end
