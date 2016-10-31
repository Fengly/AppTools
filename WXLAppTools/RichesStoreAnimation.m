//
//  RichesStoreAnimation.m
//  RichesStore
//
//  Created by Riches on 16/7/16.
//  Copyright © 2016年 Riches. All rights reserved.
//

#import "RichesStoreAnimation.h"

@interface RichesStoreAnimation ()



@end

@implementation RichesStoreAnimation


+ (RichesStoreAnimation *)createAnimationViewWithFram:(CGRect)rect superView:(UIView *)view {
    
    RichesStoreAnimation *groundView = [[RichesStoreAnimation alloc] initWithFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)];
    [view addSubview:groundView];
//    groundView.center = view.center;
//    groundView.backgroundColor = [UIColor whiteColor];
//    groundView.backgroundColor = RGBA(255, 255, 255, 0.5);
    
    return groundView;
}

- (void)removeSuperViewLetAnimationWithSubView:(UIView *)subView {
    
    [subView removeFromSuperview];
}

- (void)animationWithView:(RichesStoreAnimation *)view {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    // 旋转的起始值
    animation.fromValue = [NSNumber numberWithFloat:0];
    // 旋转的结束值
    // π 是180° 2π是360°
    animation.toValue = [NSNumber numberWithFloat:M_PI * 2];
    // 重复次数
    animation.repeatCount = NSIntegerMax;
    // 时间
    animation.duration = 1;
    // 是否自动回到原来的位置
    //    animation.autoreverses = YES;
    // 是否按照结束位置继续旋转
    animation.cumulative = YES;
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 45 * wt, 45 * wt)];
    img.image = [UIImage imageNamed:@"shen纽扣"];
    [view addSubview:img];
    img.center = view.center;
    [img.layer addAnimation:animation forKey:@"Animation"];
}







/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
