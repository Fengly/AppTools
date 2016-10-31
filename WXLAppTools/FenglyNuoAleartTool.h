//
//  FenglyNuoAleartTool.h
//  Fabric
//
//  Created by Riches on 16/6/25.
//  Copyright © 2016年 Riches. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface FenglyNuoAleartTool : UIViewController

/**
 *  自定义aleart
 *
 *  @param str        信息
 *  @param controller 哪个Controllers跳转显示aleart （一般self）
 *
 *  @return 返回 UIAlertController *
 */
+ (id)judgeInfoIsNullWithStr:(NSString *)str controller:(UIViewController *)controller;

/**
 *  自定义aleart
 *
 *  @param str        点击可自动返回根视图
 *  @param controller 哪个Controllers跳转显示aleart （一般self）
 *
 *  @return 返回 UIAlertController *
 */
+ (id)judgeInfoIsNullForClickWithStr:(NSString *)str controller:(UIViewController *)controller;


@end
