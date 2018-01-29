//
//  YXValidationCodeView.m
//  iOSTools
//
//  Created by Yuexiz on 2018/1/29.
//  Copyright © 2018年 张跃曦. All rights reserved.
//

#import "YXValidationCodeView.h"
#import "YuexizTools.h"

@interface YXValidationCodeView() <UITextFieldDelegate>

@property (nonatomic, strong) NSMutableArray *labelArr; // label数组
@property (nonatomic, assign) NSInteger labelCount;     // label的数量
@property (nonatomic, assign) CGFloat labelDistance;    // label之间的距离 暂时无用

@property (nonatomic, strong) UIColor *defaultColor;    //默认颜色 需要可以开放接口
@property (nonatomic, strong) UIColor *changedColor;    //默认选中颜色

@property (nonatomic, strong) UITextField *codeTextField;

@property (nonatomic, assign) BOOL display;

@end

@implementation YXValidationCodeView

- (instancetype)initWithFrame:(CGRect)frame labelCount:(NSInteger)count stringDisplay:(BOOL)display {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.labelCount = count;
        self.display = display;
        self.labelDistance = -0.5;
        self.defaultColor = [UIColor yx_colorFromString:@"B2B4C6"];
        self.changedColor = [UIColor yx_colorFromString:@"B2B4C6"];
        [self setupViews];
    }
    
    return self;
}

- (void)setupViews {
    
    CGFloat labelHeight = self.codeTextField.yx_height;
    CGFloat labelWidth = labelHeight * 56 / 50;
    
    CGFloat labelX = (self.yx_width - self.labelCount * labelWidth - (self.labelCount - 1) * 0.5 ) / 2;
    
    for (int i = 0; i < self.labelCount; i++) {
        if (i != 0) {
            labelX += labelWidth + self.labelDistance;
        }
        NSLog(@"%d---%f", i, labelX);
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelX, 0, labelWidth, labelHeight)];
        [self addSubview:label];
        label.font = [UIFont systemFontOfSize:20];
        label.textAlignment = NSTextAlignmentCenter;
        label.layer.borderColor = [UIColor blackColor].CGColor;
        label.layer.borderWidth = 0.5;
        [self.labelArr addObject:label];
    }
}

#pragma mark - Lazy
- (UITextField *)codeTextField {
    if (!_codeTextField) {
        _codeTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.yx_width, self.yx_height)];
        _codeTextField.backgroundColor = [UIColor clearColor];
        _codeTextField.textColor = [UIColor clearColor];
        _codeTextField.tintColor = [UIColor clearColor];
        _codeTextField.delegate = self;
        _codeTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _codeTextField.keyboardType = UIKeyboardTypeNumberPad;
        _codeTextField.layer.borderColor = [_defaultColor CGColor];
        [_codeTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:_codeTextField];
    }
    return _codeTextField;
}

- (NSMutableArray *)labelArr {
    if (!_labelArr) {
        _labelArr = [NSMutableArray array];
    }
    return _labelArr;
}

- (void)textFieldDidChange:(UITextField *)textField {
    NSInteger i = textField.text.length;
    if (i == 0) {
        ((UILabel *)[self.labelArr objectAtIndex:0]).text = @"";
        ((UILabel *)[self.labelArr objectAtIndex:0]).layer.borderColor = _defaultColor.CGColor;
    } else {
        if (_display) {
            ((UILabel *)[self.labelArr objectAtIndex:i - 1]).text = [NSString stringWithFormat:@"%C", [textField.text characterAtIndex:i - 1]];
        } else {
            ((UILabel *)[self.labelArr objectAtIndex:i - 1]).text = [NSString stringWithFormat:@"%@", @"🤣"];
        }
        
        ((UILabel *)[self.labelArr objectAtIndex:i - 1]).layer.borderColor = _changedColor.CGColor;
        ((UILabel *)[self.labelArr objectAtIndex:i - 1]).textColor = _changedColor;
        if (self.labelCount > i) {
            ((UILabel *)[self.labelArr objectAtIndex:i]).text = @"";
            ((UILabel *)[self.labelArr objectAtIndex:i]).layer.borderColor = _defaultColor.CGColor;
        }
    }
    if (self.codeBlock) {
        self.codeBlock(textField.text);
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    } else if (string.length == 0) {
        return YES;
    } else if (textField.text.length >= self.labelCount) {
        return NO;
    } else {
        return YES;
    }
}

@end
