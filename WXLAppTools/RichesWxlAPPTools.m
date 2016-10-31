//
//  RichesWxlAPPTools.m
//  aff
//
//  Created by Riches on 16/5/27.
//  Copyright © 2016年 Riches. All rights reserved.
//


#import "RichesWxlAPPTools.h"
#import "AFNetworking.h"

#define kPathPageName @"RichesFabricCaches"

@implementation RichesWxlAPPTools

/*************----------------------- 网络请求 GET & POST -----------------------*************/
+ (void)GETWithURL:(NSString *)urlStr
               par:(NSDictionary *)dic
           success:(void (^)(id))responseObj filed:(void (^)(NSError *))err {
    
    //    // 1. 获取AFN网络请求的Manager
    //    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFNetworkReachabilityManager *netWorkManger = [AFNetworkReachabilityManager sharedManager];
    
    // 如果要监测网络状态的变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 获取沙盒路径
//    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
//    // 文件管理器
//    NSFileManager *manger = [NSFileManager defaultManager];
//    // 使用文件管理器创建一个文件夹
//    // 拼文件夹路径
//    NSString *totoroCaches = [documentPath stringByAppendingPathComponent:kPathPageName];
//    
//    BOOL resultFile = [manger createDirectoryAtPath:totoroCaches withIntermediateDirectories:YES attributes:nil error:nil];
//
//    if (resultFile) {
//        NSLog(@"创建缓存的文件夹成功");
//    } else {
//        NSLog(@"创建存缓存的文件夹失败");
//    }
//
//    // 拼接缓存路径
//    NSString *path = [NSString stringWithFormat:@"%ld.plist", (unsigned long)[urlStr hash]];
//    // 将这个缓存写在自己创建的文件夹下面
//    NSString *textFilPath = [totoroCaches
//                             stringByAppendingPathComponent:path];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 如果处于未知网络状态返回缓存数据
        if (status == AFNetworkReachabilityStatusUnknown) {
//            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:textFilPath];
//            responseObj(dic);
        } else {
            NSString *str = [NSString stringWithFormat:@"%@",urlStr];
            
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
          
            // 有的返回的数据格式，AFN不支持解析，所以我们要设置一下。让AFN支持。
            [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css", @"text/plain", @"application/x-javascript", @"application/javascript",nil]];
            
            str = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            
            [manager GET:str parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [netWorkManger stopMonitoring];
                responseObj(responseObject);
                
//                BOOL result = [responseObject writeToFile:textFilPath atomically:YES];
                
//                if (result) {
//                    NSLog(@"写入成功");
//                }else{
//                    
//                    NSLog(@"写入失败");
//                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                err(error);
//                NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:textFilPath];
                responseObj(dic);
            }];
        }
    }];
}



+ (void)POSTWithURL:(NSString *)urlStr
                par:(id)dic
            success:(void (^)(id))response filed:(void (^)(NSError *))err {
    // 1. 获取AFN网络请求的Manager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFNetworkReachabilityManager *netWorkManger = [AFNetworkReachabilityManager sharedManager];
    // 如果要监测网络状态的变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
    }];

    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css", @"text/plain", @"application/x-javascript", @"application/javascript",nil]];
    
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [manager POST:urlStr parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [netWorkManger stopMonitoring];
        response(responseObject);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        err(error);
       
    }];
}


/*************-----------------------计算文本宽度 文字自适应的方法-----------------------*************/
+ (CGRect)scripeSuitWidthWithString:(NSString *)string Font:(CGFloat)font Size:(CGSize)size {
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font], NSFontAttributeName, nil];
    
    // 通过文字大小获取文本rect
    CGRect rect = [string boundingRectWithSize:CGSizeMake(size.width, size.height) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:dic context:nil];
    
    // 返回 文本宽度
    return rect;
}



/*************-----------------------十六进制颜色转换-----------------------*************/
+ (UIColor *)WxlStringToColor: (NSString *) stringToConvert {
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 charactersif ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appearsif ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}



/*************-----------------------本地存储 轻量级存储-----------------------*************/
/*************-------------------NSUserDefaults-------------------*************/
//将数据保存到本地
+ (void)saveDataToLocal:(id)data keys:(NSString *)key {
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    [preferences setObject:data forKey:key];
    
    [preferences synchronize];
}

