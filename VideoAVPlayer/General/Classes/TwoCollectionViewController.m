//
//  TwoCollectionViewController.m
//  VideoAVPlayer
//
//  Created by gaoyanlong on 15-3-9.
//  Copyright (c) 2015年 shaowenle. All rights reserved.
//

#import "TwoCollectionViewController.h"
#import "CustomCollectionViewCell.h"
#import "HeaderCollectionReusableView1.h"
#import "ClassifyDataHandle2.h"
#import "UIImageView+WebCache.h"
#import "PlayerViewController.h"
#import "AFNetworking.h"
#import "playData1.h"
#import "PlayerDicData.h"
#import "MJRefresh.h"

static NSString *customIdntifier = @"custom";
static NSString *headerIdentifier1 = @"header1";
@interface TwoCollectionViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
{
    UICollectionView *myCollectionView;
    ClassifyDataHandle2 *classifyDataHandle2;
}


@end

@implementation TwoCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.playData1 = [[PlayData1 alloc] init];
    self.playerDicData = [[PlayerDicData alloc] init];
    
    classifyDataHandle2 = [ClassifyDataHandle2 shareClassifyDataHandle2];
    // Do any additional setup after loading the view.
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //item大小;
    //        flowLayout.itemSize = CGSizeMake(110, 160);
    //设置集合视图(上左下右)的间距;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 10, 10);
    //设置区头(不同滚动方向,屏蔽不同的数据)
    flowLayout.headerReferenceSize = CGSizeMake(0, 50);
    myCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    [self.view addSubview:myCollectionView];
    myCollectionView.dataSource = self;
    myCollectionView.delegate = self;
    myCollectionView.backgroundColor = [UIColor whiteColor];
    //注册自定义Cell
    [myCollectionView registerNib:[UINib nibWithNibName:@"CustomCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:customIdntifier];
        //自定义区头;
    [myCollectionView registerNib:[UINib nibWithNibName:@"HeaderCollectionReusableView1" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier1];
    
    //下拉刷新
    [myCollectionView addHeaderWithTarget:self action:@selector(headerRereshing)];
    //自动下拉刷新
    [myCollectionView headerBeginRefreshing];
    //上拉加载
    [myCollectionView addFooterWithTarget:self action:@selector(footerRereshing)];
}


- (void)headerRereshing
{
    //结束下拉刷新
    [myCollectionView headerEndRefreshing];
}
- (void)footerRereshing
{
    //结束上拉加载
    [myCollectionView footerEndRefreshing];
}
#pragma mark - UICollectionViewDataSource
//分区个数:
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return classifyDataHandle2.titleArray2.count;
}
//某个分区的item(cell)的个数;
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return [classifyDataHandle2.cellNumber2[section] count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:customIdntifier forIndexPath:indexPath];
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *arr2 = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary *dic in classifyDataHandle2.cellNumber2[indexPath.section]) {
     [arr addObject: [dic objectForKey:@"name"]];
     [arr2 addObject: [dic objectForKey:@"poster"]];
    }
    cell.detailsLabel.text = arr[indexPath.row];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:arr2[indexPath.row]] placeholderImage:nil];
    return cell;
}
//设置区头
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    //自定义区头
    HeaderCollectionReusableView1 *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerIdentifier1 forIndexPath:indexPath];
    headerView.titleLabel.text = classifyDataHandle2.titleArray2[indexPath.section];
    return headerView;
}


//点击cell
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSMutableArray *arr1 = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary *dic in classifyDataHandle2.cellNumber2[indexPath.section]) {
        [arr1 addObject: [dic objectForKey:@"id"]];
    }
    NSString *midString = arr1[indexPath.row];
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
        __weak TwoCollectionViewController *blockSelf = self;
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


#pragma mark - UICollectionViewDelegateFlowLayout
//设置某个item的大小;
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 120);
}
//某个分区区头大小;
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(self.view.bounds.size.width, 30);
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
