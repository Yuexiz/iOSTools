//
//  YXPopContainerView.m
//  iOSTools
//
//  Created by Yuexiz on 2018/1/25.
//  Copyright © 2018年 Yuexiz. All rights reserved.
//

#import "YXPopContainerView.h"

@implementation YXPopContainerView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    UIView *result = [super hitTest:point withEvent:event];
    
    if (result != nil && result == self) {
        return nil;
    }
    
    return result;
}

@end
