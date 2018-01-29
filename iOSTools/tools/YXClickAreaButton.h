//
//  YXClickAreaButton.h
//  iOSTools
//
//  Created by Yuexiz on 2018/1/25.
//  Copyright © 2018年 Yuexiz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YXClickAreaButton : UIButton

+ (YXClickAreaButton *)setCustomButtonWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor fontSize:(CGFloat)fontSize superView:(UIView *)superView;

+ (YXClickAreaButton *)setImageButtonWithFrame:(CGRect)frame backgroundImage:(UIImage *)backgroundImage superView:(UIView *)superView;

@end
