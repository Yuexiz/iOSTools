//
//  TempSegmentView.h
//  iOSTools
//
//  Created by Yuexiz on 2018/1/17.
//  Copyright © 2018年 张跃曦. All rights reserved.
//  随便抄了一个,嘻嘻嘻.有空就替换了...这个太烂了

#import <UIKit/UIKit.h>

@interface TempSegmentView : UIView <UIScrollViewDelegate>
@property (nonatomic,strong)NSArray * nameArray;
@property (nonatomic,strong)NSArray *controllers;
@property (nonatomic,strong)UIView * segmentView;
@property (nonatomic,strong)UIScrollView * segmentScrollV;
@property (nonatomic,strong)UILabel * line;
@property (nonatomic ,strong)UIButton * seleBtn;
@property (nonatomic,strong)UILabel * down;


- (instancetype)initWithFrame:(CGRect)frame controllers:(NSArray *)controllers titleArray:(NSArray *)titleArray ParentController:(UIViewController *)parentC  lineWidth:(float)lineW lineHeight:(float)lineH;

@end
