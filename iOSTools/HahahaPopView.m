//
//  HahahaPopView.m
//  iOSTools
//
//  Created by Yuexiz on 2018/1/25.
//  Copyright © 2018年 Yuexiz. All rights reserved.
//

#import "HahahaPopView.h"
#import "YXPopViewHelper.h"
#import "YXPopViewManager.h"

@implementation HahahaPopView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initPopViewHelperWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 200) maskStatus:Normal];
    
}
- (IBAction)clicked:(id)sender {
    [[YXPopViewManager shared] hideAll];
}

@end
