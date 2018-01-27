//
//  UILabel+NormalLabel.m
//  JiuFuWallet
//
//  Created by Yuexiz on 2018/1/23.
//  Copyright © 2018年 jiufu. All rights reserved.
//

#import "UILabel+NormalLabel.h"
#import "UIView+FrameAdditions.h"

@implementation UILabel (NormalLabel)

+ (UILabel *)setNormalLabelWithFrame:(CGRect)rect fontSize:(CGFloat)fontSize text:(NSString *)str textColor:(UIColor *)textColor superView:(UIView *)superView {
    
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label.backgroundColor = [UIColor clearColor];
    label.text = str;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor = textColor;
    [superView addSubview:label];
    
    return label;
    
}

+ (UILabel *)setAlignmentCenterLabelWithFrame:(CGRect)rect fontSize:(CGFloat)fontSize text:(NSString *)str textColor:(UIColor *)textColor superView:(UIView *)superView {
    UILabel *label = [UILabel setNormalLabelWithFrame:rect fontSize:fontSize text:str textColor:textColor superView:superView];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

+ (UILabel *)setAlignmentRightLabelWithFrame:(CGRect)rect fontSize:(CGFloat)fontSize text:(NSString *)str textColor:(UIColor *)textColor superView:(UIView *)superView {
    UILabel *label = [UILabel setNormalLabelWithFrame:rect fontSize:fontSize text:str textColor:textColor superView:superView];
    label.textAlignment = NSTextAlignmentRight;
    return label;
}

+ (UILabel *)setAlignmentLeftLabelWithFrame:(CGRect)rect fontSize:(CGFloat)fontSize text:(NSString *)str textColor:(UIColor *)textColor superView:(UIView *)superView {
    UILabel *label = [UILabel setNormalLabelWithFrame:rect fontSize:fontSize text:str textColor:textColor superView:superView];
    label.textAlignment = NSTextAlignmentLeft;
    return label;
}

+ (UILabel *)setAlignmentLeftLabelWithCenterOriginX:(CGFloat)x realY:(CGFloat)y fontSize:(CGFloat)fontSize text:(NSString *)str textColor:(UIColor *)textColor superView:(UIView *)superView {
    UILabel *label = [UILabel setNormalLabelWithFrame:(CGRect)CGRectZero fontSize:(CGFloat)fontSize text:str textColor:textColor superView:superView];
    label.textAlignment = NSTextAlignmentLeft;
    [label sizeToFit];
    label.center = CGPointMake(label.yx_width / 2 + x, y);
    
    return label;
}

@end
