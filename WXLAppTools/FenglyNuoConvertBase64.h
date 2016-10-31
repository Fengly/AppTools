//
//  FenglyNuoConvertBase64.h
//  Fabric
//
//  Created by Riches on 16/6/28.
//  Copyright © 2016年 Riches. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FenglyNuoConvertBase64 : UIImage

/**
 *   图片上传时需将图片转换成base64编码
 *
 *  @param image             要上传的图片
 *  @param newImageBase64Str 装换后返回的base64编码字符串(子线程中转码结束 回传)
 */
+ (void)imagePackedInStrWithImage:(UIImage *)image endBase:(void(^)(NSString *imageBase64Str))newImageBase64Str;

/**
 *  图片上传时需将图片转换成base64编码
 *
 *  @param image 要上传的图片
 *
 *  @return 装换后返回的base64编码字符串
 */

+ (NSString *)imagePackedInStrWithImage:(UIImage *)image;


/**
 *  压缩图片
 *
 *  @param targetSize 压缩的大小
 *  @param image      图片名称
 *
 *  @return 压缩后的图片
 */
+ (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize image:(UIImage *)image;
@end
