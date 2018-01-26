//
//  YXPopViewManager.h
//  iOSTools
//
//  Created by Yuexiz on 2018/1/26.
//  Copyright © 2018年 张跃曦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YXPopViewHelper.h"

@interface YXPopViewManager : NSObject

+ (instancetype)shared;

- (void)addWithPopViewHelper:(YXPopViewHelper *)popViewHelper;

- (void)hideAll;

@end


@interface YXPopViewHelperContainer : NSObject

@property (nonatomic, weak) YXPopViewHelper *popViewHelper;

- (instancetype)initWithPopViewHelper:(YXPopViewHelper *)popViewHelper;

@end
