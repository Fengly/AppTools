//
//  FLNuoKeyboard.m
//  MyKeyBord
//
//  Created by Riches on 2016/11/16.
//  Copyright © 2016年 Riches. All rights reserved.
//

#import "FLNuoKeyboard.h"
#import "FLNuoChar.h"

#ifndef KEYBOARD_WIDTH
#define KEYBOARD_WIDTH [UIScreen mainScreen].bounds.size.width
#endif
#define KEYBOARD_HEIGHT                 216
#define KEYBOARD_ICON_HEIGHT            35
#define NHCHAR_CORNER                   8
#define KEYBOARD_FONT_SIZE              18
#define KEYBOARD_FONTSIZE(s) [UIFont fontWithName:@"HelveticaNeue-Light" size:s]

#define RGBA_FOR_KEYBOARD(R/*红*/, G/*绿*/, B/*蓝*/, A/*透明*/) \
[UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:A]

@implementation FLNuoKeyboard {
    BOOL isShiftEnable, isShowSymbol, isShowMoreSymbol;
    NSMutableArray *charsBtn;
    UIButton *shiftBtn, *charSymSwitchBtn;
    UIImageView *iconFlogImageView;
    UILabel *iconLabel;
    UIView *line;
    FLNuoKeyboardType keyboradType;
}

+ (instancetype)shareKeyboard {
    static FLNuoKeyboard *keyboard = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        keyboard = [[FLNuoKeyboard alloc] init];
    });
    return keyboard;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, KEYBOARD_WIDTH, KEYBOARD_HEIGHT + KEYBOARD_ICON_HEIGHT);
        self.backgroundColor = RGBA_FOR_KEYBOARD(210, 215, 221, 1);
        // create sub View
        [self createSubView];
        // init my show info
        [self _initShowInfo];
        // start create keyboard
//        [self createKeyBoard];
    }
    return self;
}

- (void)createKeyBoardWithType:(FLNuoKeyboardType)keyType {
    switch (keyType) {
        case FLNuoKeyboardTypeNumberPad: {
            
        } break;
        case FLNuoKeyboardTypeDecimal: {
            
        } break;
        case FLNuoKeyboardTypeCharsAndNumber: {
            [self createCharsAndNumberLayout:YES];
        } break;
    }
}

- (void)createSubView {
    iconFlogImageView = ({
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.layer.cornerRadius = KEYBOARD_ICON_HEIGHT * 0.25;
        imageView.layer.masksToBounds = YES;
        [imageView sizeToFit];
        imageView;
    });
    [self addSubview:iconFlogImageView];
    
    iconLabel = ({
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.backgroundColor = [UIColor clearColor];
        label.font = KEYBOARD_FONTSIZE(KEYBOARD_FONT_SIZE - 5);
        label.textColor = RGBA_FOR_KEYBOARD(155, 155, 155, 1);
        label.textAlignment = NSTextAlignmentCenter;
        label;
    });
    [self addSubview:iconLabel];
    
    line = ({
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, KEYBOARD_ICON_HEIGHT - 1, KEYBOARD_WIDTH, 1)];
        v.backgroundColor = RGBA_FOR_KEYBOARD(101, 101, 101, 1);
        v;
    });
    [self addSubview:line];
}

- (void)_initShowInfo {
    self.icon = @"logo";
    self.enterprise = @"Riches安全输入";
}


- (CGFloat)fontSizeWithFont:(NSString *)message {
    if (message.length > 0) {
        NSDictionary *tempDic = [NSDictionary dictionaryWithObjectsAndKeys:KEYBOARD_FONTSIZE(KEYBOARD_FONT_SIZE - 5), NSFontAttributeName, nil];
        return [message sizeWithAttributes:tempDic].width;
    }
    return 0;
}

- (void)makeSubViewFrame {
    CGFloat icon_h = KEYBOARD_ICON_HEIGHT;
    CGFloat icon_w = icon_h * 0.5;
    CGFloat font_width = [self fontSizeWithFont:_enterprise];
    CGFloat w_width = icon_w * 1.5 + font_width;
    CGFloat start_x = (KEYBOARD_WIDTH - w_width) * 0.5 + icon_w * 1.5;
    CGRect frame = CGRectMake(start_x, KEYBOARD_ICON_HEIGHT * 0.25, font_width, KEYBOARD_ICON_HEIGHT * 0.5);
    iconLabel.frame = frame;
    
    frame.origin.x -= icon_w * 1.5;
    frame.size = CGSizeMake(icon_w, icon_w);
    iconFlogImageView.frame = frame;
}

