//
//  UILabel+NormalLabel.h
//  iOSTools
//
//  Created by Yuexiz on 2018/1/23.
//  Copyright © 2018年 Yuexiz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (NormalLabel)

+ (UILabel *)setNormalLabelWithFrame:(CGRect)rect fontSize:(CGFloat)fontSize text:(NSString *)str textColor:(UIColor *)textColor superView:(UIView *)superView;

+ (UILabel *)setAlignmentCenterLabelWithFrame:(CGRect)rect fontSize:(CGFloat)fontSize text:(NSString *)str textColor:(UIColor *)textColor superView:(UIView *)superView;

+ (UILabel *)setAlignmentRightLabelWithFrame:(CGRect)rect fontSize:(CGFloat)fontSize text:(NSString *)str textColor:(UIColor *)textColor superView:(UIView *)superView;

+ (UILabel *)setAlignmentLeftLabelWithFrame:(CGRect)rect fontSize:(CGFloat)fontSize text:(NSString *)str textColor:(UIColor *)textColor superView:(UIView *)superView;

+ (UILabel *)setAlignmentLeftLabelWithCenterOriginX:(CGFloat)x realY:(CGFloat)y fontSize:(CGFloat)fontSize text:(NSString *)str textColor:(UIColor *)textColor superView:(UIView *)superView;

@end
