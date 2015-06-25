//
//  QRScanView.m
//  CocoaPodsDemo
//
//  Created by 杨志达 on 15/6/18.
//  Copyright (c) 2015年 杨志达. All rights reserved.
//

#import "QRScanView.h"

#define rect_w 4

#define rect_w_2 2

#define rect_h 16

static NSString *const kLineScanAnimated = @"kLineScanAnimated";

@interface QRScanView ()

@property (nonatomic,strong) CAShapeLayer *scanBgLayer;

@property (nonatomic,strong) CAShapeLayer *scanRectLayer;

@property (nonatomic,strong) UIImageView *scanLineImgView;

@property (nonatomic,assign) BOOL lineScan;

@end

@implementation QRScanView

/**
 *  设置扫描框大小，初始化layer
 *
 *  @param scanRect 扫描框大小
 */
- (void)setScanRect:(CGRect)scanRect
{
    _scanRect = scanRect;
    
    if (_scanBgLayer == nil || _scanRectLayer == nil || _scanLineImgView == nil)
    {
        _scanBgLayer = [[CAShapeLayer alloc] init];
        
        [self.layer addSublayer:_scanBgLayer];
        
        _scanRectLayer = [[CAShapeLayer alloc] init];
        
        [self.layer addSublayer:_scanRectLayer];
        
        _lineScan = YES;
        
        _scanLineImgView = [[UIImageView alloc] init];
        
        _scanLineImgView.image = [UIImage imageNamed:@"icon_saoyisao_line"];
        
        [self addSubview:_scanLineImgView];
        
        [self layoutScan];
    }
}

- (void)dealloc
{
    [self lineStopMove];
}

/**
 *  画背景和扫描框
 */
- (void)layoutScan
{
    //背景阴影描线
    UIBezierPath *scanPath = [[UIBezierPath alloc] init];
    
    CGFloat x = _scanRect.origin.x;
    
    CGFloat y = _scanRect.origin.y;
    
    CGFloat w = _scanRect.size.width;
    
    CGFloat h = _scanRect.size.height;
    
    CGFloat sw = self.frame.size.width;
    
    CGFloat sh = self.frame.size.height;
    
    //内圈
    [scanPath moveToPoint:CGPointMake(x, y)];
    
    [scanPath addLineToPoint:CGPointMake(x + w, y)];
    
    [scanPath addLineToPoint:CGPointMake(x + w, y + h)];
    
    [scanPath addLineToPoint:CGPointMake(x, y + h)];
    
    [scanPath closePath];
    
    //外圈
    [scanPath moveToPoint:CGPointMake(0, 0)];
    
    [scanPath addLineToPoint:CGPointMake(sw, 0)];
    
    [scanPath addLineToPoint:CGPointMake(sw, sh)];
    
    [scanPath addLineToPoint:CGPointMake(0, sh)];
    
    [scanPath closePath];
    
    //填充
    _scanBgLayer.fillRule = kCAFillRuleEvenOdd;
    
    _scanBgLayer.fillColor = [[UIColor blackColor] colorWithAlphaComponent:0.3].CGColor;
    
    _scanBgLayer.path = scanPath.CGPath;
    
    //四角边框 宽度为4 长度15
    UIBezierPath *scanRectPath = [[UIBezierPath alloc] init];

    //左上
    [scanRectPath moveToPoint:CGPointMake(x + rect_w_2, y + rect_h)];
    
    [scanRectPath addLineToPoint:CGPointMake(x + rect_w_2, y + rect_w_2)];

    [scanRectPath addLineToPoint:CGPointMake(x + rect_h, y + rect_w_2)];

    //右上
    [scanRectPath moveToPoint:CGPointMake(x + w - rect_h, y + rect_w_2)];
    
    [scanRectPath addLineToPoint:CGPointMake(x + w - rect_w_2, y + rect_w_2)];
    
    [scanRectPath addLineToPoint:CGPointMake(x + w - rect_w_2, y + rect_h)];
    
    //右下
    [scanRectPath moveToPoint:CGPointMake(x + w - rect_w_2, y + h - rect_h)];
    
    [scanRectPath addLineToPoint:CGPointMake(x + w - rect_w_2, y + h - rect_w_2)];
    
    [scanRectPath addLineToPoint:CGPointMake(x + w - rect_h, y + h - rect_w_2)];
    
    //左下
    [scanRectPath moveToPoint:CGPointMake(x + rect_h, y + h - rect_w_2)];
    
    [scanRectPath addLineToPoint:CGPointMake(x + rect_w_2, y + h - rect_w_2)];
    
    [scanRectPath addLineToPoint:CGPointMake(x + rect_w_2, y + h - rect_h)];
    
    //填充
    _scanRectLayer.fillColor = [UIColor clearColor].CGColor;
    
    _scanRectLayer.strokeColor = self.tintColor.CGColor;
    
    _scanRectLayer.lineWidth = rect_w;
    
    _scanRectLayer.path = scanRectPath.CGPath;
}

/**
 *  动画开始
 */
- (void)lineStartMove
{
    CGFloat x = _scanRect.origin.x;
    
    CGFloat y = _scanRect.origin.y;
    
    CGFloat w = _scanRect.size.width;

    CGFloat h = _scanRect.size.height;

    _scanLineImgView.frame = CGRectMake(x, y, w, 2);
    
    [_scanLineImgView.layer addAnimation:[self lineScanAnimatedWithY:h] forKey:kLineScanAnimated];
}

/**
 *  动画结束
 */
- (void)lineStopMove
{
    [_scanLineImgView.layer removeAnimationForKey:kLineScanAnimated];
}

/**
 *  垂直移动动画
 *
 *  @return 返回动画对象
 */
- (CABasicAnimation *)lineScanAnimatedWithY:(CGFloat)y
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    
    animation.toValue = [NSNumber numberWithFloat:y];
    
    animation.duration = 3;
    
    animation.repeatCount = MAXFLOAT;
    
    animation.removedOnCompletion = YES;

    return animation;
}

@end
