//
//  YXPopViewHelper.m
//  iOSTools
//
//  Created by Yuexiz on 2018/1/25.
//  Copyright © 2018年 Yuexiz. All rights reserved.
//

#import "YXPopViewHelper.h"
#import "YXPopViewManager.h"
#import "YuexizTools.h"

typedef NS_ENUM (NSInteger, AnimationTarget) { // 阴影状态
    Unset = 0, //默认
    Show = 1, //最终要显示
    Hide = 2, //最终要隐藏
};

typedef void(^ShowAction)(void);
typedef void(^ShowCompletionAction)(BOOL);

typedef void(^HideAction)(void);
typedef void(^HideCompletionAction)(BOOL);

@interface YXPopViewHelper ()

@property (nonatomic, weak) UIView *targetView;
@property (nonatomic, assign) MaskStatus maskStatus;
@property (nonatomic, assign) AnimationTarget animationTarget;
@property (nonatomic, strong) UIView *superView;
@property (nonatomic, strong) UIControl *mask;
@property (nonatomic,assign) BOOL isShow;
@property (nonatomic,assign) BOOL isAnimating;

@property (nonatomic, assign) CGPoint beginOrigin; //开始位置
@property (nonatomic, assign) CGPoint showOrigin; //弹出后位置
@property (nonatomic, assign) CGPoint endOrigin; //收回

@property(copy ,nonatomic)ShowAction showAction;
@property(copy ,nonatomic)ShowCompletionAction showCompletionAction;

@property(copy ,nonatomic)HideAction hideAction;
@property(copy ,nonatomic)HideCompletionAction hideCompletionAction;

@end

@implementation YXPopViewHelper

- (instancetype)initWithSuperView:(UIView *)superView targetView:(UIView *)targetView maskStatus:(MaskStatus)maskStatus {
    self = [super init];
    if (self) {
        self.targetView = targetView;
        self.maskStatus = maskStatus;
        self.superView = superView ?: [UIApplication sharedApplication].keyWindow;
        self.animationTarget = Unset;
        self.showAnimateSpeed = 1500; // 这里外面赋值有点小问题，我需要考虑下。OC语言好烦
        self.hideAnimateSpeed = 1500;
        _maskStatus = Normal;
        _showOrigin = CGPointZero;
        
        [self setMaskViewWithStatus:maskStatus];
        
        [self setupPopFunc];
        
        targetView.hidden = YES;
        if (superView == nil) {
            [[YXPopViewManager shared] addWithPopViewHelper:self];
        }
    }
    
    return self;
    
}

- (void)setupPopFunc {
    
    __weak typeof(self) wself = self;
    self.showAction = ^{
        wself.mask.alpha = 0.3;
        CGRect rect = wself.targetView.frame;
        rect.origin = wself.showOrigin;
        wself.targetView.frame = rect;
        
        wself.targetView.alpha = 1;
    };
    
    self.showCompletionAction = ^(BOOL bValue){
        wself.isAnimating = NO;
        
        if (wself.animationTarget == Hide) {
            [wself hidePoppingViewWithAnimated:YES];
        } else {
            wself.animationTarget = Unset;
        }
    };
    
    self.hideAction = ^{
        wself.mask.alpha = 0;
        CGRect rect = wself.targetView.frame;
        rect.origin = wself.endOrigin;
        wself.targetView.frame = rect;
        
        wself.targetView.alpha = 1;
    };
    
    self.hideCompletionAction = ^(BOOL bValue){
        wself.isAnimating = NO;
        
        if (wself.animationTarget == Show) {
            [wself showPoppingViewWithAnimated:YES];
        } else {
            wself.animationTarget = Unset;
        }
    };
    
}

- (void)setMaskViewWithStatus:(MaskStatus)maskStatus {
    if (maskStatus == Hidden) {
        return;
    }
    
    _mask = [[UIControl alloc] initWithFrame:self.superView.frame];
    _mask.alpha = 0;
    
    BOOL maskHidden = maskStatus == Transparent || maskStatus == TransparentAndDisable;
    _mask.backgroundColor = maskHidden ? [UIColor clearColor] : [UIColor blackColor];
    [_mask addTarget:self action:@selector(clickMask) forControlEvents:UIControlEventTouchUpInside];
    
    [_superView addSubview:_mask];
    
}

- (void)clickMask {
    BOOL clickEnable = _maskStatus == ClickDisable || _maskStatus == TransparentAndDisable;
    
    if (!clickEnable) {
        [self hidePoppingViewWithAnimated:YES];
    }
}

// 暂时只有从下往上弹的，后续添加
- (void)setPopViewDirection {
    _beginOrigin.x = 0;
    //隐藏在下面
    _beginOrigin.y = CGRectGetMaxY(_superView.frame);
    
    _showOrigin.x = 0;
    
    _showOrigin.y = _superView.yx_height - _targetView.yx_height;
    
    if (@available(iOS 11.0, *)) {
        _showOrigin.y -= _superView.safeAreaInsets.bottom;
    }
    
    _endOrigin = _beginOrigin;
    
    _showAnimateDuration = _targetView.yx_height / _showAnimateSpeed;
    _hideAnimateDuration = _targetView.yx_height / _showAnimateSpeed;
}

- (void)setupUI {
    CGRect rect = self.targetView.frame;
    rect.origin = self.beginOrigin;
    self.targetView.frame = rect;

    _targetView.alpha = 1;
}

#pragma mark - Public Method

- (void)showPoppingViewWithAnimated:(BOOL)animated {
    self.animationTarget = Show;
//    if (_isShow) { return; }
    
    [self setPopViewDirection];
    
    [self setupUI];
    
    if (_mask) {
        [_superView bringSubviewToFront:_mask];
    }
    [_superView addSubview:_targetView];
    [_superView bringSubviewToFront:_targetView];
    _targetView.hidden = NO;
    
    _isShow = YES;
    
    if (animated) {
        [UIView animateWithDuration:MAX(_showAnimateDuration, 0.25) delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionLayoutSubviews animations:self.showAction completion:self.showCompletionAction];
    } else {
        self.showAction();
        self.showCompletionAction(YES);
        
    }
}

- (void)hidePoppingViewWithAnimated:(BOOL)animated {
    self.animationTarget = Hide;
//    if (_isShow) { return; }
    
    if (animated) {
        [UIView animateWithDuration:MAX(_hideAnimateDuration, 0.25) delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionLayoutSubviews animations:self.hideAction completion:self.hideCompletionAction];
    } else {
        self.hideAction();
        self.hideCompletionAction(YES);
        
    }
    
}

@end
