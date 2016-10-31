//
//  RichesWxlAPPTools.h
//  aff
//
//  Created by Riches on 16/5/27.
//  Copyright © 2016年 Riches. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



@interface RichesWxlAPPTools : NSObject

/********************************** 网络请求get & post **********************************/
/**
*  get请求网络数据
*
*  @param urlStr      网络请求接口
*  @param dic         接口参数（此为get接口，可为nil）
*  @param responseObj 请求成功数据（请求成功回调）
*  @param error       返回错误信息（请求失败回调）
*/
+ (void)GETWithURL:(NSString *)urlStr
               par:(NSDictionary *)dic
           success:(void(^)(id responseObject))responseObj
             filed:(void(^)(NSError *error))error;

/**
 *  post请求网络数据
 *
 *  @param urlStr   网络接口
 *  @param dic      接口参数
 *  @param response 请求成功数据（请求成功回调）
 *  @param err      返回错误信息（请求失败回调）
 */
+ (void)POSTWithURL:(NSString *)urlStr
                par:(id)dic
            success:(void(^)(id responseObject))response
              filed:(void(^)(NSError *error))err;




/**
 *  计算文本宽度 文字自适应的方法
 *
 *  @param string 自适应内容
 *  @param font   字体大小
 *  @param size   自适应控件大小
 *
 *  @return 返回自适应结果的Rect
 */
+ (CGRect)scripeSuitWidthWithString:(NSString *)string Font:(CGFloat)font Size:(CGSize)size;



/**
 *  十六进制颜色转换
 *
 *  @param stringToConvert 十六进制颜色参数
 *
 *  @return 返回装换成功的颜色
 */
+ (UIColor *)WxlStringToColor: (NSString *) stringToConvert;





/*************-----------------------本地存储 轻量级存储-----------------------*************/
/*************-------------------      NSUserDefaults-------------------*************/
/********************** NSUserDefaults支持的数据类型有：NSNumber（NSInteger、float、double），NSString，NSDate，NSArray，NSDictionary，BOOL. ***************************/
/**
 *  将数据存入本地
 *
 *  @param data 要存的数据
 *  @param key  存储的关键字（存储空间的名字）
 */
+ (void)saveDataToLocal:(id)data keys:(NSString *)key;

/**
 *  判断本地是否有相关数据
 *
 *  @param key 存储的关键字（存储空间的名字）
 *
 *  @return 返回值为bool（存在：yes）
 */
+ (BOOL)localHaveDataWithKey:(NSString *)key;

/**
 *  取出本地存储的数据
 *
 *  @param key 存储的关键字（存储空间的名字）
 *
 *  @return 返回存储的数据
 */
+ (id)takeDataFromLocalWithKey:(NSString *)key;


/**
 *  删除NSUserDefaults中的内容
 *
 *  @param key key
 */
+ (void)deleteNSUserDefaultsDataWithKey:(NSString *)key;




/**
 *  UUID是128位的值，它可以保证唯一性。通常，它是由机器本身网卡的MAC地址和当前系统时间来生成的。
 *  UUID是由中划线连接而成的字符串。
 *  生成UUID
 *
 *  @return 生成的 UUID
 */
+ (NSString *)uuidGenerated;


/**
 *  正则表达式 判断是不是手机号码
 *
 *  @param mobile 手机号码
 *
 *  @return 返回bool YES是是，NO是不是
 */
+ (BOOL)isValidateMobile:(NSString *)mobile;

/**
 *  正则表达式 判断是不是邮箱号码
 *
 *  @param email 邮箱号码
 *
 *  @return 返回bool YES是是，NO是不是
 */
+ (BOOL)isValidateEmail:(NSString *)email;

/**
 *  判断字符串开头是否为空格
 *
 *  @param str 要判断的字符串
 *
 *  @return 返回的结果 YES 是空格  NO 不是空格
 */
+ (BOOL)isEmpty:(NSString *) str;

/**
 *  删除空格中的字符串
 *
 *  @param string 要处理的字符串
 *
 *  @return 删除空格后的字符串
 */
+ (NSString *)deleteTheBlankSpaceWithString:(NSString *)string;

/**
 *  判断字符串是不是中文
 *
 *  @param string 要判断的字符串
 *
 *  @return 返回结果 YES是  NO不是
 */
+ (BOOL)isChinese:(NSString*)string;

/**
 *  label字符串间距
 *
 *  @param string  设置的字符串
 *  @param spacing 间距
 *
 *  @return 返回设置好的字符串
 */
+ (NSMutableAttributedString *)lineSpacingString:(NSString *)string lineSpacing:(CGFloat)spacing;

/**
 *  图片按需求截取
 *
 *  @param string    图片网址字符串
 *  @param imageView 要显示图片的imageView
 */
+ (void)cutAImageForYouWantWithUrlString:(NSString *)string imageView:(UIImageView *)imageView;
+ (void)cutSupplementaryImageForYouWantWithUrlString:(NSString *)string imageView:(UIImageView *)imageView;


#pragma mark - 保存至沙盒
/**
 *  保存图片到本地
 *
 *  @param currenImage 要保存的图片
 *  @param imageName   图片名
 */
+ (void)saveImage:(UIImage *)currenImage withName:(NSString *)imageName;
/**
 *  从本地获取图片
 *
 *  @param pathNameString 图片名
 *
 *  @return 返回图片
 */
+ (UIImage *)getImageFromDocumentWithName:(NSString *)pathNameString;




/*************  ----------------------- 切出圆形图片   *******/
/**
 *  切出圆形图
 *
 *  @param image 图片
 *  @param inset 图片大小
 *
 *  @return 返回切图后的图片
 */
+ (UIImage *)circleImage:(UIImage *)image withParam:(CGFloat)inset;


/**
 *  存储到本地 用plist
 *
 *  @param nameString 文件名
 *  @param vlue       存储内容
 */
+ (void)savaUrlDataToPlistWithFilPathName:(NSString *)nameString vlue:(id)vlue;
/**
 *  获取存储的地址
 *
 *  @param nameString 文件名
 *
 *  @return 返回拼接好的地址
 */
+ (NSString *)savaTextFilPathWithFilPathName:(NSString *)nameString;


/// 字符转 JSON
+ (NSString *)changeToJsonWithData:(id)data;
/// JSON 转字典
+ (id)dictionaryWithJsonString:(NSString *)jsonString;
/// 电话号码格式 *** **** ****
+ (NSString *)telephoneNumber:(NSString *)phone;


/// ssl 加密
+ (NSString *)sslHandelStrWithData:(NSString *)string;
/// ssl 解密
+ (NSString *)sslDecodeLaterStr:(NSString *)string;
@end
