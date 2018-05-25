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

@interface LoginViewController ()
@property (nonatomic , strong ) LoginView *loginView;
@property (nonatomic , strong ) LoginViewManager *loginViewManager;
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
    AppDelegate *app = [[AppDelegate alloc] init];
    app->_publicOne = @"dsge";
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    NSLog(@"%s",__func__);
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

@end
