//
//  FenglyNuoScrollView.h
//
//  Created by Fengly on 16/1/28.
//  Copyright © 2016年 FenglyNuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FenglyNuoScrollViewDelegate <NSObject>


/**
 *  该代理方法可实现点击轮播中的图片跳转
 *
 *  @param index 轮播中图片的下标
 */
- (void)scrollViewClick:(NSInteger)index;

@end

typedef enum {
    scrollDirectionHorizontal = 0, /**< 横向轮播 */
    scrollDirectionVertical = 1,
} ScrollDirectionq;

@interface FenglyNuoScrollView : UIView

@property (nonatomic, assign) id<FenglyNuoScrollViewDelegate>delegate;

@property (nonatomic) ScrollDirectionq scrollDirectionq; /**< 设置轮播方式，默认横向轮播 */ //（然而并没有完成）
@property (nonatomic ,assign) CGFloat time; /**< 轮播时间间隔，默认不轮播 */

/**
 *  调用该block时需到 .m调用block
 */
//@property (nonatomic, copy) void(^blockClick)(NSInteger); /**< 点击轮播图时返回点击下标 */

/** 调用该方法实现轮播 网络加载图片 */
+(FenglyNuoScrollView *)fenglyNuoScrollViewWithImageUrlArray:(NSArray *)urlArray Frame:(CGRect)fram;

@end
