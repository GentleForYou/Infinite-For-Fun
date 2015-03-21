//
//  playData1.m
//  VideoAVPlayer
//
//  Created by gaoyanlong on 15-3-12.
//  Copyright (c) 2015年 shaowenle. All rights reserved.
//

#import "PlayData1.h"
#import "AFNetworking.h"
@implementation PlayData1
- (void)getData:(NSString *)urlString block:(BlockType)block
{
    //创建网络请求
    NSURL* URL = [NSURL URLWithString:urlString];
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
//       NSLog(@"%@", responseObject);
//        self.dictionary = responseObject;
        [self getData1:responseObject block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //请求失败,打印错误
        NSLog(@"Error: %@", error.localizedDescription);
    }];
    //开始请求
    [operation start];
    
}

- (void)getplayData1:(NSDictionary *)dicData1 block:(BlockType)block
{
    NSArray *tempArray = [dicData1 objectForKey:@"mp4"];
    NSString *string1 = [tempArray[1] objectForKey:@"http"];
    //创建网络请求
    NSURL* URL = [NSURL URLWithString:string1];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:URL];
    request.HTTPMethod = @"GET";
    request.timeoutInterval = 30;
    
    //创建AFNetworking的请求操作
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    //设置AFNetworking返回的数据 自动进行json解析
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    //设置内容类型
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    //完成请求进入blocks
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //请求成功,打印返回数据
        NSArray *tempArr = [responseObject objectForKey:@"playlist"];
        NSMutableArray *arr = [tempArr[0] objectForKey:@"urls"];
        NSString *str3 = arr[0];
//        NSLog(@"%@", self.urlArray);
        block(str3);
//        self.blockURL(self.urlArray);
//        [myCollectionView reloadData];//刷新数据
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //请求失败,打印错误
        NSLog(@"Error: %@", error.localizedDescription);
    }];
    //开始请求
    [operation start];
    
}

- (void)sendValue:(BlockType)aBlock
{
     _blockURL = aBlock;
}

- (void)getData1:(NSString *)urlString block:(BlockType)block {
    //创建网络请求
    NSURL* URL = [NSURL URLWithString:urlString];
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
//        NSLog(@"%@",responseObject);
//        block(responseObject);
        [self getplayData1:responseObject block:block];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //请求失败,打印错误
        NSLog(@"Error: %@", error.localizedDescription);
    }];
    //开始请求
    [operation start];
}
@end
