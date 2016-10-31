//
//  FenglyNuoMD5Tool.m
//  Fabric
//
//  Created by Riches on 16/6/24.
//  Copyright © 2016年 Riches. All rights reserved.
//

#import "FenglyNuoMD5Tool.h"
#import <CommonCrypto/CommonDigest.h>

@interface FenglyNuoMD5Tool ()

@end

@implementation FenglyNuoMD5Tool

// 简单的MD5加密
+ (NSString *)md5EasyString:(NSString *)str {
    const char *myPasswd = [str UTF8String];
    unsigned char mdc[16];
    CC_MD5(myPasswd, (CC_LONG)strlen(myPasswd), mdc);
    NSMutableString *md5String = [NSMutableString string];
    for (int i = 0; i < 16; i++) {
        [md5String appendFormat:@"%02x", mdc[i]];
    }
    return md5String;
}


// 复杂一些的MD5加密
+ (NSString *)md5ComplexString:(NSString *)str {
    const char *myPasswd = [str UTF8String];
    unsigned char mdc[16];
    CC_MD5 (myPasswd, (CC_LONG)strlen(myPasswd), mdc);
    NSMutableString *md5String = [NSMutableString string];
    [md5String appendFormat:@"%02x", mdc[0]];
    for (int i = 1; i < 16; i++) {
        [md5String appendFormat:@"%02x", mdc[i]^mdc[0]];
    }
    return md5String;
}

@end
