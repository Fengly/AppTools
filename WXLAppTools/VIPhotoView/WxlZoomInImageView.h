//
//  WxlZoomInImageView.h
//
//  Created by Riches on 16/7/28.
//  Copyright © 2016年 vito. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WxlZoomInImageView : UIView

- (instancetype)initZoonInImageViewWithFrame:(CGRect)fram ImageUrlArr:(NSArray *)array;

@property (nonatomic, copy) void(^block)(void);

@end
