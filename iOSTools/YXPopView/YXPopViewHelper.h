//
//  YXPopViewHelper.h
//  iOSTools
//
//  Created by Yuexiz on 2018/1/25.
//  Copyright © 2018年 Yuexiz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger, MaskStatus) { // 阴影状态
    Hidden = 0, //不存在
    Transparent = 1, //不可见可点击
    TransparentAndDisable = 2, //不可见不可点击
    Normal = 3, //可见可点击
    ClickDisable = 4 // 可见不可点击
};

@interface YXPopViewHelper : NSObject

@property (nonatomic, assign) NSTimeInterval showAnimateDuration;
@property (nonatomic, assign) NSTimeInterval hideAnimateDuration;

@property (nonatomic, assign) NSTimeInterval showAnimateSpeed;
@property (nonatomic, assign) NSTimeInterval hideAnimateSpeed;

- (instancetype)initWithSuperView:(UIView *)superView targetView:(UIView *)targetView maskStatus:(MaskStatus)maskStatus;

- (void)showPoppingViewWithAnimated:(BOOL)animated;

- (void)hidePoppingViewWithAnimated:(BOOL)animated;

@end
