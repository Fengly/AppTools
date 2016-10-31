//
//  FenglyNuoMD5Tool.h
//  Fabric
//
//  Created by Riches on 16/6/24.
//  Copyright © 2016年 Riches. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FenglyNuoMD5Tool : NSObject

// 简单的MD5加密
+ ( NSString *)md5EasyString:( NSString *)str;

// 复杂一些的MD5加密
+ ( NSString *)md5ComplexString:( NSString *)str;

@end
