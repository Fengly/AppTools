//
//  ToastLabel.m
//  原生定位
//
//  Created by Riches on 16/7/23.
//  Copyright © 2016年 Riches. All rights reserved.
//

#import "ToastLabel.h"

#define DeviceWidth [UIScreen mainScreen].bounds.size.width
#define DeviceHeight [UIScreen mainScreen].bounds.size.height

@implementation ToastLabel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.layer.cornerRadius = 8;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor colorWithRed:41 / 255 green:41 / 255 blue:41 / 255 alpha:1];
        self.numberOfLines = 0;
        self.textAlignment = NSTextAlignmentCenter;
        self.textColor = [UIColor whiteColor];
        self.font = [UIFont systemFontOfSize:15];
        if (Iphone4) {
            self.font = [UIFont systemFontOfSize:11];
        }
        if (Iphone5) {
            self.font = [UIFont systemFontOfSize:11];
        }
    }
    return self;
}


- (void)setMessageText:(NSString *)text {
    [self setText:text];
    CGRect rect = [self.text boundingRectWithSize:CGSizeMake(DeviceWidth - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.font} context:nil];
    CGFloat width = rect.size.width + 20;
    CGFloat height = rect.size.height + 20;
    CGFloat x = (DeviceWidth - width) / 2;
    CGFloat y = (DeviceHeight - height) / 2;
    self.frame = CGRectMake(x, y, width, height);
}

@end

@implementation Toast

+ (instancetype)shareInstanceToast {
    static Toast *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[Toast alloc] init];
    });
    return singleton;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        toastLabel = [[ToastLabel alloc] init];
        counTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeTime:) userInfo:nil repeats:YES];
        counTimer.fireDate = [NSDate distantFuture]; // 关闭定时器
    }
    return self;
}

- (void)makeToast:(NSString *)message duration:(CGFloat)duration {
    if ([message length] == 0) {
        return;
    }
    [toastLabel setMessageText:message];
    [[[UIApplication sharedApplication] keyWindow] addSubview:toastLabel];
    toastLabel.alpha = 0.8;
    counTimer.fireDate = [NSDate distantPast]; // 开启定时器
    changeCount = duration;
    CABasicAnimation *pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pulse.duration = 0.1;
    pulse.repeatCount = 1;
    pulse.autoreverses = YES;
    pulse.fromValue = [NSNumber numberWithFloat:0.7];
    pulse.toValue = [NSNumber numberWithFloat:1.3];
    [[toastLabel layer]
     addAnimation:pulse forKey:nil];
}

- (void)dismiss {
    counTimer.fireDate = [NSDate distantFuture]; // 关闭定时器
    toastLabel.alpha = 0;
    [toastLabel removeFromSuperview];
}

- (void)changeTime:(NSTimer *)timer {
    if (changeCount-- <= 0) {
        counTimer.fireDate = [NSDate distantFuture]; // 关闭定时器
        [UIView animateWithDuration:0.3 animations:^{
            CABasicAnimation *pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            pulse.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
            pulse.duration = 0.3;
            pulse.repeatCount = 1;
            pulse.autoreverses = YES;
//            pulse.fromValue= [NSNumber numberWithFloat:1.2];
            pulse.toValue = [NSNumber numberWithFloat:0.5];
            [[toastLabel layer]
             addAnimation:pulse forKey:nil];
            toastLabel.alpha = 0;
        } completion:^(BOOL finished) {
            [toastLabel removeFromSuperview];
        }];
    }
}


@end
