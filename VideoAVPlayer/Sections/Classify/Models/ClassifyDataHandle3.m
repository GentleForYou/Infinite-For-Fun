//
//  ClassifyDataHandle3.m
//  VideoAVPlayer
//
//  Created by gaoyanlong on 15-3-14.
//  Copyright (c) 2015年 shaowenle. All rights reserved.
//

#import "ClassifyDataHandle3.h"

@implementation ClassifyDataHandle3
+ (ClassifyDataHandle3 *)shareClassifyDataHandle3
{
    static ClassifyDataHandle3 *classifyDataHandle3 = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        classifyDataHandle3 = [[ClassifyDataHandle3 alloc] init];
    });
    return classifyDataHandle3;
}

- (void)setPicArray3:(NSMutableArray *)picArray3
{
    if (_picArray3 != picArray3) {
        _picArray3 = picArray3;
    }
}
- (void)setNameArray3:(NSMutableArray *)nameArray3
{
    if (_nameArray3 != nameArray3) {
        _nameArray3 = nameArray3;
    }
}

- (void)setIDArray3:(NSMutableArray *)IDArray3
{
    if (_IDArray3 != IDArray3) {
        _IDArray3 = IDArray3;
    }
}
-(void)setAreaArray3:(NSMutableArray *)areaArray3
{
    if (_areaArray3 != areaArray3) {
        _areaArray3 = areaArray3;
    }
}

-(void)setTypeArray3:(NSMutableArray *)typeArray3
{
    if (_typeArray3 != typeArray3) {
        _typeArray3 = typeArray3;
    }
}
@end
