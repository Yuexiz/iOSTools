//
//  YXTabScrollViewController.m
//  iOSTools
//
//  Created by Yuexiz on 2018/1/17.
//  Copyright © 2018年 张跃曦. All rights reserved.
//

#import "YXTabScrollViewController.h"
#import "YXTabScrollView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define isFourInch ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

@interface YXTabScrollViewController () <YXTabDelegate, UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (strong, nonatomic) YXTabScrollView *header;
@property (assign, nonatomic) NSInteger selectedIndex;

@property (strong, nonatomic) NSMutableArray *viewControllers;
@property (strong, nonatomic) NSMutableArray *tabTitles;
@property (strong, nonatomic) UIColor *headerColor;
@property (strong, nonatomic) UIColor *tabBackgroundColor;
@property (assign, nonatomic) CGFloat headerHeight;
@property (nonatomic, assign) YXTabContentType tabContentType;
@end

@implementation YXTabScrollViewController

#pragma mark - Initialize Methods

- (instancetype)init {
    if (self = [super init]) {
        self = [self initWithContentType:YXTabTypeNOHeader];
    }
    return self;
}

- (instancetype)initWithContentType:(YXTabContentType)type {
    if (self = [super init]) {
        [self setContentViewWithType:type];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    [self setPageViewController:[[UIPageViewController alloc]
                                 initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                 navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                 options:nil]];
    
    for (UIView *view in [[[self pageViewController] view] subviews]) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            [(UIScrollView *)view setCanCancelContentTouches:YES];
            [(UIScrollView *)view setDelaysContentTouches:NO];
        }
    }
    
    [[self pageViewController] setDataSource:self];
    [[self pageViewController] setDelegate:self];
    
    
    [self addChildViewController:self.pageViewController];
    [self.pageViewController didMoveToParentViewController:self];
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 40)];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 500);
    }
    
    return _scrollView;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [self reloadTabs];
}

- (void)setContentViewWithType:(YXTabContentType)type {
    self.tabContentType = type;
    
    switch (type) {
        case YXTabTypeFullView: {
            [self.view addSubview:self.pageViewController.view];
        }
            break;
        case YXTabTypeNOHeader: {
            [self.view addSubview:self.scrollView];
            [self.scrollView addSubview:self.pageViewController.view];
        }
            break;
        default:
            break;
    }
}
#pragma mark - Page View Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger pageIndex = [[self viewControllers] indexOfObject:viewController];
    return (pageIndex > 0 && pageIndex < [[self viewControllers] count]) ? [self viewControllers][pageIndex - 1]: nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger pageIndex = [[self viewControllers] indexOfObject:viewController];
    return pageIndex < [[self viewControllers] count] - 1 ? [self viewControllers][pageIndex + 1]: nil;
}

#pragma mark - Page View Delegate

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers {
    NSInteger index = [[self viewControllers] indexOfObject:pendingViewControllers[0]];
    
    if ([[self delegate] respondsToSelector:@selector(tabPager:willTransitionToTabAtIndex:)]) {
        [[self delegate] tabPager:self willTransitionToTabAtIndex:index];
    }
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    [self setSelectedIndex:[[self viewControllers] indexOfObject:[[self pageViewController] viewControllers][0]]];
    [[self header] animateToTabAtIndex:[self selectedIndex]];
    
    if ([self selectedIndex]<0 || [self selectedIndex]>[self viewControllers].count-1) {
        [self setSelectedIndex: 0];
        [self.pageViewController setViewControllers:@[[self viewControllers][0]]
                                          direction:UIPageViewControllerNavigationDirectionReverse
                                           animated:NO
                                         completion:nil];
    }
    
    if ([[self delegate] respondsToSelector:@selector(tabPager:didTransitionToTabAtIndex:)]) {
        [[self delegate] tabPager:self didTransitionToTabAtIndex:[self selectedIndex]];
    }
}

#pragma mark - Tab Scroll View Delegate

- (void)tabScrollView:(YXTabScrollView *)tabScrollView didSelectTabAtIndex:(NSInteger)index {
    if (index != [self selectedIndex]) {
        if ([[self delegate] respondsToSelector:@selector(tabPager:willTransitionToTabAtIndex:)]) {
            [[self delegate] tabPager:self willTransitionToTabAtIndex:index];
        }
        
        BOOL isAnimated = self.tabPagerStyle != YXTabStyleDefault;
        
        [[self pageViewController]  setViewControllers:@[[self viewControllers][index]]
                                             direction:(index > [self selectedIndex]) ? UIPageViewControllerNavigationDirectionForward : UIPageViewControllerNavigationDirectionReverse
                                              animated:isAnimated
                                            completion:^(BOOL finished) {
                                                [self setSelectedIndex:index];
                                                
                                                if ([[self delegate] respondsToSelector:@selector(tabPager:didTransitionToTabAtIndex:)]) {
                                                    [[self delegate] tabPager:self didTransitionToTabAtIndex:[self selectedIndex]];
                                                }
                                            }];
    }
}

