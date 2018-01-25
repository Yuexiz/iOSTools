//
//  SecondViewController.m
//  iOSTools
//
//  Created by Yuexiz on 2018/1/17.
//  Copyright © 2018年 Yuexiz. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tempTableVIew;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tempTableVIew = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tempTableVIew.delegate = self;
    _tempTableVIew.dataSource = self;
    _tempTableVIew.showsVerticalScrollIndicator = NO;
    _tempTableVIew.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_tempTableVIew];
    
    _tempTableVIew.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 26;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = [NSString stringWithFormat:@"homePageCellIdentifier%@",indexPath ];
    UITableViewCell  * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第二页的cell =%ld",indexPath.row];
    
    return cell;
}

@end
