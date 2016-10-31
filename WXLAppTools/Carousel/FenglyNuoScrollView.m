//
//  FenglyNuoScrollView.m
//
//  Created by Fengly on 16/1/28.
//  Copyright © 2016年 FenglyNuo. All rights reserved.
//

#import "FenglyNuoScrollView.h"


#define kWidth self.fram.size.width

@interface FenglyNuoScrollView ()<UIScrollViewDelegate>

@property (nonatomic, retain) UIScrollView *scrollView; /**< 创建滚动的scrollView */
@property (nonatomic, retain) UIPageControl *page; /**< page小点 */
@property (nonatomic, retain) UIView *camberView; /**< 弧形view */

@property (nonatomic, assign) NSInteger count; /**< 图片数组长度 */
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) CGSize frameSize;
@property (nonatomic, retain) NSMutableArray *arrImageUrl; /**< 图片网址数组 */

@property (nonatomic, assign) NSInteger countClick; /**< 点击第几个图片 */

@property (nonatomic, retain) NSMutableArray *imageArr; /**< 图片数组 */

@property (nonatomic, retain) NSArray *imageUrl; /**< 传入放大的图片数组 */

@end

@implementation FenglyNuoScrollView


- (void)setTime:(CGFloat)time {
    _time = time;
    
    [self createTimer:time];
}

- (void)setScrollDirection:(ScrollDirectionq)scrollDirection {
    
    _scrollDirectionq = scrollDirection;
    
    switch (_scrollDirectionq) {
        case scrollDirectionHorizontal:
            //            _scrollView.backgroundColor = [UIColor redColor];
            _scrollView.contentSize = CGSizeMake(_frameSize.width * _count, 0);
            
            break;
        case scrollDirectionVertical:
            //            _scrollView.backgroundColor = [UIColor cyanColor];
            _scrollView.contentSize = CGSizeMake(0, _frameSize.height * _count);
            break;
    }
}



#pragma mark - 视图创建类
/** 设置page */
- (void)createPageControl {
    self.page = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, kUIScreenWidth, 30)];
    _page.backgroundColor = [UIColor clearColor];
    [_camberView addSubview:_page];
    
    _page.numberOfPages = _arrImageUrl.count - 2;
    _page.currentPage = 0;
   
    _page.pageIndicatorTintColor = [UIColor lightGrayColor];
    // 选中点的颜色
    _page.currentPageIndicatorTintColor = [UIColor cyanColor];
    
    // 添加方法
//    [_page addTarget:self action:@selector(pageAction:) forControlEvents:UIControlEventValueChanged];
}


/** 创建放page的view */
- (void)createSunView {
    self.camberView = [[UIView alloc] initWithFrame:CGRectMake(0, _scrollView.frame.size.height - 30, [UIScreen mainScreen].bounds.size.width, 30)];
    [self addSubview:_camberView];

    CGFloat corner = 50;
    CAShapeLayer *shapelayer = [CAShapeLayer layer];
    shapelayer.path = [UIBezierPath bezierPathWithRoundedRect:_camberView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(corner, corner)].CGPath;
    _camberView.layer.mask = shapelayer;
}

/** 创建滚动视图 */
- (void)createSubScrollView:(CGRect)frame array:(NSArray *)array {
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:_scrollView];
    
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    _scrollView.delegate = self;
    
    _scrollView.contentOffset = CGPointMake([UIScreen mainScreen].bounds.size.width, 0);
    
    // 设置默认为横行滚动
    self.scrollDirection = scrollDirectionHorizontal;
    
    [self createSubSonImageView:frame array:array];
    
    if (array.count <= 1) {
        _scrollView.scrollEnabled = NO;
    }
    
    // 轻拍手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    // 轻拍次数
    tap.numberOfTapsRequired = 1;
    
    // 添加到imageView上
    [_scrollView addGestureRecognizer:tap];
}

