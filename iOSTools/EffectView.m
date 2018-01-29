//
//  EffectView.m
//  iOSTools
//
//  Created by Yuexiz on 2018/1/11.
//  Copyright © 2018年 Yuexiz. All rights reserved.
//

#import "EffectView.h"
#import "MainViewController.h"
#import "HahahaPopView.h"
#import "YuexizTools.h"
#import "YXValidationCodeView.h"

@interface EffectView ()
@property (nonatomic, strong) HahahaPopView *hahaView;
@end

@implementation EffectView

- (void)awakeFromNib {
    [super awakeFromNib];
    _tempLabel.text = @"点击control改变数字";
    
    _hahaView = [[UINib nibWithNibName:@"HahahaPopView" bundle:[NSBundle mainBundle]] instantiateWithOwner:nil options:nil].firstObject;
    
    _hahaView.frame = CGRectMake(0, 0, 375, 200);
    
    YXValidationCodeView *a = [[YXValidationCodeView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 50) labelCount:6 stringDisplay:NO];
    
    [self addSubview:a];
    
}

- (IBAction)clicked:(id)sender {
    _tempLabel.text = [NSString stringWithFormat:@"%d", arc4random() % 1000];
    [[self getCurrentVC].navigationController pushViewController:[MainViewController new] animated:YES];
}

- (IBAction)popViewButtonClick:(id)sender {
    NSLog(@"弹窗弹出");
    [_hahaView show];
}

- (UIViewController *)getCurrentVC {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    
    return currentVC;
}

- (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC {
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
        
    } else {
        // 根视图为非导航类
        
        currentVC = rootVC;
    }
    
    return currentVC;
}

@end
