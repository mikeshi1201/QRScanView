//
//  ViewController.m
//  QRScanView
//
//  Created by 杨志达 on 15/6/18.
//  Copyright (c) 2015年 杨志达. All rights reserved.
//

#import "ViewController.h"

#import "QRScanView.h"

#import "QRScanEngine.h"

@interface ViewController ()<QRScanEngineDelegate,UIAlertViewDelegate>

@property (nonatomic,strong) QRScanEngine *sEngine;

@property (nonatomic,strong) QRScanView *QRSView;

@end

@implementation ViewController

#pragma mark - View life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self scanEngineInit];

    [self scanViewInit];
}

#pragma mark - Object initialize
- (void)scanViewInit
{
    //扫描框UI
    _QRSView = [[QRScanView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    CGFloat x = ([UIScreen mainScreen].bounds.size.width - 220)/2;
    
    _QRSView.scanRect = CGRectMake(x, x + 30, 220, 220);
    
    [self.view addSubview:_QRSView];
    
    [_QRSView lineStartMove];
}

- (void)scanEngineInit
{
    //扫描引擎
    _sEngine = [[QRScanEngine alloc] init];
    
    _sEngine.delegate = self;

    [_sEngine startInView:self.view];
}

#pragma mark - Delegate & Selector
- (void)QRScanEngine:(QRScanEngine *)engine output:(NSString *)output
{
    NSLog(@"%@",output);

    [_sEngine stop];
    
    [_QRSView lineStopMove];

    [[[UIAlertView alloc] initWithTitle:@"扫描结果" message:output delegate:self cancelButtonTitle:nil otherButtonTitles:@"开始扫描", nil] show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [_sEngine startInView:self.view];
    
    [_QRSView lineStartMove];
}

@end
