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

@interface LoginViewController ()<TXVideoCustomProcessDelegate>
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
    GGLog(@"%s",__func__);
    if (self.loginViewModel.requestArray.count > 0) {
        [self.loginViewModel cancelAllRequest];
    }
}

#pragma mark - TXVideoCustomProcessDelegate

-(GLuint)onPreProcessTexture:(GLuint)texture width:(CGFloat)width height:(CGFloat)height
{
//    GGLog(@"%s##texture=%uwidth=%fheight=%f",__func__,texture,width,height);
//    return texture;
    

    //转换为CGImage，获取图片基本参数
    CGImageRef cgImageRef = [[UIImage imageNamed:@"dog"] CGImage];
    GLuint Iwidth = (GLuint)CGImageGetWidth(cgImageRef);
    GLuint Iheight = (GLuint)CGImageGetHeight(cgImageRef);
    CGRect rect = CGRectMake(0, 0, Iwidth, Iheight);
    
    //绘制图片
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    void *imageData = malloc(Iwidth * Iheight * 4);
    CGContextRef context = CGBitmapContextCreate(imageData, Iwidth, Iheight, 8, Iwidth * 4, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGContextTranslateCTM(context, 0, Iheight);
    CGContextScaleCTM(context, 1.0f, -1.0f);
    CGColorSpaceRelease(colorSpace);
    CGContextClearRect(context, rect);
    CGContextDrawImage(context, rect, cgImageRef);
    //纹理一些设置，可有可无
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    
    //生成纹理
    glEnable(GL_TEXTURE_2D);
    GLuint textureID;
    glGenTextures(GL_TEXTURE_2D, &textureID);
    glBindTexture(GL_TEXTURE_2D, textureID);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, Iwidth, Iheight, 0, GL_RGBA, GL_UNSIGNED_BYTE, imageData);
    
    //绑定纹理位置
    glBindTexture(GL_TEXTURE_2D, 0);
    //释放内存
    CGContextRelease(context);
    free(imageData);
    
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

@end
