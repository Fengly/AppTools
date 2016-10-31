//
//  KeychainTool.h
//  FenglyNuo
//
//  Created by FenglyNuo on 16/6/24.
//  Copyright © 2016年 Riches. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeychainTool : NSObject

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service ;

+ (void)save:(NSString *)service data:(id)data ;

+ (id)load:(NSString *)service ;

+ (void)delete:(NSString *)service ;

@end
