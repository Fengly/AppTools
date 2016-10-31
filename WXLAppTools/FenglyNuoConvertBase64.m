//
//  FenglyNuoConvertBase64.m
//  Fabric
//
//  Created by Riches on 16/6/28.
//  Copyright © 2016年 Riches. All rights reserved.
//

#import "FenglyNuoConvertBase64.h"

@implementation FenglyNuoConvertBase64

+ (void)imagePackedInStrWithImage:(UIImage *)image endBase:(void (^)(NSString *imageBase64Str))newImageBase64Str {
    
    dispatch_queue_t myGlobalQueue = dispatch_queue_create("com.Riches.FenglyNuo.myGlobalQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(myGlobalQueue, ^{
        
        NSString *str = [[self class] imagePackedInStrWithImage:image];
        
        newImageBase64Str(str);
    });
}

+ (NSString *)imagePackedInStrWithImage:(UIImage *)image {
    
    //    image = [[[UIFontDescriptor alloc] init] objectForKey:@"UIImagePickerControllerOriginalImage"];
    
//    image = [[self class] resizeToWidth:200 height:image.size.height * 200 / image.size.width ];
    
    
//    UIImage *newImage = [[self class] resizeToWidth:200 height:image.size.height * 200 / image.size.width ];
    
    UIImage *newImage = [[self class] imageByScalingAndCroppingForSize:CGSizeMake(400, 400) image:image];
    
    NSData *currentPic = [NSData data];
   
    if (UIImagePNGRepresentation(newImage) == nil){
        currentPic = UIImageJPEGRepresentation(newImage, 1);
    } else {
        currentPic = UIImagePNGRepresentation(newImage);
    }
    
    return [currentPic base64EncodedStringWithOptions:(NSDataBase64Encoding64CharacterLineLength)];
}


//图片压缩到指定大小
+ (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize image:(UIImage *)image
{
    UIImage *sourceImage = image;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth= width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor < heightFactor)
        {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width= scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
//        NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

//- (UIImage *)resizeToWidth:(CGFloat)width height:(CGFloat)height {
//    CGSize size = CGSizeMake(width, height);
//    if (/* DISABLES CODE */ (&UIGraphicsBeginImageContextWithOptions) != nil) {
//        UIGraphicsBeginImageContextWithOptions(size, NO, 0);
//    } else {
//        UIGraphicsEndImageContext();
//    }
//    [self drawInRect:CGRectMake(0, 0, width, height)];
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return image;
//}


//        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
//
//        NSURL *URL = [NSURL URLWithString:@"http://example.com/upload"];
//        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
//
//        NSString *str = [NSString stringWithFormat:@"%@://path/to/image.png", savedImage];
//        NSURL *filePath = [NSURL fileURLWithPath:str];
//        NSLog(@"%@", filePath);
//        NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:request fromFile:filePath progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
//            if (error) {
//                NSLog(@"Error: %@", error);
//            } else {
//                NSLog(@"Success: %@ %@", response, responseObject);
//            }
//        }];
//        [uploadTask resume];

@end
