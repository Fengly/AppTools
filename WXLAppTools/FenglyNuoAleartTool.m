//
//  FenglyNuoAleartTool.m
//  Fabric
//
//  Created by Riches on 16/6/25.
//  Copyright © 2016年 Riches. All rights reserved.
//

#import "FenglyNuoAleartTool.h"

@interface FenglyNuoAleartTool ()<UIAlertViewDelegate>

@property (nonatomic, retain) UIAlertController *alertC;

@property (nonatomic, retain) UIViewController *vc;

@property (nonatomic, assign) BOOL isClick;

@end

@implementation FenglyNuoAleartTool

+ (id)judgeInfoIsNullForClickWithStr:(NSString *)str controller:(UIViewController *)controller {
    return [[[self class] alloc] initWithStr:str controller:controller isClick:YES];
}

+ (id)judgeInfoIsNullWithStr:(NSString *)str controller:(UIViewController *)controller {
    
    return [[[self class] alloc] initWithStr:str controller:controller isClick:NO];
}

- (instancetype)initWithStr:(NSString *)str controller:(UIViewController *)controller isClick:(BOOL)isClick {
    self = [super init];
    if (self) {
        _isClick = isClick;
        if (IOSDD8) {
            [self createSubViewWithStr:str controller:[[UIApplication sharedApplication] keyWindow].rootViewController];
        } else {
            [[Toast shareInstanceToast] makeToast:str duration:kDurationTime];
        }
    }
    return self;
}


- (void)createAleartViewWithStr:(NSString *)str {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"info", nil) message:str delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
    alertView.delegate = self;
    [alertView show];
}


- (void)createSubViewWithStr:(NSString *)str controller:(UIViewController *)controller {

    self.vc = controller;
    
    self.alertC = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"info", nil) message:str preferredStyle:UIAlertControllerStyleAlert];
    
    _alertC.navigationController.modalPresentationStyle = UIModalPresentationCurrentContext;

    [_vc presentViewController:_alertC animated:YES completion:nil];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", nil) style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
       [_vc dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [_alertC addAction:cancel];
}



@end
