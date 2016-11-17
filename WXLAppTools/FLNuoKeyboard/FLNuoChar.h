//
//  FLNuoChar.h
//  MyKeyBord
//
//  Created by Riches on 2016/11/16.
//  Copyright © 2016年 Riches. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (PBHelper)

+ (nullable UIImage *)pb_imageFromColor:(nullable UIColor *)color;

- (nullable UIImage *)pb_drawRectWithRoundCorner:(CGFloat)radius toSize:(CGSize)size;

@end

@interface FLNuoChar : UIButton

@property (nonatomic, copy, nullable) NSString *chars;
@property (nonatomic, assign) BOOL isShift;


- (void)shift:(BOOL)shift;

- (void)updateChar:(nullable NSString *)chars;

- (void)updateChar:(nullable NSString *)chars shift:(BOOL)shift;

- (void)addPopup;

@end
