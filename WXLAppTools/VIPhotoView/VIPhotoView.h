//
//  VIPhotoView.h
//
//  Created by Riches on 16/7/28.
//  Copyright © 2016年 vito. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VIPhotoView : UIScrollView

- (instancetype)initWithFrame:(CGRect)frame andImage:(UIImage *)image;

- (void)tapHandler:(UITapGestureRecognizer *)recognizer;
- (void)becomeMin;

@property (nonatomic, copy) void(^block)(void);

@end
