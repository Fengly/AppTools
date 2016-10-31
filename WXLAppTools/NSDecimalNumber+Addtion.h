//
//  NSDecimalNumber+Addtion.h
//
//  Created by Riches on 16/8/27.
//  Copyright © 2016年 FenglyNuo. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, type) {
    Add,
    subtract,
    multiply,
    divide
};
@interface NSDecimalNumber (Addtion)

/**
 *  显示小数点后位数
 *
 *  @param price    需要转换成字符串的 NSDecimalNumber 对象
 *  @param position 小数点后位数
 *
 *  @return 结果字符串
 */
+ (NSString *)notRounding:(NSDecimalNumber *)price afterPoint:(NSInteger)position;

/**
 *  两个数字字符串运算
 *
 *  @param num1 第一个字符串
 *  @param type 运算方法
 *  @param num2 第二个字符串
 *
 *  @return 运算结果
 */
+ (NSDecimalNumber *)aDecimalNumberWithString:(NSString *)num1 type:(type)type anotherDecimalNumberWithString:(NSString *)num2;

/**
 *  两个数字字符串之间的比较
 *
 *  @param num1 第一个参与对象
 *  @param num2 第二个参与对象
 *
 *  @return 比较结果
 */
+ (NSComparisonResult)aDecimalNumberWithString:(NSString *)num1 compareAnotherDecimalNumberWithString:(NSString *)num2;

/**
 *  两个 NSNumber 类型之间的运算
 *
 *  @param num1 第一个NSNumber类型
 *  @param type 运算方法
 *  @param num2 第二个NSNumber类型
 *
 *  @return 运算结果
 */
+ (NSDecimalNumber *)aDecimalNumberWithNumber:(NSNumber *)num1 type:(type)type anotherDecimalNumberWithNumber:(NSNumber *)num2;

/**
 *  两个 NSNumber 类型之间的比较
 *
 *  @param num1 第一个参与对象
 *  @param num2 第二个参与对象
 *
 *  @return 比较结果
 */
+ (NSComparisonResult)aDecimalNumberWithNumber:(NSNumber *)num1 compareAnotherDecimalNumberWithNumber:(NSNumber *)num2;
@end
