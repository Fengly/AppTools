//
//  WxlBaseModel.m
//  Base
//
//  Created by Riches on 16/5/28.
//  Copyright © 2016年 Riches. All rights reserved.
//

#import "WxlBaseModel.h"

@interface WxlBaseModel ()

@property (nonatomic, retain) NSMutableDictionary *dictionary;

@end

@implementation WxlBaseModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (instancetype)modelWithDic:(NSMutableDictionary *)dic {
    NSArray *arr = [dic allKeys];
    if (!arr.count) {
        return Nil;
    }
    NSMutableDictionary *newDic = [NSMutableDictionary new];
    for (NSString *str in arr) {
        
        if ([dic[str]  isEqual:[NSNull null]]) {
            [newDic setValue:@" " forKeyPath:str];
        } else {
            [newDic setObject:dic[str] forKey:str];
        }
    }
    // [self class] 本类对象
    return [[[self class] alloc] initWithDic:newDic];
}

+ (NSMutableArray *)modelHandelWithArray:(NSArray *)array {
    NSMutableArray *arrModel = [NSMutableArray array];
    
    if ([array isEqual:[NSNull null]]) {
        array = nil;
    }
    if ([array isEqual:[NSString string]]) {
        array = nil;
    }
    if ([array isKindOfClass:[NSString class]]) {
        array = @[];
    }

    for (NSDictionary *dic in array) {
        
        id model = [[self class] modelWithDic:dic];
        [arrModel addObject:model];
    }
    return arrModel;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    
}

- (id)valueForUndefinedKey:(NSString *)key {
    
    
    return @"没有key";
}
//
//- (void)dealloc {
//    
//}

@end
