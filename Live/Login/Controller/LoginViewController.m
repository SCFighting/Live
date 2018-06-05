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
#import <Social/Social.h>
#import "AppelPencilView.h"

@interface LoginViewController ()<TXVideoCustomProcessDelegate>
@property (nonatomic , strong ) LoginView *loginView;
@property (nonatomic , strong ) LoginViewManager *loginViewManager;
@property (nonatomic , strong ) SCLoginViewModel *loginViewModel;
@property (nonatomic , strong ) TXLivePush *txLivePush;
@property (nonatomic , strong ) AppelPencilView *pencilView;
@property (nonatomic , strong ) UIButton *resetButton;
@end

@implementation LoginViewController

-(void)loadView
{
    [super loadView];
//    [self.view addSubview:self.loginView];
//    [self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(self.view);
//    }];
    [self.view addSubview:self.pencilView];
    [self.view addSubview:self.resetButton];
    [self.pencilView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.resetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(60, 40));
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    @weakify(self);
//    [self.loginViewModel loginWithSuccess:^(id response) {
//        //请求推流地址
//        @strongify(self);
//        [self.loginView removeFromSuperview];
//        self.loginView = nil;
//        [self.txLivePush startPreview:self.view];
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)dealloc
{
    GGLog(@"%s",__func__);
    if (self.loginViewModel.requestArray.count > 0) {
        [self.loginViewModel cancelAllRequest];
    }
}

#pragma mark - TXVideoCustomProcessDelegate

-(GLuint)onPreProcessTexture:(GLuint)texture width:(CGFloat)width height:(CGFloat)height
{
    return texture;
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
        _txLivePush.videoProcessDelegate = self;
    }
    return _txLivePush;
}

-(AppelPencilView *)pencilView
{
    if (_pencilView == nil) {
        _pencilView = [[AppelPencilView alloc] initWithFrame:CGRectZero];
    }
    return _pencilView;
}

-(UIButton *)resetButton
{
    if (_resetButton == nil) {
        _resetButton = [[UIButton alloc] init];
        [_resetButton setTitle:@"恢复" forState:UIControlStateNormal];
        [_resetButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [[_resetButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [self.pencilView cleanFinallyDraw];
        }];
    }
    return _resetButton;
}

@end
