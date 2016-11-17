//
//  FLNuoKeyboard.h
//  MyKeyBord
//
//  Created by Riches on 2016/11/16.
//  Copyright © 2016年 Riches. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger, FLNuoKeyboardType) {
    FLNuoKeyboardTypeCharsAndNumber = 0,
    FLNuoKeyboardTypeNumberPad = 1,
    FLNuoKeyboardTypeDecimal = 2,
};

@interface FLNuoKeyboard : UIView

// 单例创建键盘底部
+ (nonnull instancetype)shareKeyboard;

/** 键盘内容  keyType：键盘种类 */
- (void)createKeyBoardWithType:(FLNuoKeyboardType)keyType;

// 键盘标题
@property (nonatomic, copy, nullable) NSString *enterprise;

// 键盘logo
@property (nonatomic, copy, nullable) NSString *icon;

// 输入的 TextField
@property (nonatomic, nullable, strong) UIView *inputSource;

@end
