//
//  ViewController.m
//  下拉隐藏navigationbar
//
//  Created by motom on 16/8/17.
//  Copyright © 2016年 motom. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)setupView
{
  
    
    UIButton *btn = [[UIButton alloc]init];
    [btn  setFrame:CGRectMake(50, 50, 100, 60)];
    [btn setTitle:@"点击切换" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor blackColor];
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)btnClick
{
    TestViewController  *test = [[TestViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:test];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
