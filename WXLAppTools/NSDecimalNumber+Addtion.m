//
//  NSDecimalNumber+Addtion.m
//
//  Created by Riches on 16/8/27.
//  Copyright © 2016年 FenglyNuo. All rights reserved.
//

#import "NSDecimalNumber+Addtion.h"

@implementation NSDecimalNumber (Addtion)


+ (NSDecimalNumber *)aDecimalNumberWithString:(NSString *)num1 type:(type)type anotherDecimalNumberWithString:(NSString *)num2 {
    if (type == Add) {
        return [[NSDecimalNumber decimalNumberWithString:num1] decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:num2]];
    } else if (type == subtract) {
        return [[NSDecimalNumber decimalNumberWithString:num1] decimalNumberBySubtracting:[NSDecimalNumber decimalNumberWithString:num2]];
    } else if (type == multiply) {
        return [[NSDecimalNumber decimalNumberWithString:num1] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:num2]];
    } else if (type == divide) {
        return [[NSDecimalNumber decimalNumberWithString:num1] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:num2]];
    } else {
        return nil;
    }
    
}
+ (NSComparisonResult)aDecimalNumberWithString:(NSString *)num1 compareAnotherDecimalNumberWithString:(NSString *)num2 {
    return [[NSDecimalNumber decimalNumberWithString:num1] compare:[NSDecimalNumber decimalNumberWithString:num2]];
}

+(NSDecimalNumber *)aDecimalNumberWithNumber:(NSNumber *)num1 type:(type)type anotherDecimalNumberWithNumber:(NSNumber *)num2 {
    if (type == Add) {
        return [[NSDecimalNumber decimalNumberWithDecimal:[num1 decimalValue]] decimalNumberByAdding:[NSDecimalNumber decimalNumberWithDecimal:[num2 decimalValue]]];
    } else if (type == subtract) {
        return [[NSDecimalNumber decimalNumberWithDecimal:[num1 decimalValue]] decimalNumberBySubtracting:[NSDecimalNumber decimalNumberWithDecimal:[num2 decimalValue]]];
    } else if (type == multiply) {
        return [[NSDecimalNumber decimalNumberWithDecimal:[num1 decimalValue]] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithDecimal:[num2 decimalValue]]];
    } else if (type == divide) {
        return [[NSDecimalNumber decimalNumberWithDecimal:[num1 decimalValue]] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithDecimal:[num2 decimalValue]]];
    } else {
        return nil;
    }
}
+ (NSComparisonResult)aDecimalNumberWithNumber:(NSNumber *)num1 compareAnotherDecimalNumberWithNumber:(NSNumber *)num2 {
    return [[NSDecimalNumber decimalNumberWithDecimal:[num1 decimalValue]] compare:[NSDecimalNumber decimalNumberWithDecimal:[num2 decimalValue]]];
}

+ (NSString *)notRounding:(NSDecimalNumber *)price afterPoint:(NSInteger)position {
    NSDecimalNumberHandler *roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *roundedOunces;
    roundedOunces = [price decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    
    return [NSString stringWithFormat:@"%@",roundedOunces];
}


@end
