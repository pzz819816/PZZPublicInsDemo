//
//  PZViewController.m
//  PZZPublicInsDemo
//
//  Created by PZZ on 03/11/2022.
//  Copyright (c) 2022 PZZ. All rights reserved.
//

#import "PZViewController.h"
#import "TestView.h"

@interface PZViewController ()
@property (nonatomic,strong) TestView *ddview;

@end

@implementation PZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"首页";
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(btnClcik) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(200, 200, 200, 200);
    
    self.ddview = [[TestView alloc]initWithFrame:CGRectMake(10, 500,400,400)];
    self.ddview.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.ddview];
}

- (void)btnClcik {
    
}


@end
