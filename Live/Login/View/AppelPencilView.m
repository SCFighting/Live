//
//  AppelPencilView.m
//  Live
//
//  Created by SC on 2018/6/5.
//  Copyright © 2018年 SC. All rights reserved.
//

#import "AppelPencilView.h"
#import "DrawLineInfo.h"

@implementation AppelPencilView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _allMyDrawPaletteLineInfos = [[NSMutableArray alloc] initWithCapacity:10];
        self.currentPaintBrushColor = [UIColor blackColor];
        self.backgroundColor = [UIColor clearColor];
        self.currentPaintBrushWidth =  1.0f;
    }
    return self;
    
}


#pragma  mark - draw event
//根据现有的线条 绘制相应的图画
- (void)drawRect:(CGRect)rect  {
    
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinRound);

    
    
    
    
    
    if (_allMyDrawPaletteLineInfos.count>0) {
        for (int oneTeamLine = 0; oneTeamLine < self.allMyDrawPaletteLineInfos.count;oneTeamLine++) {
            NSMutableArray *oneTeamLineInfoArry = self.allMyDrawPaletteLineInfos[oneTeamLine];
            
            for (int i=0; i<[oneTeamLineInfoArry count]; i++) {
                DrawLineInfo *info = oneTeamLineInfoArry[i];
                
                CGContextBeginPath(context);
                CGPoint myStartPoint=[[info.linePoints objectAtIndex:0] CGPointValue];
                CGContextMoveToPoint(context, myStartPoint.x, myStartPoint.y);
                
                if (info.linePoints.count>1) {
                    for (int j=0; j<[info.linePoints count]-1; j++) {
                        CGPoint myEndPoint=[[info.linePoints objectAtIndex:j+1] CGPointValue];
                        CGContextAddLineToPoint(context, myEndPoint.x,myEndPoint.y);
                    }
                }else {
                    CGContextAddLineToPoint(context, myStartPoint.x,myStartPoint.y);
                }
                CGContextSetStrokeColorWithColor(context, info.lineColor.CGColor);
                CGContextSetLineWidth(context, info.lineWidth+1);
                CGContextStrokePath(context);
            }
            
            
            
        }
        
        
        
    }
}


#pragma mark - touch event
//触摸开始
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch* touch=[touches anyObject];
    
    if (@available(iOS 9.0, *)) {
        [self drawPaletteTouchesBeganWithWidth:touch.force * 4 andColor:self.currentPaintBrushColor andBeginPoint:[touch locationInView:self ]];
    } else {
        // Fallback on earlier versions
    }
    [self setNeedsDisplay];
}
//触摸移动
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    NSArray* MovePointArray=[touches allObjects];
    UITouch *touch = [touches anyObject];
    if (@available(iOS 9.0, *)) {
        [self drawPaletteTouchesMovedWithPonit:[[MovePointArray objectAtIndex:0] locationInView:self] width:touch.force * 4];
    } else {
        // Fallback on earlier versions
    }
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
}


#pragma mark draw info edite event
//在触摸开始的时候 添加一条新的线条 并初始化
- (void)drawPaletteTouchesBeganWithWidth:(float)width andColor:(UIColor *)color andBeginPoint:(CGPoint)bPoint {
    NSMutableArray *oneTeamLineInfo = [[NSMutableArray alloc] init];
    DrawLineInfo *info = [DrawLineInfo new];
    info.lineColor = color;
    info.lineWidth = width;
    [info.linePoints addObject:[NSValue valueWithCGPoint:bPoint]];
    [oneTeamLineInfo addObject:info];
    [self.allMyDrawPaletteLineInfos addObject:oneTeamLineInfo];
}

//在触摸移动的时候 将现有的线条的最后一条的 point增加相应的触摸过的坐标
- (void)drawPaletteTouchesMovedWithPonit:(CGPoint)mPoint width:(CGFloat)width{
    NSMutableArray *oneTeamLineInfo = [self.allMyDrawPaletteLineInfos lastObject];
    DrawLineInfo *lastInfo = [oneTeamLineInfo lastObject];
    if (lastInfo.lineWidth == width) {
        [lastInfo.linePoints addObject:[NSValue valueWithCGPoint:mPoint]];
    }else
    {
        DrawLineInfo *info = [DrawLineInfo new];
        info.lineColor = [UIColor blackColor];
        info.lineWidth = width;
        [info.linePoints addObject:lastInfo.linePoints.lastObject];
        [info.linePoints addObject:[NSValue valueWithCGPoint:mPoint]];
        [oneTeamLineInfo addObject:info];
    }
    
}

- (void)cleanAllDrawBySelf {
    if ([self.allMyDrawPaletteLineInfos count]>0)  {
        [self.allMyDrawPaletteLineInfos removeAllObjects];
        [self setNeedsDisplay];
    }
}

- (void)cleanFinallyDraw {
    if ([self.allMyDrawPaletteLineInfos count]>0) {
        [self.allMyDrawPaletteLineInfos  removeLastObject];
    }
    [self setNeedsDisplay];
}

@end
