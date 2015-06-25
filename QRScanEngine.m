//
//  QRScanEngine.m
//  QRScanView
//
//  Created by 杨志达 on 15/6/25.
//  Copyright (c) 2015年 杨志达. All rights reserved.
//

#import "QRScanEngine.h"

#import <AVFoundation/AVFoundation.h>

static char *const kAVCaptureMetadataOutputQueue = "kAVCaptureMetadataOutputQueue";

@interface QRScanEngine ()<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic,strong) AVCaptureSession *cSession;

@end

@implementation QRScanEngine

- (void)scanInitInView:(UIView *)view
{
    //扫描引擎
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:nil];
    
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    
    _cSession = [[AVCaptureSession alloc] init];
    
    [_cSession addInput:input];
    
    [_cSession addOutput:output];
    
    dispatch_queue_t outputQueue;
    
    outputQueue = dispatch_queue_create(kAVCaptureMetadataOutputQueue, DISPATCH_QUEUE_SERIAL);
    
    [output setMetadataObjectsDelegate:self queue:outputQueue];
    
    [output setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    
    //扫描UI层
    AVCaptureVideoPreviewLayer *pLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_cSession];
    
    [pLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
    [pLayer setFrame:view.layer.bounds];
    
    [view.layer addSublayer:pLayer];
}

- (void)startInView:(UIView *)view
{
    if (_cSession == nil)
    {
        [self scanInitInView:view];
    }

    [_cSession startRunning];
}

- (void)stop
{
    [_cSession stopRunning];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects.count > 0)
    {
        AVMetadataMachineReadableCodeObject *metadataObj = metadataObjects.firstObject;
        
        if ([metadataObj.type isEqualToString:AVMetadataObjectTypeQRCode])
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if ([_delegate respondsToSelector:@selector(QRScanEngine:output:)])
                {
                    [_delegate QRScanEngine:self output:metadataObj.stringValue];
                }
                
            });
        }
    }
}

@end