- (void)setIcon:(NSString *)icon {
    if (_icon != icon) {
        _icon = icon;
    }
    UIImage *image = [UIImage imageNamed:_icon];
    iconFlogImageView.image = image;
}

- (void)setEnterprise:(NSString *)enterprise {
    if (_enterprise != enterprise) {
        _enterprise = enterprise;
    }
    iconLabel.text = _enterprise;
    
    // set sub View's frame
    [self makeSubViewFrame];
}

#pragma mark -- 密码键盘 --

#define Characters @[@"q",@"w",@"e",@"r",@"t",@"y",@"u",@"i",@"o",@"p",@"a",@"s",@"d",@"f",@"g",@"h",@"j",@"k",@"l",@"z",@"x",@"c",@"v",@"b",@"n",@"m"]
#define Symbols  @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0",@"-",@"/",@":",@";",@"(",@")",@"$",@"&",@"@",@"\"",@".",@",",@"?",@"!",@"'"]
#define moreSymbols  @[@"[",@"]",@"{",@"}",@"#",@"%",@"^",@"*",@"+",@"=",@"_",@"\\",@"|",@"~",@"<",@">",@"€",@"£",@"¥",@"•",@".",@",",@"?",@"!",@"'"]
// 字符串与数字键盘布局
- (void)createCharsAndNumberLayout:(BOOL)isInit {
    if (!isInit) {
        //不是初始化创建 重新布局字母或字符界面
        NSArray *subviews = self.subviews;
        [subviews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[FLNuoChar class]]) {
                [obj removeFromSuperview];
            }
        }];
    }
    if (charsBtn || charsBtn.count) {
        [charsBtn removeAllObjects];
        charsBtn = nil;
    }
    charsBtn = [NSMutableArray arrayWithCapacity:0];
    
    NSArray *charSets ;NSArray *rangs;
    if (!isShowSymbol) {
        charSets = Characters;
        rangs = @[@10,@19,@26];
    } else {
        charSets = isShowMoreSymbol? moreSymbols:Symbols;
        rangs = @[@10,@20,@25];
    }
    
    // 第一排
    NSInteger loc = 0;
    NSInteger length = [[rangs objectAtIndex:0] integerValue];
    NSArray *chars = [charSets subarrayWithRange:NSMakeRange(loc, length)];
    NSInteger len = [chars count];
    CGFloat char_h_dis = 7;
    CGFloat char_v_dis = 13;
    CGFloat char_uper_dis = 10;
    CGFloat char_width = (KEYBOARD_WIDTH - char_h_dis * len) / len;
    CGFloat char_heigh = (KEYBOARD_HEIGHT - char_uper_dis * 2 - char_v_dis * 3) / 4;
    UIFont *titleFont = KEYBOARD_FONTSIZE(KEYBOARD_FONT_SIZE);
    UIColor *titleColor = RGBA_FOR_KEYBOARD(0, 0, 0, 1);
    UIColor *bgColor = RGBA_FOR_KEYBOARD(255, 255, 255, 1);
    UIImage *bgImg = [UIImage pb_imageFromColor:bgColor];
    UIImage *bgImg1 = [UIImage pb_imageFromColor:RGBA_FOR_KEYBOARD(174, 181, 189, 1)];
    CGFloat cur_y = KEYBOARD_ICON_HEIGHT + char_uper_dis;
    
    int n = 0;
    UIImage *charbgImg = [bgImg pb_drawRectWithRoundCorner:NHCHAR_CORNER toSize:CGSizeMake(char_width, char_heigh)];
