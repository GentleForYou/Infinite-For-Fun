//
//  ClassifyData3.m
//  VideoAVPlayer
//
//  Created by gaoyanlong on 15-3-14.
//  Copyright (c) 2015年 shaowenle. All rights reserved.
//

#import "ClassifyData3.h"
#import "AFNetworking.h"

@implementation ClassifyData3
- (void)sendValue:(BlockType3)aBlock
{
    _blockDicData3 = aBlock;
}


- (void)getData3:(NSString *)urlString3 block:(BlockType3)block
{
    //创建网络请求
    NSURL* URL = [NSURL URLWithString:urlString3];
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
        //               NSLog(@"%@", responseObject);
        block(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //请求失败,打印错误
        NSLog(@"Error: %@", error.localizedDescription);
    }];
    //开始请求
    [operation start];
}

@end
