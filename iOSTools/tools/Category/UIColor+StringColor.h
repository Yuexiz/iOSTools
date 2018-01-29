//
//  UIColor+StringColor.h
//  iOSTools
//
//  Created by Yuexiz on 2018/1/27.
//  Copyright © 2018年 张跃曦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (StringColor)

+ (UIColor *)yx_colorFromString:(NSString *)str;

+ (UIColor *)yx_colorWithHexString: (NSString *) hexString;
@end
