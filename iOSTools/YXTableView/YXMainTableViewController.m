//
//  YXMainTableViewController.m
//  iOSTools
//
//  Created by Yuexiz on 2018/1/17.
//  Copyright © 2018年 张跃曦. All rights reserved.
//

#import "YXMainTableViewController.h"

@interface YXMainTableViewController () <UIGestureRecognizerDelegate>

@end

@implementation YXMainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeMotion:) name:@"YXReachTop" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeMotion:) name:@"YXLeaveTop" object:nil];
}

- (void)changeMotion:(NSNotification *)notification {
    
    NSString *notificationName = notification.name;
    
    if ([notificationName isEqualToString:@"YXReachTop"]) {
        NSDictionary *userInfo = notification.userInfo;
        NSString *canScroll = userInfo[@"canScroll"];
        if ([canScroll isEqualToString:@"true"]) {
            self.canScroll = YES;
            self.scrollView.showsVerticalScrollIndicator = YES;
        }
        
    } else if ([notificationName isEqualToString:@"YXLeaveTop"]) {
        self.scrollView.contentOffset = CGPointZero;
        self.canScroll = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
    }
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

#pragma mark - Protocol Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (!self.canScroll) {
        
        [scrollView setContentOffset:CGPointZero];
    }
    
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY < 0) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"YXLeaveTop" object:nil userInfo:@{@"canScroll": @"true"}];
    }
    
    _scrollView = scrollView;
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {

    if ([otherGestureRecognizer.view isKindOfClass:NSClassFromString(@"UILayoutContainerView")]) {

        if (otherGestureRecognizer.state == UIGestureRecognizerStateBegan && self.scrollView.contentOffset.x == 0) {
            return YES;
        }
    }
    return NO;
}

@end
