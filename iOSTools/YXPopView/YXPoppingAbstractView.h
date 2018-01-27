//
//  YXPoppingAbstractView.h
//  iOSTools
//
//  Created by Yuexiz on 2018/1/25.
//  Copyright © 2018年 Yuexiz. All rights reserved.
//

#import "YXPopContainerView.h"
#import "YXPopViewHelper.h"

/*
 弹窗继承该View
 */

@interface YXPoppingAbstractView : YXPopContainerView

- (void)initPopViewHelperWithSize:(CGSize)size maskStatus:(MaskStatus)maskStatus;

- (void)show;

- (void)hide;

@end
