//
//  DownloadViewController.m
//  VideoAVPlayer
//
//  Created by gaoyanlong on 15-3-6.
//  Copyright (c) 2015年 shaowenle. All rights reserved.
//

#import "DownloadViewController.h"
#import "DownCell.h"
#import "PlayerViewController.h"
#import "DownDate.h"

@interface DownloadViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    DownDate *downData;
}
@end

@implementation DownloadViewController
+ (DownloadViewController *)shareDownloadViewController
{
    static DownloadViewController *downloadViewController = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        downloadViewController = [[DownloadViewController alloc] init];
    });
    return downloadViewController;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    downData = [DownDate shareDownDate];
    // Do any additional setup after loading the view.
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.rowHeight = 80;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    [tableView registerNib:[UINib nibWithNibName:@"DownCell" bundle:nil] forCellReuseIdentifier:@"DownCell"];
    tableView.tableFooterView = [UIView new];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    DownCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DownCell" forIndexPath:indexPath];
//    cell.nameLabel.text = self.nameString;
//    cell.URL = self.URLString;
    cell.nameLabel.text = self.nameString;
    cell.URL = self.URLString;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
//点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlayerViewController *playerVC = [[PlayerViewController alloc] init];
    playerVC.falg2 = YES;
    [self.navigationController pushViewController:playerVC animated:YES];
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
