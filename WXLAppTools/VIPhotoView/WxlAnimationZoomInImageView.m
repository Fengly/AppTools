//
//  WxlAnimationZoomInImageView.m
//  VIPhotoViewDemo
//
//  Created by Riches on 16/7/28.
//  Copyright © 2016年 vito. All rights reserved.
//

#import "WxlAnimationZoomInImageView.h"
#import "WxlZoomInImageView.h"

@interface WxlAnimationZoomInImageView ()

@property (nonatomic, retain) WxlZoomInImageView *zoomView;

@end

@implementation WxlAnimationZoomInImageView


- (instancetype)initZoonInImageViewWithFrame:(CGRect)fram ImageUrlArr:(NSArray *)array {
    self = [super initWithFrame:fram];
    
    if (self) {
        
        self.zoomView = [[WxlZoomInImageView alloc] initZoonInImageViewWithFrame:fram ImageUrlArr:array];
        [self addSubview:_zoomView];
        
        [self show];
        
        __weak typeof(self) weakSelf = self;
        _zoomView.block = ^{
            
            [weakSelf dismiss];
        };
    }
    return self;
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    
    [self dismiss];
}

- (void)show {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [window addSubview:self];
//    self.transform = CGAffineTransformMakeScale(0, 0);
    [UIView animateWithDuration:.3 animations:^{
//        self.transform = CGAffineTransformIdentity;
    }];
}

- (void)dismiss{
    self.blockChangeUser();
    
//    self.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:.5 animations:^{
//        self.transform = CGAffineTransformMakeScale(0.00001, 0.00001);
        
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
