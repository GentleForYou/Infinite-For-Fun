//
//  RecommendData.m
//  VideoAVPlayer
//
//  Created by gaoyanlong on 15-3-9.
//  Copyright (c) 2015年 shaowenle. All rights reserved.
//

#import "RecommendData.h"
#import "AFNetworking.h"
#import "RecommendViewController.h"

@implementation RecommendData
//+ (RecommendData *)shareDataHandle
//{
//    static RecommendData *recommendData = nil;
//
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        recommendData = [[RecommendData alloc] init];
//    });
//    [recommendData getData];
//    return recommendData;
//}
- (void)getData:(NSString *)urlString
{
    //创建网络请求
    NSURL* URL = [NSURL URLWithString:@"http://po.funshion.com/v7/config/homepage?cl=aphone&ve=2.2.5.4&mac=e8bba829e1e1&uc=6"];
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
        self.dictionary = responseObject;
        [self.delegate getDataAndReload];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //请求失败,打印错误
        NSLog(@"Error: %@", error.localizedDescription);
    }];
    //开始请求
    [operation start];
    
}

@end
