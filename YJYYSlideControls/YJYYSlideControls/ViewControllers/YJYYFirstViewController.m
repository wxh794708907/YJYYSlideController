//
//  YJYYFirstViewController.m
//  YJYYSlideControls
//
//  Created by 遇见远洋 on 16/8/25.
//  Copyright © 2016年 遇见远洋. All rights reserved.
//

#import "YJYYFirstViewController.h"

@interface YJYYFirstViewController ()

@end

@implementation YJYYFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor cyanColor];
    UILabel * remindLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    remindLabel.center = self.view.center;
    remindLabel.text = @"我是第一个控制器";
    remindLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:remindLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