//本地是否有相关数据
+ (BOOL)localHaveDataWithKey:(NSString *)key {
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    NSData* data = [preferences objectForKey:key];
    if (data) {
        return YES;
    }
    return NO;
}

//从本地获取数据
+ (id)takeDataFromLocalWithKey:(NSString *)key {
    
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    
    NSData* data = [preferences objectForKey:key];
    
    if (data) {
        
        return data;
    }
    else {
        NSLog(@"未从本地获得存储的数据");
    }
    return nil;
}

+ (void)deleteNSUserDefaultsDataWithKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



/*************----------------------- UUID -----------------------*************/
// UUID生成算法
+ (NSString *)uuidGenerated {
    // Create universally unique identifier (object)
    CFUUIDRef uuidObject = CFUUIDCreate(kCFAllocatorDefault);
    // Get the string representation of CFUUID object.
    NSString *uuidStr = (NSString *)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, uuidObject));
    // If needed, here is how to get a representation in bytes, returned as a structure
    // typedef struct {
    //   UInt8 byte0;
    //   UInt8 byte1;
    //   …
    //   UInt8 byte15;
    // } CFUUIDBytes;  4F62223B-3502-4B15-811D-15C986DE3BC2
    //                 35BFA66C-092B-4D0F-8ABF-F0218316ACFD
    CFUUIDGetUUIDBytes(uuidObject);
    
    CFRelease(uuidObject);
    
    return uuidStr;
}


+ (NSString *)sslHandelStrWithData:(NSString *)string {
    CRSA *cc = [CRSA shareInstance];
    // 写入公钥
    [cc writePukWithKey:kLoginPublicKey];
    
    NSString *str = [cc encryptByRsa:string withKeyType:KeyTypePublic];
    
    return str;
}

+ (NSString *)sslDecodeLaterStr:(NSString *)string {
    CRSA *cc = [CRSA shareInstance];
    // 写入私钥
    [cc writePrkWithKey:kMoneyPrivate];
    
    NSString *str = [cc decryptByRsa:string withKeyType:KeyTypePrivate];
    
    return str;
}

#pragma mark - 产生随机订单号
//- (NSString *)generateTradeNO {
//    static int kNumber = 15;
//    
//    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
//    NSMutableString *resultStr = [[NSMutableString alloc] init];
//    srand(time(0)); // 此行代码有警告:
//    for (int i = 0; i < kNumber; i++) {
//        unsigned index = rand() % [sourceStr length];
//        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
//        [resultStr appendString:oneStr];
//    }
//    return resultStr;
//}

// 正则判断手机号码
+ (BOOL)isValidateMobile:(NSString *)mobile {
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(17[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

+ (BOOL)isValidateEmail:(NSString *)email {
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+ (BOOL)isEmpty:(NSString *) str {
    
    if (!str) {
        return YES;
    } else {
        //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and nextline characters (U+000A–U+000D, U+0085).
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        
        if ([trimedString length] == 0) {
            return YES;
        } else {
            return NO;
        }
    }
}

+ (NSString *)deleteTheBlankSpaceWithString:(NSString *)string {
    
    return [string stringByReplacingOccurrencesOfString:@" " withString:@""];
}


+ (BOOL)isChinese:(NSString*)string {
    int strlength = 0;
    char* p = (char*)[string cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[string lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return ((strlength/2)==1)?YES:NO;
}

+ (NSMutableAttributedString *)lineSpacingString:(NSString *)string lineSpacing:(CGFloat)spacing {
    if (!string.length) {
        string = @"";
    }
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:string];
    //创建NSMutableParagraphStyle实例
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    //设置行距
    [style setLineSpacing:spacing];
    [attStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, [string length])];
    return attStr;
}


+ (void)cutAImageForYouWantWithUrlString:(NSString *)string imageView:(UIImageView *)imageView {
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:string] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        NSLog(@"%f, %f", image.size.width, image.size.height);
//        CGFloat bigImageH = image.size.height * 1.9;
//        
//        CGFloat bigImageW = bigImageH * 2 / 3;
//        
//        CGRect rect = CGRectMake(image.size.width * 2 - bigImageW, 0, bigImageW, bigImageH);
//        CGImageRef imageRef=CGImageCreateWithImageInRect([image CGImage],rect);
//        
//        UIImage *image1=[UIImage imageWithCGImage:imageRef];
//        imageView.image = image;
        
        imageView.contentMode = UIViewContentModeRight;
    }];
}

+ (void)cutSupplementaryImageForYouWantWithUrlString:(NSString *)string imageView:(UIImageView *)imageView {
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:string] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        imageView.contentMode = UIViewContentModeScaleAspectFill;
    }];
    
}