/** 放置图片到_scrollView */
- (void)createSubSonImageView:(CGRect)frame array:(NSArray *)array {
    
    if (!array.count) {
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width, 0, frame.size.width, frame.size.height)];
        [_scrollView addSubview:imgView];
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"noPictures" ofType:@"png"];
        UIImage *image = [UIImage imageWithContentsOfFile:filePath];
        
        imgView.image = image;
        
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        return;
    }
    NSString *firstStr = [array objectAtIndex:0];
    NSString *lastStr = [array lastObject];
    self.arrImageUrl = [NSMutableArray arrayWithArray:array];
    
    [_arrImageUrl insertObject:firstStr atIndex:_arrImageUrl.count];
    [_arrImageUrl insertObject:lastStr atIndex:0];
    
    
    for (NSInteger i = 0; i < _arrImageUrl.count; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width * i, 0, frame.size.width, frame.size.height)];
        
        id temp = _arrImageUrl[i];
        if ([temp isKindOfClass:[NSString class]]) {
            
            [imgView sd_setImageWithURL:[NSURL URLWithString:_arrImageUrl[i]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
               
                if (i != 0 && i != _arrImageUrl.count - 1) {
                    
                    [_imageArr addObject:image];
                }
            }];
        }
        if ([temp isKindOfClass:[UIImage class]]) {
            imgView.image = temp;
        }

        [_scrollView addSubview:imgView];
    }
}



#pragma mark - 轻拍方法
- (void)tapAction:(UITapGestureRecognizer *)tap {
    
//    [self.delegate scrollViewClick:_countClick];
    
    if (!_imageArr.count) {
        [[Toast shareInstanceToast] makeToast:NSLocalizedString(@"noPictureToWacth", nil) duration:kDurationTime];
        return;
    }
    
    _scrollView.userInteractionEnabled = NO;
    
    WxlAnimationZoomInImageView *ss = [[WxlAnimationZoomInImageView alloc]initZoonInImageViewWithFrame:[UIScreen mainScreen].bounds ImageUrlArr:_imageArr];
    ss.blockChangeUser = ^{
        
       _scrollView.userInteractionEnabled = YES;
    };
    [[[UIApplication sharedApplication] keyWindow] addSubview:ss];
}



- (void)createTimer:(CGFloat)time {
    // 创建定时器对象
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    [timer fire];
}



#pragma mark - action
// page
- (void)pageAction:(UIPageControl *)page {
//    [_scrollView setContentOffset:CGPointMake(kUIScreenWidth * page.currentPage, 0) animated:YES];
    
}

// 时间NsTimer
- (void)timerAction:(NSTimer *)timer{
    CGPoint p = _scrollView.contentOffset;
    
    if (p.x <= self.frame.size.width * (_arrImageUrl.count - 2)) {
        
        
        [_scrollView setContentOffset:CGPointMake(p.x + self.frame.size.width, 0) animated:YES];
    }
}


+ (FenglyNuoScrollView *)fenglyNuoScrollViewWithImageUrlArray:(NSArray *)urlArray Frame:(CGRect)fram{
    
    return [[FenglyNuoScrollView alloc] initWithFrame:fram array:urlArray];
}




#pragma mark - SCROLLVIEW DELEGATE
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    _page.currentPage = _scrollView.contentOffset.x / self.frame.size.width - 1;
    
    // 通过偏移量
    if (_scrollView.contentOffset.x == 0) {
        
        _scrollView.contentOffset = CGPointMake(self.frame.size.width * (_arrImageUrl.count - 2), 0);
        
    } if (_scrollView.contentOffset.x == self.frame.size.width * (_arrImageUrl.count - 1)) {

        _page.currentPage = 0;
        _scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
    }
    
    self.countClick = _scrollView.contentOffset.x / kUIScreenWidth - 1;
    
}



#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame array:(NSArray *)array {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageArr = [NSMutableArray new];

        self.imageUrl = array;
        _frameSize = frame.size;
        _count = array.count + 2;
        _currentPage = 0;
        // 创建滚动视图
        [self createSubScrollView:frame array:array];
        // 创建弧形的view
        [self createSunView];
        // 创建page
        if (array.count > 1) {
            [self createPageControl];
        }
        
    }
    return self;
}



/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
