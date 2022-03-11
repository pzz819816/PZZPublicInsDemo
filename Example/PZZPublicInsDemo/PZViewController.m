//
//  PZViewController.m
//  PZZPublicInsDemo
//
//  Created by PZZ on 03/11/2022.
//  Copyright (c) 2022 PZZ. All rights reserved.
//

#import "PZViewController.h"
#import <WWInstructionFramework/WWInstructionFramework.h>

@interface PZViewController ()
@property (nonatomic,strong) WWInstructVC *instructVC;
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
    WWInstructVC *VC = [[WWInstructVC alloc]init];
    VC.appType = WWTrackType;
    VC.baseUrlStr = @"http://58.33.27.44:16500";
    VC.cookieStr = @"cbab7617951b11eca7fb5e775567842d";
    VC.imeiStr = @"863083051482406";
//
//    VC.appType = RMSType;
//    VC.baseUrlStr = @"http://58.33.27.44:17000";
//    VC.cookieStr = @"2b5f320495de11ecb1fd720e5e6c314d";
//    VC.imeiStr = @"000000000000710";
    [self.navigationController pushViewController:VC animated:YES];
}


@end
