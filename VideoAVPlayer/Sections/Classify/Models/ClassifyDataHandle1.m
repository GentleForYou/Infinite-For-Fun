//
//  ClassifyDataHandle.m
//  VideoAVPlayer
//
//  Created by gaoyanlong on 15-3-14.
//  Copyright (c) 2015年 shaowenle. All rights reserved.
//

#import "ClassifyDataHandle1.h"

@implementation ClassifyDataHandle1
+ (ClassifyDataHandle1 *)shareClassifyDataHandle1
{
    static ClassifyDataHandle1 *classifyDataHandle1 = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        classifyDataHandle1 = [[ClassifyDataHandle1 alloc] init];
    });
    return classifyDataHandle1;
}

- (void)setPicArray1:(NSMutableArray *)picArray1
{
    if (_picArray1 != picArray1) {
        _picArray1 = picArray1;
    }
}
- (void)setNameArray1:(NSMutableArray *)nameArray1
{
    if (_nameArray1 != nameArray1) {
        _nameArray1 = nameArray1;
    }
}

- (void)setIDArray1:(NSMutableArray *)IDArray1
{
    if (_IDArray1 != IDArray1) {
        _IDArray1 = IDArray1;
    }
}

@end
