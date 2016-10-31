//
//  TouchMoveView.m
//  Base
//
//  Created by Riches on 16/5/28.
//  Copyright © 2016年 Riches. All rights reserved.
//

#import "TouchMoveView.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height


@interface TouchMoveView ()


@end

@implementation TouchMoveView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        

    }
    return self;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (Iphone4 || Iphone5) {
        return;
    }
    UITouch *touch = [touches anyObject];
    CGPoint point1 = [touch locationInView:self];
    CGPoint point2 = [touch previousLocationInView:self];
    
    self.center = CGPointMake(point1.x - point2.x + self.center.x, point1.y - point2.y + self.center.y);

//        self.currentCenter = CGPointMake(point1.x - point2.x + self.center.x, point1.y - point2.y + self.center.y);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (Iphone4 || Iphone5) {
        return;
    }
    UITouch *touch = [touches anyObject];
    CGPoint point1 = [touch locationInView:self];
    CGPoint point2 = [touch previousLocationInView:self];
    if (self.frame.origin.x <= 0.0) {
        [UIView animateWithDuration:0.1 animations:^{
            self.center = CGPointMake(self.frame.size.width / 2, point1.y - point2.y + self.center.y);
        }];
    }
    if (self.frame.origin.x + self.frame.size.width >= kWidth) {
        [UIView animateWithDuration:0.1 animations:^{
            self.center = CGPointMake(kWidth - self.frame.size.width / 2, point1.y - point2.y + self.center.y);
        }];
    }
    if (self.frame.origin.y <= 49.0) {
        [UIView animateWithDuration:0.1 animations:^{
            self.center = CGPointMake(point1.x - point2.x + self.center.x, self.frame.size.height / 2 + 20.0);
        }];
    }
    if (self.frame.origin.y + self.frame.size.height >= kHeight - 113) {
        [UIView animateWithDuration:0.1 animations:^{
            self.center = CGPointMake(point1.x - point2.x + self.center.x, kHeight - self.frame.size.height / 2 - 113 - 10);
        }];
    }
    if (self.frame.origin.x < kWidth / 2) {
        [UIView animateWithDuration:0.1 animations:^{
            self.center = CGPointMake(self.frame.size.width / 2 + 15, point1.y - point2.y + self.center.y);
        }];
    }
    if (self.frame.origin.x >= kWidth / 2) {
        [UIView animateWithDuration:0.1 animations:^{
            self.center = CGPointMake(kWidth - self.frame.size.width / 2 - 15, point1.y - point2.y + self.center.y);
        }];
    }
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */


@end
