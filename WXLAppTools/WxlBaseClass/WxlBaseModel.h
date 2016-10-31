//
//  WxlBaseModel.h
//  Base
//
//  Created by Riches on 16/5/28.
//  Copyright © 2016年 Riches. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WxlBaseModel : NSObject

/** 应用该类可 */

/** 用字典初始化model */
- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)modelWithDic:(NSDictionary *)dic;

+ (NSMutableArray *)modelHandelWithArray:(NSArray *)array;

@end
