//
//  UIColor+StringColor.m
//  iOSTools
//
//  Created by Yuexiz on 2018/1/27.
//  Copyright © 2018年 张跃曦. All rights reserved.
//

#import "UIColor+StringColor.h"

@implementation UIColor (StringColor)

+ (UIColor *)yx_colorFromString:(NSString *)str {
    if ([[str substringToIndex:1] isEqualToString:@"#"] || [str hasPrefix:@"0X"]){
        return [self yx_colorWithHexString:str];
    }else{
        NSString *colorString = [str lowercaseString];
        
        if ([colorString isEqualToString:@"red"]){
            return [UIColor redColor];
        }else if ([colorString isEqualToString:@"blue"]){
            return [UIColor blueColor];
        }else if ([colorString isEqualToString:@"orange"]){
            return [UIColor orangeColor];
        }else if ([colorString isEqualToString:@"yellow"]){
            return [UIColor yellowColor];
        }else if ([colorString isEqualToString:@"brown"]){
            return [UIColor brownColor];
        }else if ([colorString isEqualToString:@"gray"]){
            return [UIColor grayColor];
        }else if ([colorString isEqualToString:@"green"]){
            return [UIColor greenColor];
        }else if ([colorString isEqualToString:@"purple"]){
            return [UIColor purpleColor];
        }else if ([colorString isEqualToString:@"magenta"]){
            return [UIColor magentaColor];
        }else if ([colorString isEqualToString:@"cyan"]){
            return [UIColor cyanColor];
        }else if ([colorString isEqualToString:@"white"]){
            return [UIColor whiteColor];
        }else if ([colorString isEqualToString:@"black"]){
            return [UIColor blackColor];
        }else if ([colorString isEqualToString:@"clear"]){
            return [UIColor clearColor];
        }
    }
    
    return [UIColor blackColor];
}

+ (UIColor *)yx_colorWithHexString: (NSString *) hexString {
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self yx_colorComponentFrom: colorString start: 0 length: 1];
            green = [self yx_colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self yx_colorComponentFrom: colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [self yx_colorComponentFrom: colorString start: 0 length: 1];
            red   = [self yx_colorComponentFrom: colorString start: 1 length: 1];
            green = [self yx_colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self yx_colorComponentFrom: colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self yx_colorComponentFrom: colorString start: 0 length: 2];
            green = [self yx_colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self yx_colorComponentFrom: colorString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self yx_colorComponentFrom: colorString start: 0 length: 2];
            red   = [self yx_colorComponentFrom: colorString start: 2 length: 2];
            green = [self yx_colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self yx_colorComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            [NSException raise:@"Invalid color value" format: @"Color value %@ is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", hexString];
            break;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}

+ (CGFloat)yx_colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

@end
