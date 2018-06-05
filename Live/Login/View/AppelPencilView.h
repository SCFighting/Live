//
//  AppelPencilView.h
//  Live
//
//  Created by SC on 2018/6/5.
//  Copyright © 2018年 SC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppelPencilView : UIView
//所有线条信息
@property(nonatomic,strong) NSMutableArray  *allMyDrawPaletteLineInfos;
//从外部传递的 笔刷长度和宽度，在包含画板的VC中 要是颜色、粗细有所改变 都应该将对应的值传进来
@property (nonatomic,strong)UIColor *currentPaintBrushColor;
@property (nonatomic)float currentPaintBrushWidth;

//外部调用的清空画板和撤销上一步
- (void)cleanAllDrawBySelf;//清空画板
- (void)cleanFinallyDraw;//撤销上一条线条



@end
