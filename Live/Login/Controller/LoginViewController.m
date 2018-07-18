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
#import <OpenGLES/ES3/gl.h>


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
        [self.txLivePush startPush:@"rtmp://aliyunpush.renrenjiang.cn/alilive/1388905565?vhost=seclive.renrenjiang.cn&auth_key=1563417961-0-0-f6fc74adcfce62e2f973d97991fc0444&isPortrait=0&u=970526&apptype=apple"];
        [self.txLivePush setBeautyStyle:BEAUTY_STYLE_PITU beautyLevel:9.0 whitenessLevel:9.0 ruddinessLevel:9.0];
    }];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
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
    GLuint sourceTexture = [self setupTexture:[UIImage imageNamed:@"dog"]];



    GLuint fbo;
    glGenFramebuffers(1,&fbo);
    /// bind the FBO
    glBindFramebuffer(GL_READ_FRAMEBUFFER, fbo);
    /// attach the source texture to the fbo
    glFramebufferTexture2D(GL_READ_FRAMEBUFFER, GL_COLOR_ATTACHMENT0,
                           GL_TEXTURE_2D, sourceTexture, 0);

    /// bind the destination texture
    glBindTexture(GL_TEXTURE_2D, texture);
//    /// copy from framebuffer (here, the FBO!) to the bound texture
    glCopyTexSubImage2D(GL_TEXTURE_2D, 0, 0, 0, 0, 0, width,height);
    /// unbind the FBO
    glBindFramebuffer(GL_FRAMEBUFFER, 0);
    glBindTexture(GL_TEXTURE_2D,0);
    glDeleteFramebuffers(1, &fbo);




//    GGLog(@"width=%.2f,height=%.2f",width,height);
    glDeleteTextures(1, &sourceTexture);

    return texture;
}

- (void)onTextureDestoryed
{
    NSLog(@"##############");
}

/**
 *  加载image, 使用CoreGraphics将位图以RGBA格式存放. 将UIImage图像数据转化成OpenGL ES接受的数据.
 *  然后在GPU中将图像纹理传递给GL_TEXTURE_2D。
 *  @return 返回的是纹理对象，该纹理对象暂时未跟GL_TEXTURE_2D绑定（要调用bind）。
 *  即GL_TEXTURE_2D中的图像数据都可从纹理对象中取出。
 */
- (GLuint)setupTexture:(UIImage *)image {
    CGImageRef cgImageRef = [image CGImage];
    GLuint width = (GLuint)CGImageGetWidth(cgImageRef)*0.25;
    GLuint height = (GLuint)CGImageGetHeight(cgImageRef)*0.25;
    CGRect rect = CGRectMake(0, 0, width, height);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    void *imageData = malloc(width * height * 4);
    CGContextRef context = CGBitmapContextCreate(imageData, width, height, 8, width * 4, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
//    CGContextTranslateCTM(context, 0, height);
//    CGContextScaleCTM(context, 1.0f, -1.0f);
    CGColorSpaceRelease(colorSpace);
    CGContextClearRect(context, rect);
    CGContextDrawImage(context, rect, cgImageRef);
    
    glEnable(GL_TEXTURE_2D);
    
    /**
     *  GL_TEXTURE_2D表示操作2D纹理
     *  创建纹理对象，
     *  绑定纹理对象，
     */
    
    GLuint textureID;
    glGenTextures(1, &textureID);
    glBindTexture(GL_TEXTURE_2D, textureID);
    
    /**
     *  纹理过滤函数
     *  图象从纹理图象空间映射到帧缓冲图象空间(映射需要重新构造纹理图像,这样就会造成应用到多边形上的图像失真),
     *  这时就可用glTexParmeteri()函数来确定如何把纹理象素映射成像素.
     *  如何把图像从纹理图像空间映射到帧缓冲图像空间（即如何把纹理像素映射成像素）
     */
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE); // S方向上的贴图模式
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE); // T方向上的贴图模式
    // 线性过滤：使用距离当前渲染像素中心最近的4个纹理像素加权平均值
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    
    /**
     *  将图像数据传递给到GL_TEXTURE_2D中, 因其于textureID纹理对象已经绑定，所以即传递给了textureID纹理对象中。
     *  glTexImage2d会将图像数据从CPU内存通过PCIE上传到GPU内存。
     *  不使用PBO时它是一个阻塞CPU的函数，数据量大会卡。
     */
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, imageData);
    
    // 结束后要做清理
    glBindTexture(GL_TEXTURE_2D, 0); //解绑
    CGContextRelease(context);
    free(imageData);
    
    return textureID;
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
        TXLivePushConfig *config = [[TXLivePushConfig alloc] init];
        config.beautyFilterDepth = 9.0;
        config.whiteningFilterDepth = 9.0;
        config.frontCamera = NO;
        _txLivePush = [[TXLivePush alloc] initWithConfig:config];
        _txLivePush.videoProcessDelegate = self;
    }
    return _txLivePush;
}

@end
