//
//  ContentViewController1.m
//  VideoAVPlayer
//
//  Created by gaoyanlong on 15-3-9.
//  Copyright (c) 2015年 shaowenle. All rights reserved.
//

#import "ContentViewController1.h"
#import "SCNavTabBarController.h"
#import "OnlyTableViewController.h"
#import "OneCollectionViewController.h"
#import "TwoCollectionViewController.h"

@interface ContentViewController1 ()

@end

@implementation ContentViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //分享按钮
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"pui_sharingbtn@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(shareButton)];
    self.navigationItem.rightBarButtonItem = shareItem;
    
    OneCollectionViewController *oneViewController = [[OneCollectionViewController alloc] init];
    oneViewController.title = @"推荐";
    TwoCollectionViewController *twoViewController = [[TwoCollectionViewController alloc] init];
    twoViewController.title = @"专辑";
    OnlyTableViewController *threeViewController = [[OnlyTableViewController alloc] init];
    threeViewController.title = @"今日排行";
    SCNavTabBarController *navTabBarController = [[SCNavTabBarController alloc] init];
    navTabBarController.subViewControllers = @[oneViewController, twoViewController, threeViewController];
    navTabBarController.showArrowButton = YES;
    [navTabBarController addParentController:self];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)shareButton
{
    NSLog(@"分享未完成");
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
