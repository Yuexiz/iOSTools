//
//  YXTabScrollViewController.h
//  iOSTools
//
//  Created by Yuexiz on 2018/1/17.
//  Copyright © 2018年 张跃曦. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YXTabStyle) {
    YXTabStyleDefault = 0,
    YXTabStyleAnimation,
};

typedef NS_ENUM(NSUInteger, YXTabContentType) {
    YXTabTypeFullView = 0,
    YXTabTypeNOHeader,
};

@protocol YXTabDataSource;
@protocol YXTabDelegate;

@interface YXTabScrollViewController : UIViewController

@property (weak, nonatomic) id<YXTabDataSource> dataSource;
@property (weak, nonatomic) id<YXTabDelegate> delegate;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (nonatomic, assign) YXTabStyle tabPagerStyle;

- (instancetype)initWithContentType:(YXTabContentType)type;


- (void)reloadData;
- (NSInteger)selectedIndex;

- (void)selectTabbarIndex:(NSInteger)index;
- (void)selectTabbarIndex:(NSInteger)index animation:(BOOL)animation;
@end

@protocol YXTabDataSource <NSObject>

@required
- (NSInteger)numberOfViewControllers;
- (UIViewController *)viewControllerForIndex:(NSInteger)index;

@optional
- (UIView *)viewForTabAtIndex:(NSInteger)index;
- (NSString *)titleForTabAtIndex:(NSInteger)index;
- (CGFloat)tabHeight;
- (UIColor *)tabColor;
- (UIColor *)tabBackgroundColor;
- (UIFont *)titleFont;
- (UIColor *)titleColor;

@end

@protocol YXTabDelegate <NSObject>

@optional
- (void)tabPager:(YXTabScrollViewController *)tabPager willTransitionToTabAtIndex:(NSInteger)index;
- (void)tabPager:(YXTabScrollViewController *)tabPager didTransitionToTabAtIndex:(NSInteger)index;

@end
