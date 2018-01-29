//
//  YXValidationCodeView.h
//  iOSTools
//
//  Created by Yuexiz on 2018/1/29.
//  Copyright © 2018年 张跃曦. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^NNCodeDidChangeBlock)(NSString *codeString);

@interface YXValidationCodeView : UIView

// 回调的 block , 获取输入的字符串
@property (nonatomic, copy) NNCodeDidChangeBlock codeBlock;

- (instancetype)initWithFrame:(CGRect)frame labelCount:(NSInteger)count stringDisplay:(BOOL)display;

@end
