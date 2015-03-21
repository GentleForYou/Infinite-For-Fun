//
//  OnlyTableViewController.m
//  VideoAVPlayer
//
//  Created by gaoyanlong on 15-3-9.
//  Copyright (c) 2015年 shaowenle. All rights reserved.
//

#import "OnlyTableViewController.h"
#import "MyTableViewCell.h"
#import "ClassifyDataHandle3.h"
#import "UIImageView+WebCache.h"
#import "PlayerViewController.h"
#import "AFNetworking.h"
#import "playData1.h"
#import "PlayerDicData.h"
#import "MJRefresh.h"

@interface OnlyTableViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    ClassifyDataHandle3 *classifyDataHandle3;
    UITableView *tableView ;
}
@end

@implementation OnlyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.playData1 = [[PlayData1 alloc] init];
    self.playerDicData = [[PlayerDicData alloc] init];
    
    classifyDataHandle3 = [ClassifyDataHandle3 shareClassifyDataHandle3];
    // Do any additional setup after loading the view.
    tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.rowHeight = 80;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    [tableView registerNib:[UINib nibWithNibName:@"MyTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyTableViewCell"];
    tableView.tableFooterView = [UIView new];
    
    
    //下拉刷新
    [tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    //自动下拉刷新
    [tableView headerBeginRefreshing];
    //上拉加载
    [tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}


- (void)headerRereshing
{
    //结束下拉刷新
    [tableView headerEndRefreshing];
}

- (void)footerRereshing
{
    //结束上拉加载
    [tableView footerEndRefreshing];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return classifyDataHandle3.nameArray3.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   MyTableViewCell *cell = [tableView1 dequeueReusableCellWithIdentifier:@"MyTableViewCell" forIndexPath:indexPath];
    [cell.pic sd_setImageWithURL:[NSURL URLWithString:classifyDataHandle3.picArray3[indexPath.row]] placeholderImage:nil];
    cell.areaLabel.text = classifyDataHandle3.areaArray3[indexPath.row];
    cell.typeLabel.text = classifyDataHandle3.typeArray3[indexPath.row];
    cell.nameLabel.text = [NSString stringWithFormat:@"%ld. %@",indexPath.row + 1, classifyDataHandle3.nameArray3[indexPath.row]];
     return cell;
}
//点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *midString = classifyDataHandle3.IDArray3[indexPath.row];
    NSString *strIF = [NSString stringWithFormat:@"http://pm.funshion.com/v5/media/episode?id=%@&cl=aphone&ve=2.2.5.4&mac=087a4ca86a0a&uc=6",midString];
    //创建网络请求
    NSURL* URL = [NSURL URLWithString:strIF];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:URL];
    request.HTTPMethod = @"GET";
    request.timeoutInterval = 30;
    
    //创建AFNetworking的请求操作
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    //设置AFNetworking返回的数据 自动进行json解析
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    //设置内容类型
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //完成请求进入blocks
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //请求成功,打印返回数据
        NSArray *arrID = [responseObject objectForKey:@"episodes"];
        //        self.playerArray = [NSMutableArray arrayWithCapacity:0];
        //arrID.count是集数,从0开始,IDstring是第一季的ID,每个+1
        NSString *IDString = [arrID[0] objectForKey:@"id"];
        //播放网址
        NSString *str = [NSString stringWithFormat:@"http://pm.funshion.com/v5/media/play?id=%@&cl=aphone&ve=2.2.5.4&mac=087a4ca86a0a&uc=6",IDString];
        __weak OnlyTableViewController *blockSelf = self;
        [blockSelf.playData1 getData1:str block:^(NSString *string5) {
            PlayerViewController *playerVC = [[PlayerViewController alloc] init];
            playerVC.string9 = string5;
            [playerVC.playURLArray addObject:string5];
            //简介网址
            NSString *str2 = [NSString stringWithFormat:@"http://pm.funshion.com/v5/media/profile?id=%@&cl=aphone&ve=2.2.5.4&mac=087a4ca86a0a&uc=6",midString];
            [blockSelf.playerDicData getData2:str2 block:^(NSDictionary *dicData) {
                playerVC.string1 = [dicData objectForKey:@"name"];
                playerVC.string2 = [dicData objectForKey:@"poster"];
                playerVC.string3 = [dicData objectForKey:@"score"];
                playerVC.string4 = [dicData objectForKey:@"director"];
                playerVC.string5 = [dicData objectForKey:@"actor"];
                playerVC.string6 = [dicData objectForKey:@"category"];
                playerVC.string7 = [dicData objectForKey:@"release"];
                playerVC.string8 = [dicData objectForKey:@"description"];
                [self.navigationController pushViewController:playerVC animated:YES];
            }];
        }];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //请求失败,打印错误
        NSLog(@"Error: %@", error.localizedDescription);
    }];
    //开始请求
    [operation start];

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
