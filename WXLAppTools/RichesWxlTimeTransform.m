//
//  RichesWxlTimeTransform.m
//  Fabric
//
//  Created by Riches on 16/6/14.
//  Copyright © 2016年 Riches. All rights reserved.
//

#import "RichesWxlTimeTransform.h"

@implementation RichesWxlTimeTransform

+ (void)wxlTimestampWithTimestamp:(void (^)(NSString *))timestampStr {
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    timestampStr(timeSp);
}


+ (void)wxlTimeTransformWithFormat:(NSString *)timeFormatStr time:(void (^)(NSString *))timeStr timestamp:(void (^)(NSString *))timestampStr {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:timeFormatStr]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    //例如你在国内发布信息,用户在国外的另一个时区,你想让用户看到正确的发布时间就得注意时区设置,时间的换算.
    //例如你发布的时间为2010-01-26 17:40:50,那么在英国爱尔兰那边用户看到的时间应该是多少呢?
    //他们与我们有7个小时的时差,所以他们那还没到这个时间呢...那就是把未来的事做了
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
//    NSLog(@"timeSp = %@", timeSp);
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[datenow timeIntervalSince1970]];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    NSString *newTimeStr = [confromTimespStr substringToIndex:13];
    
    NSString *tempStr = [newTimeStr substringToIndex:11];
    NSString *hourStr = [newTimeStr substringFromIndex:11];
    NSInteger hour = [hourStr integerValue];
    if (hour > 12) {
        hour = hour - 12;
    }
    NSString *needStr = nil;
    if (hour >= 10) {
        needStr = [NSString stringWithFormat: @"%@"@"%ld", tempStr, hour];
    } else {
        needStr = [NSString stringWithFormat: @"%@"@"0%ld", tempStr, hour];
    }
    
    NSLog(@"%@ %@ %@", newTimeStr, hourStr, needStr);
    // 回调方法，返回当前的时间
    timeStr(needStr);
    // 回调方法，返回生成的时间戳
    timestampStr(timeSp);
}


+ (NSString *)wxlTurnTimeWithTimestamp:(NSString *)timestampStr timeFormat:(NSString *)timeFormatStr {

    NSTimeInterval time = [timestampStr doubleValue];
    NSDate *detaildate = [NSDate dateWithTimeIntervalSince1970:time];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [dateFormatter setTimeZone:timeZone];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:timeFormatStr];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
}

@end
