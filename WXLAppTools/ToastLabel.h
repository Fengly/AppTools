//
//  ToastLabel.h
//  原生定位
//
//  Created by Riches on 16/7/23.
//  Copyright © 2016年 Riches. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface ToastLabel : UILabel

- (void)setMessageText:(NSString *)text;

@end

@interface Toast : NSObject {
    ToastLabel *toastLabel;
    NSTimer *counTimer;
    CGFloat changeCount;
}

// 创建声明单例方法
+ (instancetype)shareInstanceToast;

- (void)makeToast:(NSString *)message duration:(CGFloat)duration;

- (void)dismiss;

@end
