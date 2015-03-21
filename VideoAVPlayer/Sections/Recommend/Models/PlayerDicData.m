//
//  PlayerDicData.m
//  VideoAVPlayer
//
//  Created by gaoyanlong on 15-3-13.
//  Copyright (c) 2015年 shaowenle. All rights reserved.
//

#import "PlayerDicData.h"
#import "AFNetworking.h"

@implementation PlayerDicData
- (void)sendValue:(BlockType2)aBlock
{
    _blockDicData = aBlock;
}


- (void)getData2:(NSString *)urlString block:(BlockType2)block
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
