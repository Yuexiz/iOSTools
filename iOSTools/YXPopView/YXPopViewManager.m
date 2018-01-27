//
//  YXPopViewManager.m
//  iOSTools
//
//  Created by Yuexiz on 2018/1/26.
//  Copyright © 2018年 Yuexiz. All rights reserved.
//

#import "YXPopViewManager.h"

@interface YXPopViewManager ()

@property (nonatomic, strong) NSMutableArray<YXPopViewHelperContainer *> *popViewHelperContainers;
@property (nonatomic, strong) NSMutableArray<YXPopViewHelper *> *popViewHelperQueue; // queue有需求再写吧
@property (nonatomic, strong) YXPopViewHelper *showingPoppingViewHelper;

@end

@implementation YXPopViewManager

static YXPopViewManager *popViewManager = nil;

+ (instancetype)shared {
    
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        popViewManager = [[self alloc] init];

    }) ;
    
    return popViewManager ;
}

- (instancetype)init {
    if (self = [super init]) {
        _popViewHelperContainers = [NSMutableArray array];
        _popViewHelperQueue = [NSMutableArray array];
        _showingPoppingViewHelper = [[YXPopViewHelper alloc] init];
    }
    return self;
    
}

#pragma mark - Public Method

- (void)addWithPopViewHelper:(YXPopViewHelper *)popViewHelper {
    [self clearReleased];
    [_popViewHelperContainers addObject:[[YXPopViewHelperContainer alloc] initWithPopViewHelper:popViewHelper]];
    
}

- (void)hideAll {
    YXPopViewHelper *popViewHelper;
    for (YXPopViewHelperContainer *popViewHelperContainer in _popViewHelperContainers) {
        popViewHelper = popViewHelperContainer.popViewHelper;
        if (popViewHelper != nil) {
            [popViewHelper hidePoppingViewWithAnimated:YES];
        }
    }
    
    [self clearReleased];
}

#pragma mark - Private Method

- (void)clearReleased {
    YXPopViewHelperContainer *popViewHelperContainer;
    for (NSInteger i = _popViewHelperContainers.count - 1; i >= 0; i --) {
        popViewHelperContainer = _popViewHelperContainers[i];
        if (popViewHelperContainer.popViewHelper == nil) {
            [_popViewHelperContainers removeObjectAtIndex:i];
            
        }
    }
}

@end

@implementation YXPopViewHelperContainer

- (instancetype)initWithPopViewHelper:(YXPopViewHelper *)popViewHelper {
    
    self = [super init];
    if (self) {
        self.popViewHelper = popViewHelper;
    }
    return self;
}

@end
