//
//  UIView+JFCornerRadius.m
//  JiuFuWallet
//
//  Created by 张跃曦 on 2018/1/11.
//  Copyright © 2018年 jiufu. All rights reserved.
//

#import "UIView+JFCornerRadius.h"

IB_DESIGNABLE
@implementation UIView (JFCornerRadius)

- (void)setXib_borderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}

- (UIColor *)xib_borderColor {
    return [UIColor colorWithCGColor: self.layer.borderColor];
}

- (void)setXib_borderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
}

- (CGFloat)xib_borderWidth {
    return self.layer.borderWidth;
}

- (void)setXib_cornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
}

- (CGFloat)xib_cornerRadius {
    self.layer.masksToBounds = YES;
    return self.layer.cornerRadius;
    
}

@end
