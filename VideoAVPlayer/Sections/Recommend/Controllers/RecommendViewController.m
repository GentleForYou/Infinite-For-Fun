//
//  RecommendViewController.m
//  VideoAVPlayer
//
//  Created by gaoyanlong on 15-3-7.
//  Copyright (c) 2015年 shaowenle. All rights reserved.
//

#import "RecommendViewController.h"
#import "CustomCollectionViewCell.h"
#import "CustomCollectionViewCell1.h"
#import "HeaderCollectionReusableView.h"
#import "RecommendData.h"
#import "ADRecommend.h"
#import "UIImageView+WebCache.h"
#import "HeaderViewCollectionReusableView.h"
#import "ContentDic.h"
#import "DetailsDic.h"
#import "PlayerViewController.h"
#import "PlayData1.h"
#import "AFNetworking.h"
#import "PlayerDicData.h"
#import "MJRefresh.h"

static NSString *customIdntifier = @"custom";
static NSString *customIdntifier1 = @"custom1";
static NSString *headerIdentifier = @"header";
static NSString *headerViewIdentifier = @"headerView";


@interface RecommendViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,RecommendDataDelegate>
{
    UICollectionView *myCollectionView;
    NSArray *array;
    NSArray *array1;
    NSArray *array2;
    HeaderViewCollectionReusableView *headerView1;
}
@end

@implementation RecommendViewController
- (void)loadView
{
    [super loadView];
    self.adArray = [NSMutableArray arrayWithCapacity:8];
    self.titleNameArray = [NSMutableArray arrayWithCapacity:0];
    self.detailsNameArray = [NSMutableArray arrayWithCapacity:0];
    self.detailsPicArray = [NSMutableArray arrayWithCapacity:0];
    self.adMidArray = [NSMutableArray arrayWithCapacity:0];
//    self.tempArray = [NSArray array];
    //    self.titleArray = [NSMutableArray arrayWithCapacity:0];
    //调用RecommendData,传递数据
    self.recommendData = [[RecommendData alloc] init];
    [_recommendData getData:@"http://po.funshion.com/v7/config/homepage?cl=aphone&ve=2.2.5.4&mac=e8bba829e1e1&uc=6"];
    _recommendData.delegate = self;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //分享按钮
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"pui_sharingbtn@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(shareButton)];
    self.navigationItem.rightBarButtonItem = shareItem;
    
    self.playData1 = [[PlayData1 alloc] init];
    self.playerDicData = [[PlayerDicData alloc] init];

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //item大小;
//    flowLayout.itemSize = CGSizeMake(100, 140);
    //设置集合视图(上左下右)的间距;
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 10, 0, 10);
    //设置区头(不同滚动方向,屏蔽不同的数据)
    flowLayout.headerReferenceSize = CGSizeMake(0, 50);
    myCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    [self.view addSubview:myCollectionView];
    myCollectionView.dataSource = self;
    myCollectionView.delegate = self;
    myCollectionView.backgroundColor = [UIColor whiteColor];
    //注册自定义Cell
    [myCollectionView registerNib:[UINib nibWithNibName:@"CustomCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:customIdntifier];
    [myCollectionView registerNib:[UINib nibWithNibName:@"CustomCollectionViewCell1" bundle:nil] forCellWithReuseIdentifier:customIdntifier1];
    //自定义区头;
     [myCollectionView registerNib:[UINib nibWithNibName:@"HeaderCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier];
    //注册headerView(表头) Nib的view需要继承UICollectionReusableView
    [myCollectionView registerNib:[UINib nibWithNibName:@"HeaderViewCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerViewIdentifier];
    
    
    
    
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
//传递并解析数据
- (void)getDataAndReload
{
    //解析滚动动画数据
    ADRecommend *adrecommend = [[ADRecommend alloc] init];
    array = [_recommendData.dictionary objectForKey:@"focus"];
    for (NSDictionary *dic in array) {
        [adrecommend setValuesForKeysWithDictionary:@{@"aword":[dic objectForKey:@"aword"],@"focus":[dic objectForKey:@"focus"],@"mid":[dic objectForKey:@"mid"],@"update":[dic objectForKey:@"update"]}];
        [self.adArray addObject:adrecommend.focus];
        [self.adMidArray addObject:adrecommend.mid];
    }
    
//    NSLog(@"%@", self.adArray);
    //解析正文内容
    ContentDic *contentDic = [[ContentDic alloc] init];
    DetailsDic *detailsDic = [[DetailsDic alloc] init];
    array1 = [_recommendData.dictionary objectForKey:@"blocks"];
    for (NSDictionary *dic in array1) {
        [contentDic setValue:[dic objectForKey:@"name"] forKey:@"titleName"];
        NSString* strA = [contentDic.titleName stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [self.titleNameArray addObject:strA];
       array2 = [dic objectForKey:@"contents"];
        for (NSDictionary *dic2 in array2) {
      [detailsDic setValuesForKeysWithDictionary:@{@"mid":[dic2 objectForKey:@"mid"],@"name":[dic2 objectForKey:@"name"],@"still":[dic2 objectForKey:@"still"]}];
            [self.detailsNameArray addObject:detailsDic.name];
            [self.detailsPicArray addObject:detailsDic.still];
        }
    }
//    NSLog(@"%@ %@",_detailsPicArray, _detailsNameArray[0]);
//    NSLog(@"%@",self.titleNameArray);
    [myCollectionView reloadData];
}

#pragma mark - UICollectionViewDataSource
//分区个数:
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [array1 count];
}
//某个分区的item(cell)的个数;
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([[array1[section] objectForKey:@"contents"] count] % 2 == 0) {
        return [[array1[section] objectForKey:@"contents"] count];
    } else {
    return [[array1[section] objectForKey:@"contents"] count] - 1;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
     if (indexPath.section == 1 || indexPath.section == 4 || indexPath.section == 5) {
        CustomCollectionViewCell1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:customIdntifier1 forIndexPath:indexPath];
         cell.detailsLabel1.text = [[array1[indexPath.section] objectForKey:@"contents"][indexPath.row] objectForKey:@"name"];
         [cell.imageView1 sd_setImageWithURL:[NSURL URLWithString:[[array1[indexPath.section] objectForKey:@"contents"][indexPath.row] objectForKey:@"still"]] placeholderImage:nil];
        return cell;
    } else {
        CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:customIdntifier forIndexPath:indexPath];
        cell.detailsLabel.text = [[array1[indexPath.section] objectForKey:@"contents"][indexPath.row] objectForKey:@"name"];
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:[[array1[indexPath.section] objectForKey:@"contents"][indexPath.row] objectForKey:@"still"]] placeholderImage:nil];

        return cell;
    }
}

//设置区头
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
        //自定义区头
        HeaderCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerIdentifier forIndexPath:indexPath];
    if (indexPath.section == 0) {
        //自定义区头
        headerView1 = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerViewIdentifier forIndexPath:indexPath];
        for (int i = 0; i < [self.adArray count]; i++) {
            UIImageView *imageTemp = (UIImageView *)[headerView1 viewWithTag:(200 + i)];
           [imageTemp sd_setImageWithURL:[NSURL URLWithString:self.adArray[i]] placeholderImage:nil];
            [headerView1.images addObject:imageTemp];
        }
         UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [headerView1 addGestureRecognizer:tap];
        return headerView1;
    }
    headerView.headerLabel.text = self.titleNameArray[indexPath.section];
    headerView.headerMoreButton.hidden = YES;
        return headerView;
}

