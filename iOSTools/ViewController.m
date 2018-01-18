//
//  ViewController.m
//  iOSTools
//
//  Created by Yuexiz on 2018/1/11.
//  Copyright © 2018年 Yuexiz. All rights reserved.
//

#import "ViewController.h"
#import "EffectView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)loadView {

    self.view = [[UINib nibWithNibName:@"EffectView" bundle:[NSBundle mainBundle]] instantiateWithOwner:nil options:nil].firstObject;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"测试测试哦";
    NSLog(@"%@", NSStringFromClass(self.class));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
