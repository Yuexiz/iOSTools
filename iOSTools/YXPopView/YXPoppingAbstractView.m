//
//  YXPoppingAbstractView.m
//  iOSTools
//
//  Created by Yuexiz on 2018/1/25.
//  Copyright © 2018年 Yuexiz. All rights reserved.
//

#import "YXPoppingAbstractView.h"

@interface YXPoppingAbstractView ()

@property (nonatomic, strong) YXPopViewHelper *popViewHelper;

@end

@implementation YXPoppingAbstractView

- (instancetype)initWithSize:(CGSize)size maskStatus:(MaskStatus)maskStatus {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self initPopViewHelperWithSize:size maskStatus:maskStatus];
        
    }
    
    return self;
}

- (void)initPopViewHelperWithSize:(CGSize)size maskStatus:(MaskStatus)maskStatus {

    self.frame = CGRectMake(0, 0, size.width, size.height);
    _popViewHelper = [[YXPopViewHelper alloc] initWithSuperView:nil targetView:self maskStatus:maskStatus];
    
}

- (void)show {
    [_popViewHelper showPoppingViewWithAnimated:YES];
}

- (void)hide {
    [_popViewHelper hidePoppingViewWithAnimated:YES];
}

@end
