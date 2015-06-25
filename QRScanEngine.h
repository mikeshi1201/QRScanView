//
//  QRScanEngine.h
//  QRScanView
//
//  Created by 杨志达 on 15/6/25.
//  Copyright (c) 2015年 杨志达. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@class QRScanEngine;

@protocol QRScanEngineDelegate <NSObject>

/**
 *  扫描结果
 *
 *  @param engine 引擎对象
 *  @param output 扫描结果
 */
- (void)QRScanEngine:(QRScanEngine *)engine output:(NSString *)output;

@end

@interface QRScanEngine : NSObject

@property (nonatomic,weak) id<QRScanEngineDelegate>delegate;

/**
 *  开始扫描
 *
 *  @param view 图像捕捉位置
 */
- (void)startInView:(UIView *)view;

/**
 *  结束扫描
 */
- (void)stop;

@end
