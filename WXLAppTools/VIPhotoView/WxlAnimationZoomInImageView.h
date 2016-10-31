//
//  WxlAnimationZoomInImageView.h
//  VIPhotoViewDemo
//
//  Created by Riches on 16/7/28.
//  Copyright © 2016年 vito. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WxlAnimationZoomInImageView : UIView

// 外部调用接口
- (instancetype)initZoonInImageViewWithFrame:(CGRect)fram ImageUrlArr:(NSArray *)array;

- (void)show;


@property (nonatomic, copy) void(^blockChangeUser)(void); /**< 改变用户交互  该block方法 即使不调用 也要 声明*/

@end
