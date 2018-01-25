//
//  UIView+FrameAdditions.m
//  iOSTools
//
//  Created by Yuexiz on 2018/1/25.
//  Copyright © 2018年 Yuexiz. All rights reserved.
//

#import "UIView+FrameAdditions.h"

@implementation UIView (FrameAdditions)

- (CGFloat)yx_x {
    return CGRectGetMinX(self.frame);
}

- (void)setYx_x:(CGFloat)yx_x {
    self.frame = CGRectMake(yx_x, CGRectGetMinY(self.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}

- (CGFloat)yx_y {
    return CGRectGetMinY(self.frame);
}

- (void)setYx_y:(CGFloat)yx_y {
    self.frame = CGRectMake(CGRectGetMinX(self.frame), yx_y, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}

- (CGFloat)yx_width {
    return CGRectGetWidth(self.frame);
}

- (void)setYx_width:(CGFloat)yx_width {
    self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), yx_width, CGRectGetHeight(self.frame));
}

- (CGFloat)yx_height {
    return CGRectGetHeight(self.frame);
}

- (void)setYx_height:(CGFloat)yx_height {
    self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), CGRectGetWidth(self.frame), yx_height);
}

@end
