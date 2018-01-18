//
//  EffectView.m
//  iOSTools
//
//  Created by Yuexiz on 2018/1/11.
//  Copyright © 2018年 Yuexiz. All rights reserved.
//

#import "EffectView.h"
#import "MainViewController.h"

@implementation EffectView

- (void)awakeFromNib {
    [super awakeFromNib];
    _tempLabel.text = @"点击control改变数字";
}

- (IBAction)clicked:(id)sender {
    _tempLabel.text = [NSString stringWithFormat:@"%d", arc4random() % 1000];
    [[self getCurrentVC].navigationController pushViewController:[MainViewController new] animated:YES];
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
