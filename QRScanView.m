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

@interface QRScanView ()

@property (nonatomic,strong) CAShapeLayer *scanBgLayer;

@property (nonatomic,strong) CAShapeLayer *scanRectLayer;

@property (nonatomic,strong) UIImageView *scanLineImgView;

@property (nonatomic,assign) BOOL lineScan;

@end

@implementation QRScanView

- (void)setScanRect:(CGRect)scanRect
{
    _scanRect = scanRect;
    
    if (_scanBgLayer == nil)
    {
        _scanBgLayer = [[CAShapeLayer alloc] init];
        
        [self.layer addSublayer:_scanBgLayer];
        
        _scanRectLayer = [[CAShapeLayer alloc] init];
        
        [self.layer addSublayer:_scanRectLayer];
        
        _lineScan = YES;
        
        _scanLineImgView = [[UIImageView alloc] init];
        
        _scanLineImgView.image = [UIImage imageNamed:@"icon_saoyisao_line"];
        
        [self addSubview:_scanLineImgView];
    }
    
    [self layoutScan];
}

- (void)dealloc
{
    [self lineStopMove];
}

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
    
    _scanBgLayer.fillColor = [[UIColor blackColor] colorWithAlphaComponent:0.7].CGColor;
    
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


- (void)lineStartMove
{
    [self lineScanAnimated];
}

- (void)lineStopMove
{
    _scanLineImgView.alpha = 0;
    
    _lineScan = NO;
    
    [UIView setAnimationDelegate:nil];
}

//扫描线
- (void)lineScanAnimated
{
    _scanLineImgView.alpha = 1;

    CGFloat x = _scanRect.origin.x;
    
    CGFloat y = _scanRect.origin.y;
    
    CGFloat w = _scanRect.size.width;
    
    CGFloat h = _scanRect.size.height;
    
    _scanLineImgView.frame = CGRectMake(x, y, w, 2);
    
    [UIView animateWithDuration:3 animations:^{
        
        _scanLineImgView.frame = CGRectMake(x, y + h, w, 2);
        
    } completion:^(BOOL finished) {
        
        if (_lineScan)
        {
            [self lineScanAnimated];
        }
    }];
}

@end
