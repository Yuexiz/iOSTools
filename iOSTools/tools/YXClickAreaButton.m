//
//  YXClickAreaButton.m
//  iOSTools
//
//  Created by Yuexiz on 2018/1/25.
//  Copyright © 2018年 Yuexiz. All rights reserved.
//

#import "YXClickAreaButton.h"

@implementation YXClickAreaButton

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event {

    CGRect bounds = self.bounds;

    CGFloat widthDelta = MAX(36.0 - bounds.size.width, 0);

    CGFloat heightDelta = MAX(36.0 - bounds.size.height, 0);

    bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta);

    return CGRectContainsPoint(bounds, point);

}

+ (YXClickAreaButton *)setCustomButtonWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor fontSize:(CGFloat)fontSize superView:(UIView *)superView {
    YXClickAreaButton *button = [YXClickAreaButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [superView addSubview:button];
    
    return button;
}

+ (YXClickAreaButton *)setImageButtonWithFrame:(CGRect)frame backgroundImage:(UIImage *)backgroundImage superView:(UIView *)superView {
    YXClickAreaButton *button = [YXClickAreaButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    [superView addSubview:button];
    
    return button;
}

@end
