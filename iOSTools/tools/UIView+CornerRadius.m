//
//  UIView+CornerRadius.m
//  JiuFuWallet
//
//  Created by Yuexiz on 2018/1/11.
//  Copyright © 2018年 Yuexiz. All rights reserved.
//

#import "UIView+CornerRadius.h"

IB_DESIGNABLE
@implementation UIView (CornerRadius)

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
    self.layer.masksToBounds = YES;
}

- (CGFloat)xib_cornerRadius {
    return self.layer.cornerRadius;
    
}

@end
