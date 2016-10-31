//
//  WxlZoomInImageView.m
//
//  Created by Riches on 16/7/28.
//  Copyright © 2016年 vito. All rights reserved.
//

#import "WxlZoomInImageView.h"
#import "VIPhotoView.h"
#import "UIImageView+WebCache.h"

@interface WxlZoomInImageView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView * scaleScrollView;
@property (nonatomic, retain) UIPageControl *page; /**< page小点 */

@property (nonatomic, retain) VIPhotoView *photoView;
//@property (nonatomic, retain) VIPhotoView *photoView2;

@end

@implementation WxlZoomInImageView

- (instancetype)initZoonInImageViewWithFrame:(CGRect)fram ImageUrlArr:(NSArray *)array {
    self = [super initWithFrame:fram];
    if (self) {
        if (!array.count) {
            return self;
        }
        
        [self createScrollViewWithArr:array];
        
        [self createPageControlWithArray:array];
    }
    return self;
}


- (void)createPageControlWithArray:(NSArray *)array {
//    self.page = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.viewForLastBaselineLayout.frame.size.height - 60, self.frame.size.width, 20)];
    self.page = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 60, self.frame.size.width, 20)];
    _page.backgroundColor = [UIColor clearColor];
    [self addSubview:_page];
    _page.numberOfPages = array.count;
    _page.currentPage = 0;
    _page.pageIndicatorTintColor = [UIColor lightGrayColor];
    // 选中点的颜色
    _page.currentPageIndicatorTintColor = [UIColor cyanColor];
    
    if (array.count < 2) {
        _page.hidden = YES;
    }
    //    // 添加方法
    //    [_page addTarget:self action:@selector(pageAction:) forControlEvents:UIControlEventValueChanged];
}

- (void)createScrollViewWithArr:(NSArray *)array {
    
    _scaleScrollView = [[UIScrollView alloc]initWithFrame:self.frame];
    _scaleScrollView.bounces = NO;
    _scaleScrollView.showsHorizontalScrollIndicator = NO;
    _scaleScrollView.showsVerticalScrollIndicator = NO;
    _scaleScrollView.backgroundColor = [UIColor blackColor];
    _scaleScrollView.contentSize = CGSizeMake(self.frame.size.width * array.count, 0);
    _scaleScrollView.delegate = self;
    _scaleScrollView.pagingEnabled = YES;
    [self addSubview:_scaleScrollView];
    
    UIButton *backButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [self addSubview:backButton];
    backButton.frame = CGRectMake(16, 31, 20, 20);
    [backButton setBackgroundImage:[UIImage imageNamed:@"返回"] forState:(UIControlStateNormal)];
    [backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self createPhotoViewWithArr:array];
}

- (void)backButtonAction:(UIButton *)button {
    self.block();
}

- (void)createPhotoViewWithArr:(NSArray *)array {
    
    for (NSInteger i = 0; i < array.count; i++) {
        
        UIImage *image = nil;
        if ([array[i] isKindOfClass:[UIImage class]]) {
            image = array[i];
        } else {
            image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:array[i]]]];
        }
        self.photoView = [[VIPhotoView alloc] initWithFrame:CGRectMake(self.frame.size.width * i, 0, self.frame.size.width, self.frame.size.height) andImage:image];
        __weak typeof(self) weakSelf = self;
        _photoView.block = ^{
            weakSelf.block();
        };
        _photoView.autoresizingMask = (1 << 6) -1;
        [self.scaleScrollView addSubview:_photoView];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    [_photoView becomeMin];
    _page.currentPage = scrollView.contentOffset.x / self.frame.size.width;
}


@end