- (void)reloadData {
    [self setViewControllers:[NSMutableArray array]];
    [self setTabTitles:[NSMutableArray array]];
    
    for (int i = 0; i < [[self dataSource] numberOfViewControllers]; i++) {
        UIViewController *viewController;
        if ((viewController = [[self dataSource] viewControllerForIndex:i]) != nil) {
            [[self viewControllers] addObject:viewController];
        }
        
        if ([[self dataSource] respondsToSelector:@selector(titleForTabAtIndex:)]) {
            NSString *title;
            if ((title = [[self dataSource] titleForTabAtIndex:i]) != nil) {
                [[self tabTitles] addObject:title];
            }
        }
    }
    CGRect frame = [[self view] frame];
    
    if (self.tabContentType == YXTabTypeFullView) {
        [self reloadTabs];
        frame.origin.y = [self headerHeight];
        frame.size.height -= [self headerHeight];
        [[[self pageViewController] view] setFrame:frame];
    }
    
    [self.pageViewController setViewControllers:@[[self viewControllers][0]]
                                      direction:UIPageViewControllerNavigationDirectionReverse
                                       animated:NO
                                     completion:nil];
    [self setSelectedIndex:0];
}

- (void)reloadTabs {
    
    if ([[self dataSource] numberOfViewControllers] == 0)
        return;
    
    if ([[self dataSource] respondsToSelector:@selector(tabHeight)]) {
        [self setHeaderHeight:[[self dataSource] tabHeight]];
    } else {
        [self setHeaderHeight:44.0f];
    }
    
    if ([[self dataSource] respondsToSelector:@selector(tabColor)]) {
        [self setHeaderColor:[[self dataSource] tabColor]];
    } else {
        [self setHeaderColor:[UIColor orangeColor]];
    }
    
    if ([[self dataSource] respondsToSelector:@selector(tabBackgroundColor)]) {
        [self setTabBackgroundColor:[[self dataSource] tabBackgroundColor]];
    } else {
        [self setTabBackgroundColor:[UIColor colorWithWhite:0.95f alpha:1.0f]];
    }
    
    NSMutableArray *tabViews = [NSMutableArray array];
    
    if ([[self dataSource] respondsToSelector:@selector(viewForTabAtIndex:)]) {
        for (int i = 0; i < [[self viewControllers] count]; i++) {
            UIView *view;
            if ((view = [[self dataSource] viewForTabAtIndex:i]) != nil) {
                [tabViews addObject:view];
            }
        }
    } else {
        UIFont *font;
        if ([[self dataSource] respondsToSelector:@selector(titleFont)]) {
            font = [[self dataSource] titleFont];
        } else {
            font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20.0f];
        }
        UIColor *color;
        if ([[self dataSource] respondsToSelector:@selector(titleColor)]) {
            color = [[self dataSource] titleColor];
        } else {
            color = [UIColor blackColor];
        }
        
        for (NSString *title in [self tabTitles]) {
            UILabel *label = [UILabel new];
            [label setText:title];
            [label setTextAlignment:NSTextAlignmentCenter];
            [label setFont:font];
            [label setTextColor:color];
            [label sizeToFit];
            label.font = [UIFont systemFontOfSize:15.0 weight:UIFontWeightMedium];
            CGRect frame = [label frame];
            if ([self tabTitles].count == 4) {
                frame.size.width = 0.25 *SCREEN_WIDTH - 12.5;
            } else {
                frame.size.width = (isFourInch ? 0.23 : 0.22) * SCREEN_WIDTH - ([self tabTitles].count + 1) * 10 / ([self tabTitles].count);
            }
            
            frame.size.height = [self headerHeight];
            [label setFrame:frame];
            [tabViews addObject:label];
        }
    }
    
    if ([self header]) {
        [[self header] removeFromSuperview];
    }
    if (self.tabContentType == YXTabTypeFullView) {
        CGRect frame = self.view.frame;
        frame.origin.y = 0;
        frame.size.height = [self headerHeight];
        [self setHeader:[[YXTabScrollView alloc] initWithFrame:frame tabViews:tabViews tabBarHeight:[self headerHeight] tabColor:[self headerColor] backgroundColor:[self tabBackgroundColor] selectedTabIndex:self.selectedIndex style:self.tabPagerStyle]];
        [[self header] setTabScrollDelegate:self];
        
        [[self view] addSubview:[self header]];
    }
}

#pragma mark - Public Methods

- (void)selectTabbarIndex:(NSInteger)index {
    [self selectTabbarIndex:index animation:NO];
}

- (void)selectTabbarIndex:(NSInteger)index animation:(BOOL)animation {
    [self.pageViewController setViewControllers:@[[self viewControllers][index]]
                                      direction:UIPageViewControllerNavigationDirectionReverse
                                       animated:animation
                                     completion:nil];
    [[self header] animateToTabAtIndex:index animated:animation];
    [self setSelectedIndex:index];
}



@end
