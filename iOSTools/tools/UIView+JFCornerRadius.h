//
//  UIView+JFCornerRadius.h
//  JiuFuWallet
//
//  Created by Yuexiz on 2018/1/11.
//  Copyright © 2018年 Yuexiz. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface UIView (JFCornerRadius)

@property (nonatomic, strong) IBInspectable UIColor *xib_borderColor;
@property (nonatomic, assign) IBInspectable CGFloat xib_borderWidth;
@property (nonatomic, assign) IBInspectable CGFloat xib_cornerRadius;

@end
