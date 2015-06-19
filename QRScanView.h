//
//  QRScanView.h
//  CocoaPodsDemo
//
//  Created by 杨志达 on 15/6/18.
//  Copyright (c) 2015年 杨志达. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QRScanView : UIView

@property (nonatomic,assign) CGRect scanRect;

- (void)lineStartMove;

- (void)lineStopMove;

@end
