//
//  ViewController.m
//  QRScanView
//
//  Created by 杨志达 on 15/6/18.
//  Copyright (c) 2015年 杨志达. All rights reserved.
//

#import "ViewController.h"

#import "QRScanView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //二维码底图和扫描框UI
    QRScanView *QRSView = [[QRScanView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    CGFloat x = ([UIScreen mainScreen].bounds.size.width - 220)/2;
    
    QRSView.scanRect = CGRectMake(x, x + 30, 220, 220);
    
    [QRSView lineStartMove];
    
    [self.view addSubview:QRSView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
