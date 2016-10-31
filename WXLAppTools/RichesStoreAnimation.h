//
//  RichesStoreAnimation.h
//  RichesStore
//
//  Created by Riches on 16/7/16.
//  Copyright © 2016年 Riches. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RichesStoreAnimation : UIView

+ (RichesStoreAnimation *)createAnimationViewWithFram:(CGRect)rect superView:(UIView *)view;

- (void)removeSuperViewLetAnimationWithSubView:(UIView *)subView;

- (void)animationWithView:(RichesStoreAnimation *)view;
@end
