//
//  YXTabScrollView.h
//  iOSTools
//
//  Created by Yuexiz on 2018/1/17.
//  Copyright © 2018年 Yuexiz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YXTabScrollDelegate;

@interface YXTabScrollView : UIScrollView

@property (weak, nonatomic) id<YXTabScrollDelegate> tabScrollDelegate;

- (instancetype)initWithFrame:(CGRect)frame tabViews:(NSArray *)tabViews tabBarHeight:(CGFloat)height tabColor:(UIColor *)color backgroundColor:(UIColor *)backgroundColor selectedTabIndex:(NSInteger)index style:(NSInteger)style;

- (instancetype)initWithFrame:(CGRect)frame tabViews:(NSArray *)tabViews tabBarHeight:(CGFloat)height tabColor:(UIColor *)color backgroundColor:(UIColor *)backgroundColor style:(NSInteger)style;

- (void)animateToTabAtIndex:(NSInteger)index;
- (void)animateToTabAtIndex:(NSInteger)index animated:(BOOL)animated;

@end

@protocol YXTabScrollDelegate <NSObject>

- (void)tabScrollView:(YXTabScrollView *)tabScrollView didSelectTabAtIndex:(NSInteger)index;

@end
