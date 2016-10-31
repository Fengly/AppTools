//
//  PassWordTool.m
//  FenglyNuo
//
//  Created by FenglyNuo on 16/6/24.
//  Copyright © 2016年 Riches. All rights reserved.
//

#import "PassWordTool.h"
#import "KeychainTool.h"

@implementation PassWordTool
static NSString * const KEY_IN_KEYCHAIN = @"com.RichesStore.app.userid";
static NSString * const KEY_PASSWORD = @"com.RichesStore.app.password";

+(void)savePassWord:(NSString *)password
{
    NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
    [usernamepasswordKVPairs setObject:password forKey:KEY_PASSWORD];
    [KeychainTool save:KEY_IN_KEYCHAIN data:usernamepasswordKVPairs];
}

+(id)readPassWord
{
    NSMutableDictionary *usernamepasswordKVPair = (NSMutableDictionary *)[KeychainTool load:KEY_IN_KEYCHAIN];
    return [usernamepasswordKVPair objectForKey:KEY_PASSWORD];
}

+(void)deletePassWord
{
    [KeychainTool delete:KEY_IN_KEYCHAIN];
}
@end
