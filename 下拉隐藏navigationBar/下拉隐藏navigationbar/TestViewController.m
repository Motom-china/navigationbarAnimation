//
//  TestViewController.m
//  下拉隐藏navigationbar
//
//  Created by motom on 16/8/17.
//  Copyright © 2016年 motom. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property(nonatomic,strong)UIView *barView;

@property(nonatomic,assign)BOOL isHide;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    // Do any additional setup after loading the view.
}

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define barViewHeight 44

-(void)setupView
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, barViewHeight , SCREEN_WIDTH,SCREEN_HEIGHT )];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = YES;
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    
    //下部的barView
    UIView *barView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, barViewHeight)];
    barView.backgroundColor = [UIColor redColor];
    [self.view addSubview:barView];
    self.barView = barView;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if ([object isEqual:self.tableView] && [keyPath isEqualToString:@"contentOffset"]) {
        
        CGFloat new = [change[@"new"] CGPointValue].y ;
        CGFloat old = [change[@"old"] CGPointValue].y ;
        //因为 contentoffset的y值在监听的时候 变化的值不连续，所以根据两个y相减来获取滚动速度，也就是i的值。
        CGFloat i = new - old;
        
        if (i<-1 && self.tableView.contentOffset.y < 0) {
            [self.navigationController.navigationBar setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
            [self.barView setFrame:CGRectMake(0, 64, SCREEN_WIDTH, barViewHeight)];
        }
        
        //判断
        if (self.tableView.contentOffset.y > -64 && self.tableView.contentOffset.y < -1) {
            
            [self.navigationController.navigationBar setFrame:CGRectMake(0, -self.tableView.contentOffset.y - 64, SCREEN_WIDTH, 64)];
            self.navigationController.navigationBar.alpha = -self.tableView.contentOffset.y/64.0;
            
            [self.barView setFrame:CGRectMake(0, -self.tableView.contentOffset.y, SCREEN_WIDTH, barViewHeight)];
            
        }
        else if (self.tableView.contentOffset.y >0) {
            if (i<-1) {
                _isHide = NO;
            }
            if (i>1) {
                _isHide = YES;
            }
            
            [self.navigationController setNavigationBarHidden:_isHide animated:YES];
            if (_isHide) {
                [self.barView setFrame:CGRectMake(0, 20, SCREEN_WIDTH, barViewHeight)];
            }
            else if(_isHide == NO)
            {
                [self.barView setFrame:CGRectMake(0, 64, SCREEN_WIDTH, barViewHeight)];
            }
        }
        
        
        
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"测试%ld",(long)indexPath.row];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
