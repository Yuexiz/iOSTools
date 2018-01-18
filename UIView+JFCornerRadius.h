//
//  UIView+JFCornerRadius.h
//  JiuFuWallet
//
//  Created by 张跃曦 on 2018/1/11.
//  Copyright © 2018年 jiufu. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface UIView (JFCornerRadius)

@property (nonatomic, strong) IBInspectable UIColor *xib_borderColor;
@property (nonatomic, assign) IBInspectable CGFloat xib_borderWidth;
@property (nonatomic, assign) IBInspectable CGFloat xib_cornerRadius;

@end
