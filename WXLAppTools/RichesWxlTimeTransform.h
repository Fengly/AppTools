//
//  RichesWxlTimeTransform.h
//  Fabric
//
//  Created by Riches on 16/6/14.
//  Copyright © 2016年 Riches. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kTimeFormat12 @"YYYY-MM-dd-hh" // 普通计时法
#define kTimeFormat24 @"YYYY-MM-dd-HH" // 24时计时法
#define kTimeFormatD @"YYYY-MM-dd"
#define kTimeFormat24s @"YYYY-MM-dd-HH-mm-ss" // 24时计时法

@interface RichesWxlTimeTransform : NSObject

/******************* 这里使用的是北京时间 ******************/

/**
 *  获取当前时间和时间抽
 *
 *  @param timeFormatStr 选择的时间计时法（用宏kTimeFormat12 || kTimeFormat24）
 *  @param timeStr       当前时间
 *  @param timestampStr  当前时间时间戳
 */
+ (void)wxlTimeTransformWithFormat:(NSString *)timeFormatStr
                              time:(void(^)(NSString *timeStr))timeStr
                         timestamp:(void(^)(NSString *timestampStr))timestampStr;

/**
 *  时间戳
 *
 *  @param timestampStr 时间戳
 */
+ (void)wxlTimestampWithTimestamp:(void(^)(NSString *timestampStr))timestampStr;


/**
 *  时间戳转时间
 *
 *  @param timestampStr  要转换成时间的时间戳
 *  @param timeFormatStr 选择的时间计时法（用宏kTimeFormat12 || kTimeFormat24）
 *
 *  @return 转换成的时间
 */
+ (NSString *)wxlTurnTimeWithTimestamp:(NSString *)timestampStr timeFormat:(NSString *)timeFormatStr;


@end