/**
 *  ****************************沙盒保存
 */
+ (void)saveImage:(UIImage *)currenImage withName:(NSString *)imageName {
    NSData *imageData = UIImageJPEGRepresentation(currenImage, 1); // 1为不缩放保存，取值（0.0 - 1.0）
    NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];

    // 将图片写入文件
    [imageData writeToFile:path atomically:NO];
}

+ (UIImage *)getImageFromDocumentWithName:(NSString *)pathNameString {
    NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:pathNameString];
  
    return [[UIImage alloc] initWithContentsOfFile:path];
}


+ (UIImage *)circleImage:(UIImage*) image withParam:(CGFloat)inset {
    
    UIGraphicsBeginImageContext(image.size);
    
    CGContextRef context =UIGraphicsGetCurrentContext();
    
    //圆的边框宽度为2，颜色为红色
    
    CGContextSetLineWidth(context,0);
    
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
    
    CGFloat w = image.size.width > image.size.height ? image.size.height : image.size.width;
    
    
    CGRect rect = CGRectMake(inset, inset, w - inset * 2.0f, w - inset * 2.0f);
    
    CGContextAddEllipseInRect(context, rect);
    
    CGContextClip(context);
    
    //在圆区域内画出image原图
    
    [image drawInRect:rect];
    
    CGContextAddEllipseInRect(context, rect);
    
    CGContextStrokePath(context);
    
    //生成新的image
    
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newimg;
}

+ (void)savaUrlDataToPlistWithFilPathName:(NSString *)nameString vlue:(id)vlue {
   
//    NSLog(@"%@", vlue);
    
    BOOL result = [vlue writeToFile:[[self class] savaTextFilPathWithFilPathName:nameString] atomically:YES];
    
    if (result) {
        NSLog(@"写入%@成功", nameString);
    }else{
        
        NSLog(@"写入%@失败", nameString);
    }
}

// 拼接存储地址
+ (NSString *)savaTextFilPathWithFilPathName:(NSString *)nameString {
    // 获取沙盒路径
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    // 文件管理器
    NSFileManager *manger = [NSFileManager defaultManager];
    // 使用文件管理器创建一个文件夹
    // 拼文件夹路径
    NSString *totoroCaches = [documentPath stringByAppendingPathComponent:kPathPageName];
    
    BOOL resultFile = [manger createDirectoryAtPath:totoroCaches withIntermediateDirectories:YES attributes:nil error:nil];
    if (resultFile) {
//        NSLog(@"创建缓存的文件夹成功");
    } else {
//        NSLog(@"创建存缓存的文件夹失败");
    }
    // 拼接缓存路径
    NSString *path = [NSString stringWithFormat:@"%ld.plist",(unsigned long)[nameString hash]];
    
    // 将这个缓存写在自己创建的文件夹下面
    NSString *textFilPath = [totoroCaches
                             stringByAppendingPathComponent:path];
    NSLog(@"%@", textFilPath);
   
    return textFilPath;
}


+ (NSString *)changeToJsonWithData:(id)data {
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:nil];//此处data参数是我上面提到的key为"data"的数组
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return jsonString;
}

+ (id)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    id dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

+ (NSString *)telephoneNumber:(NSString *)phone {
    
    if (phone.length < 11) {
        return phone;
    }
    
    NSString *str3 = [phone substringToIndex:3];
    NSString *str4_1 = [phone substringWithRange:NSMakeRange(3, 4)];
    NSString *str4_2 = [phone substringFromIndex:7];
    
    return [NSString stringWithFormat:@"%@ %@ %@", str3, str4_1, str4_2];
}


@end