//    UIImage *charbgImg1 = [bgImg1 pb_drawRectWithRoundCorner:NHCHAR_CORNER toSize:CGSizeMake(char_width, char_heigh)];
    for (int i = 0 ; i < len; i ++) {
        CGRect bounds = CGRectMake(char_h_dis*0.5+(char_width+char_h_dis)*i, cur_y, char_width, char_heigh);
        FLNuoChar *btn = [FLNuoChar buttonWithType:UIButtonTypeCustom];
        btn.frame = bounds;
        btn.exclusiveTouch = true;
        btn.userInteractionEnabled = false;
        btn.titleLabel.font = titleFont;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.titleLabel.textColor = titleColor;
        [btn setTitleColor:titleColor forState:UIControlStateNormal];
        [btn setBackgroundImage:charbgImg forState:UIControlStateNormal];
        [btn setTag:n+i];
        [self addSubview:btn];
        [charsBtn addObject:btn];
    }
    n+=len;
    
    //第二排
    cur_y += char_heigh+char_v_dis;
    loc = [[rangs objectAtIndex:0] integerValue];
    length = [[rangs objectAtIndex:1] integerValue];
    chars = [charSets subarrayWithRange:NSMakeRange(loc, length - loc)];
    //NSLog(@"第二排:%@",chars);
    len = [chars count];
    CGFloat start_x = (KEYBOARD_WIDTH - char_width * len - char_h_dis * (len - 1)) / 2;
    for (int i = 0 ; i < len; i ++) {
        CGRect bounds = CGRectMake(start_x + (char_width + char_h_dis) * i, cur_y, char_width, char_heigh);
        FLNuoChar *btn = [FLNuoChar buttonWithType:UIButtonTypeCustom];
        btn.frame = bounds;
        btn.exclusiveTouch = true;
        btn.userInteractionEnabled = false;
        btn.titleLabel.font = titleFont;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.titleLabel.textColor = titleColor;
        [btn setTitleColor:titleColor forState:UIControlStateNormal];
        [btn setBackgroundImage:charbgImg forState:UIControlStateNormal];
        [btn setTag:n+i];
        [self addSubview:btn];
        [charsBtn addObject:btn];
    }
    n+=len;
    
    //第三排
    cur_y += char_heigh+char_v_dis;
    loc = [[rangs objectAtIndex:1] integerValue];
    length = [[rangs objectAtIndex:2] integerValue];
    chars = [charSets subarrayWithRange:NSMakeRange(loc, length - loc)];
    len = [chars count];
    CGFloat shiftWidth = char_width * 1.5;
    char_width = (KEYBOARD_WIDTH - char_h_dis * 4 - shiftWidth * 2 - char_h_dis * (len - 1)) / len;
    charbgImg = [bgImg pb_drawRectWithRoundCorner:NHCHAR_CORNER toSize:CGSizeMake(char_width, char_heigh)];
    CGRect bounds;UIButton *btn;
    if (isInit) {
        UIImage *roundImg = [bgImg1 pb_drawRectWithRoundCorner:NHCHAR_CORNER toSize:CGSizeMake(shiftWidth, char_heigh)];
        bounds = CGRectMake(char_h_dis*0.5, cur_y, shiftWidth, char_heigh);
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = bounds;
        btn.exclusiveTouch = true;
        btn.titleLabel.font = titleFont;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.titleLabel.textColor = titleColor;
        [btn setTitleColor:titleColor forState:UIControlStateNormal];
        [btn setTitle:isShiftEnable ? @"⬇️" : @"⬆️" forState:UIControlStateNormal];
        [btn setBackgroundImage:roundImg forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(shiftAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        shiftBtn = btn;
        
        bounds = CGRectMake(KEYBOARD_WIDTH - char_h_dis * 0.5 - shiftWidth, cur_y, shiftWidth, char_heigh);
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = bounds;
        btn.exclusiveTouch = true;
        //btn.backgroundColor = NHColor(64, 66, 68);
        btn.titleLabel.font = titleFont;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.titleLabel.textColor = titleColor;
        [btn setTitleColor:titleColor forState:UIControlStateNormal];
        [btn setTitle:@"⬅️" forState:UIControlStateNormal];
        [btn setBackgroundImage:roundImg forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(charDeleteAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    for (int i = 0 ; i < len; i ++) {
        CGRect bounds = CGRectMake(char_h_dis*2+shiftWidth+(char_width+char_h_dis)*i, cur_y, char_width, char_heigh);
        FLNuoChar *btn = [FLNuoChar buttonWithType:UIButtonTypeCustom];
        btn.frame = bounds;
        btn.exclusiveTouch = true;
        btn.userInteractionEnabled = false;
        btn.titleLabel.font = titleFont;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.titleLabel.textColor = titleColor;
        [btn setTitleColor:titleColor forState:UIControlStateNormal];
        [btn setBackgroundImage:charbgImg forState:UIControlStateNormal];
        [btn setTag:n+i];
        [self addSubview:btn];
        [charsBtn addObject:btn];
    }
    
    //第四排
    if (isInit) {
        cur_y += char_heigh + char_v_dis;
        CGFloat numWidth = shiftWidth * 2;
        UIImage *roundImg = [bgImg1 pb_drawRectWithRoundCorner:NHCHAR_CORNER toSize:CGSizeMake(numWidth, char_heigh)];
        bounds = CGRectMake(char_h_dis * 0.5, cur_y, numWidth, char_heigh);
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = bounds;
        btn.exclusiveTouch = true;
        //btn.backgroundColor = NHColor(64, 66, 68);
        btn.titleLabel.font = titleFont;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.titleLabel.textColor = titleColor;
        [btn setTitleColor:titleColor forState:UIControlStateNormal];
        [btn setTitle:@"#+123" forState:UIControlStateNormal];
        [btn setBackgroundImage:roundImg forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(charSymbolSwitch:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        charSymSwitchBtn = btn;
        bounds = CGRectMake(KEYBOARD_WIDTH - char_h_dis * 0.5 - numWidth, cur_y, numWidth, char_heigh);
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = bounds;
        btn.exclusiveTouch = true;
        btn.titleLabel.font = titleFont;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.titleLabel.textColor = titleColor;
        [btn setTitleColor:titleColor forState:UIControlStateNormal];
        [btn setTitle:@"OK" forState:UIControlStateNormal];
        [btn setBackgroundImage:roundImg forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(charDoneAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        UIImage *roundImg1 = [bgImg pb_drawRectWithRoundCorner:NHCHAR_CORNER toSize:CGSizeMake(numWidth, char_heigh)];
        CGFloat spaceWidth = (KEYBOARD_WIDTH - char_h_dis * 3 - numWidth * 2);
        bounds = CGRectMake(char_h_dis*1.5+numWidth, cur_y, spaceWidth, char_heigh);
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = bounds;
        btn.exclusiveTouch = true;
        btn.titleLabel.font = titleFont;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.titleLabel.textColor = titleColor;
        [btn setTitleColor:titleColor forState:UIControlStateNormal];
        [btn setTitle:@"Space" forState:UIControlStateNormal];
        [btn setBackgroundImage:roundImg1 forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(charSpaceAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    //加载键盘符号
    [self loadCharacters:charSets];
}


- (void)loadCharacters:(NSArray *)array {
    
    NSInteger len = [array count];
    if (!array || len == 0) {
        return;
    }
    NSArray *subviews = self.subviews;
    [subviews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj && [obj isKindOfClass:[FLNuoChar class]]) {
            FLNuoChar *tmp = (FLNuoChar *)obj;
            NSInteger __tag = tmp.tag;
            //NSLog(@"__tag:%zd---index:%d",__tag,idx);
            if (__tag < len) {
                NSString *tmpTitle = [array objectAtIndex:__tag];
                //NSLog(@"char:%@",tmpTitle);
                if (isShowSymbol) {
                    [tmp updateChar:tmpTitle];
                }else{
                    [tmp updateChar:tmpTitle shift:isShiftEnable];
                }
            }
        }
    }];
}

#pragma mark -- 字符与数字键盘 Action --
- (void)shiftAction:(UIButton *)btn {
    if (isShowSymbol) {
        //正显示字符符号 无需切换大写
        isShowMoreSymbol = !isShowMoreSymbol;
        [self updateShiftBtnTitleState];
        NSArray *__symbols = isShowMoreSymbol ? moreSymbols : Symbols;
        [self loadCharacters:__symbols];
    }else{
        isShiftEnable = !isShiftEnable;
        NSArray *subChars = [self subviews];
        [btn setTitle:isShiftEnable?@"⬇️":@"⬆️" forState:UIControlStateNormal];
        [subChars enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[FLNuoChar class]]) {
                FLNuoChar *tmp = (FLNuoChar *)obj;
                [tmp shift:isShiftEnable];
            }
        }];
    }
}

- (void)charDeleteAction:(UIButton *)btn {
    if (self.inputSource) {
        if ([self.inputSource isKindOfClass:[UITextField class]]) {
            UITextField *tmp = (UITextField *)self.inputSource;
            [tmp deleteBackward];
        } else if ([self.inputSource isKindOfClass:[UITextView class]]) {
            UITextView *tmp = (UITextView *)self.inputSource;
            [tmp deleteBackward];
        } else if ([self.inputSource isKindOfClass:[UISearchBar class]]) {
            UISearchBar *tmp = (UISearchBar *)self.inputSource;
            NSMutableString *info = [NSMutableString stringWithString:tmp.text];
            if (info.length > 0) {
                NSString *s = [info substringToIndex:info.length - 1];
                [tmp setText:s];
            }
        }
    }
}

//字母 符号切换
- (void)charSymbolSwitch:(UIButton *)btn {
    isShowSymbol = !isShowSymbol;
    NSString *title = isShowSymbol ? @"ABC" : @"#+123";
    [charSymSwitchBtn setTitle:title forState:UIControlStateNormal];
    [self updateShiftBtnTitleState];
    [self createCharsAndNumberLayout:NO];
}

- (void)charDoneAction:(UIButton *)btn {
    if (self.inputSource) {
        if ([self.inputSource isKindOfClass:[UITextField class]]) {
            UITextField *tmp = (UITextField *)self.inputSource;
            if (tmp.delegate && [tmp.delegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
                BOOL ret = [tmp.delegate textFieldShouldEndEditing:tmp];
                [tmp endEditing:ret];
            } else {
                [tmp resignFirstResponder];
            }
        } else if ([self.inputSource isKindOfClass:[UITextView class]]){
            UITextView *tmp = (UITextView *)self.inputSource;
            
            if (tmp.delegate && [tmp.delegate respondsToSelector:@selector(textViewShouldEndEditing:)]) {
                BOOL ret = [tmp.delegate textViewShouldEndEditing:tmp];
                [tmp endEditing:ret];
            }else{
                [tmp resignFirstResponder];
            }
        } else if ([self.inputSource isKindOfClass:[UISearchBar class]]){
            UISearchBar *tmp = (UISearchBar *)self.inputSource;
            
            if (tmp.delegate && [tmp.delegate respondsToSelector:@selector(searchBarShouldEndEditing:)]) {
                BOOL ret = [tmp.delegate searchBarShouldEndEditing:tmp];
                [tmp endEditing:ret];
            } else {
                [tmp resignFirstResponder];
            }
        }
    }
}

- (void)charSpaceAction:(UIButton *)btn {
    NSString *title = @" ";
    if (self.inputSource) {
        if ([self.inputSource isKindOfClass:[UITextField class]]) {
            UITextField *tmp = (UITextField *)self.inputSource;
            
            if (tmp.delegate && [tmp.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
                NSRange range = NSMakeRange(tmp.text.length, 1);
                BOOL ret = [tmp.delegate textField:tmp shouldChangeCharactersInRange:range replacementString:title];
                if (ret) {
                    [tmp insertText:title];
                }
            } else {
                [tmp insertText:title];
            }
            
        } else if ([self.inputSource isKindOfClass:[UITextView class]]){
            UITextView *tmp = (UITextView *)self.inputSource;
            
            if (tmp.delegate && [tmp.delegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]) {
                NSRange range = NSMakeRange(tmp.text.length, 1);
                BOOL ret = [tmp.delegate textView:tmp shouldChangeTextInRange:range replacementText:title];
                if (ret) {
                    [tmp insertText:title];
                }
            }else{
                [tmp insertText:title];
            }
            
        } else if ([self.inputSource isKindOfClass:[UISearchBar class]]){
            UISearchBar *tmp = (UISearchBar *)self.inputSource;
            NSMutableString *info = [NSMutableString stringWithString:tmp.text];
            [info appendString:title];
            
            if (tmp.delegate && [tmp.delegate respondsToSelector:@selector(searchBar:shouldChangeTextInRange:replacementText:)]) {
                NSRange range = NSMakeRange(tmp.text.length, 1);
                BOOL ret = [tmp.delegate searchBar:tmp shouldChangeTextInRange:range replacementText:title];
                if (ret) {
                    [tmp setText:[info copy]];
                }
            }else{
                [tmp setText:[info copy]];
            }
        }
    }
}

- (void)characterTouchAction:(FLNuoChar *)btn {
    NSString *title = [btn titleLabel].text;
    if (self.inputSource) {
        if ([self.inputSource isKindOfClass:[UITextField class]]) {
            UITextField *tmp = (UITextField *)self.inputSource;
            
            if (tmp.delegate && [tmp.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
                NSRange range = NSMakeRange(tmp.text.length, 1);
                BOOL ret = [tmp.delegate textField:tmp shouldChangeCharactersInRange:range replacementString:title];
                if (ret) {
                    [tmp insertText:title];
                }
            } else {
                [tmp insertText:title];
            }
            
        } else if ([self.inputSource isKindOfClass:[UITextView class]]){
            UITextView *tmp = (UITextView *)self.inputSource;
            
            if (tmp.delegate && [tmp.delegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]) {
                NSRange range = NSMakeRange(tmp.text.length, 1);
                BOOL ret = [tmp.delegate textView:tmp shouldChangeTextInRange:range replacementText:title];
                if (ret) {
                    [tmp insertText:title];
                }
            } else {
                [tmp insertText:title];
            }
            
        } else if ([self.inputSource isKindOfClass:[UISearchBar class]]){
            UISearchBar *tmp = (UISearchBar *)self.inputSource;
            NSMutableString *info = [NSMutableString stringWithString:tmp.text];
            [info appendString:title];
            
            if (tmp.delegate && [tmp.delegate respondsToSelector:@selector(searchBar:shouldChangeTextInRange:replacementText:)]) {
                NSRange range = NSMakeRange(tmp.text.length, 1);
                BOOL ret = [tmp.delegate searchBar:tmp shouldChangeTextInRange:range replacementText:title];
                if (ret) {
                    [tmp setText:[info copy]];
                }
            } else {
                [tmp setText:[info copy]];
            }
        }
    }
}

- (void)updateShiftBtnTitleState {
    NSString *title ;
    if (isShowSymbol) {
        title = isShowMoreSymbol?@"123":@"#+=";
    }else{
        title = isShiftEnable?@"⬇️":@"⬆️";
    }
    [shiftBtn setTitle:title forState:UIControlStateNormal];
}


#pragma mark -- 键盘Pan --
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint touchPoint = [[touches anyObject] locationInView:self];
    for (FLNuoChar *tmp in charsBtn) {
        NSArray *subs = [tmp subviews];
        if (subs.count == 3) {
            [[subs lastObject] removeFromSuperview];
        }
        if (CGRectContainsPoint(tmp.frame, touchPoint)) {
            [tmp addPopup];
        }
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint touchPoint = [[touches anyObject] locationInView:self];
    for (FLNuoChar *tmp in charsBtn) {
        NSArray *subs = [tmp subviews];
        if (subs.count == 3) {
            [[subs lastObject] removeFromSuperview];
        }
        if (CGRectContainsPoint(tmp.frame, touchPoint)) {
            [tmp addPopup];
        }
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint touchPoint = [[touches anyObject] locationInView:self];
    for (FLNuoChar *tmp in charsBtn) {
        NSArray *subs = [tmp subviews];
        if (subs.count == 3) {
            [[subs lastObject] removeFromSuperview];
        }
        if (CGRectContainsPoint(tmp.frame, touchPoint)) {
            [self characterTouchAction:tmp];
        }
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    for (FLNuoChar *tmp in charsBtn) {
        NSArray *subs = [tmp subviews];
        if (subs.count == 3) {
            [[subs lastObject] removeFromSuperview];
        }
    }
}



- (BOOL)resignFirstResponder {
    if (self.inputSource) {
        [self.inputSource resignFirstResponder];
    }
    return [super resignFirstResponder];
}


@end