- (void)tap
{
    NSString *midString = self.adMidArray[headerView1.page.currentPage];
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
        //arrID.count是集数,从0开始,IDstring是第一季的ID,每个+1
        NSString *IDString = [arrID[0] objectForKey:@"id"];
        //播放网址
        NSString *str = [NSString stringWithFormat:@"http://pm.funshion.com/v5/media/play?id=%@&cl=aphone&ve=2.2.5.4&mac=087a4ca86a0a&uc=6",IDString];
        NSLog(@"%@",str);
        __weak RecommendViewController *blockSelf = self;
        
        [blockSelf.playData1 getData1:str block:^(NSString *string5) {
            PlayerViewController *playerVC = [[PlayerViewController alloc] init];
            playerVC.string9 = string5;
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
     if (indexPath.section == 1 || indexPath.section == 4 || indexPath.section == 5) {
        return CGSizeMake(100, 120);
    } else {
        return CGSizeMake(170, 120);
    }
}
//某个分区区头大小;
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(self.view.bounds.size.width, 150);
    }
    return CGSizeMake(self.view.bounds.size.width, 30);
}

//点击cell
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *midString = [[array1[indexPath.section] objectForKey:@"contents"][indexPath.row] objectForKey:@"mid"];
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
        __weak RecommendViewController *blockSelf = self;
        [blockSelf.playData1 getData1:str block:^(NSString *string5) {
            PlayerViewController *playerVC = [[PlayerViewController alloc] init];
            playerVC.string9 = string5;
            [playerVC.playURLArray addObject:string5];
            //简介网址
            NSString *str2 = [NSString stringWithFormat:@"http://pm.funshion.com/v5/media/profile?id=%@&cl=aphone&ve=2.2.5.4&mac=087a4ca86a0a&uc=6",[[array1[indexPath.section] objectForKey:@"contents"][indexPath.row] objectForKey:@"mid"]];
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
