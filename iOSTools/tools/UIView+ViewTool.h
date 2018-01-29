//
//  UIView+ViewTool.h
//  iOSTools
//
//  Created by Yuexiz on 2018/1/23.
//  Copyright © 2018年 Yuexiz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+StringColor.h"

#define UNDERLINECOLOR  [UIColor yx_colorFromString:@"#EBEBEB"]

@interface UIView (ViewTool)

- (void)sizeFitFrameWithView: (UIView *)view;
- (void)sizeFitFrameWithView: (UIView *)view additionalY:(CGFloat)y;

//设置圆角
- (void)setRoundCornerRadius;

// 设置底部线
- (void)setUnderLineWithLeft:(CGFloat)left right:(CGFloat)right color:(UIColor *)color;

- (UIView *)setLineWithY:(CGFloat)y left:(CGFloat)left right:(CGFloat)right color:(UIColor *)color;

// 接收字符串数组，遍历并做成一个view
- (UIView *)setRulesViewWithFrame:(CGRect)rect stringArray:(NSArray *)array textColor:(UIColor *)color textFont:(CGFloat)font lineSpacing:(CGFloat)height;

- (UIView *)setRulesViewWithFrame:(CGRect)rect stringArray:(NSArray *)array textColor:(UIColor *)color;

// 设置子view在superView的center
- (void)setViewCenterY:(CGFloat)y ;


@end
