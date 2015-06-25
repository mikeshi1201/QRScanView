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

- (void)QRScanEngine:(QRScanEngine *)engine output:(NSString *)output;

@end

@interface QRScanEngine : NSObject

@property (nonatomic,weak) id<QRScanEngineDelegate>delegate;

- (void)startInView:(UIView *)view;

- (void)stop;

@end
