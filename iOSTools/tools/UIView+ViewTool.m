//
//  UIView+ViewTool.m
//  iOSTools
//
//  Created by Yuexiz on 2018/1/23.
//  Copyright © 2018年 Yuexiz. All rights reserved.
//

#import "UIView+ViewTool.h"
#import "UILabel+NormalLabel.h"
#import "UIView+FrameAdditions.h"

@implementation UIView (ViewTool)

- (void)sizeFitFrameWithView: (UIView *)view {
    CGRect frame = self.frame;
    frame.size.height = CGRectGetMaxY(view.frame);
    self.frame = frame;
}

- (void)sizeFitFrameWithView: (UIView *)view additionalY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.size.height = CGRectGetMaxY(view.frame) + y;
    self.frame = frame;
}

- (void)sizeFitFrameWithY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.size.height = y;
    self.frame = frame;
}

- (void)setRoundCornerRadius {
    self.layer.cornerRadius = self.yx_height / 2;
    self.layer.masksToBounds = YES;
}

- (void)setUnderLineWithLeft:(CGFloat)left right:(CGFloat)right color:(UIColor *)color {
    if (!color) {
        color = UNDERLINECOLOR;
    }
    
    [self creatLineWithColor:color x:left y:self.yx_height width:self.yx_width - left - right];

}

- (UIView *)setLineWithY:(CGFloat)y left:(CGFloat)left right:(CGFloat)right color:(UIColor *)color {
    if (!color) {
        color = UNDERLINECOLOR;
    }
    
    UIView *middleLine = [self creatLineWithColor:color x:left y:y width:self.yx_width - left - right];
    return middleLine;
}

- (UIView *)creatLineWithColor:(UIColor *)color x:(CGFloat)x y:(CGFloat)y width:(CGFloat)width {
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, 0.5)];
    line.backgroundColor = color;
    [self addSubview:line];
    
    return line;
}

- (UIView *)setRulesViewWithFrame:(CGRect)rect stringArray:(NSArray *)array textColor:(UIColor *)color {
    UIView *rulesView = [self setRulesViewWithFrame:rect stringArray:array textColor:color textFont:12 lineSpacing:8];
    
    return rulesView;
}

- (UIView *)setRulesViewWithFrame:(CGRect)rect stringArray:(NSArray *)array textColor:(UIColor *)color textFont:(CGFloat)font lineSpacing:(CGFloat)height {
    UIView *rulesView = [[UIView alloc] initWithFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, 0)];
    CGFloat bottomHeight = 0;

    for (NSString *str in array) {
        
        UILabel * label = [UILabel setAlignmentLeftLabelWithFrame:CGRectMake(0, 0 + bottomHeight, rulesView.yx_width, 0) fontSize:font text:str textColor:color superView:rulesView];
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakByWordWrapping;
        [label sizeToFit];
        [rulesView addSubview:label];
        
        bottomHeight += label.yx_height + height;
        
    }
    
    [rulesView sizeFitFrameWithY:bottomHeight];
    return rulesView;
}

- (void)setViewCenterY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y - self.frame.size.height / 2;
    self.frame = frame;
}

@end
