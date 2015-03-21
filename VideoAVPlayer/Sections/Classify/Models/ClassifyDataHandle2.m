//
//  ClassifyDataHandle2.m
//  VideoAVPlayer
//
//  Created by gaoyanlong on 15-3-14.
//  Copyright (c) 2015年 shaowenle. All rights reserved.
//

#import "ClassifyDataHandle2.h"

@implementation ClassifyDataHandle2
+ (ClassifyDataHandle2 *)shareClassifyDataHandle2
{
    static ClassifyDataHandle2 *classifyDataHandle2 = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        classifyDataHandle2 = [[ClassifyDataHandle2 alloc] init];
    });
    return classifyDataHandle2;
}


- (void)setPicArray2:(NSMutableArray *)picArray2
{
    if (_picArray2 != picArray2) {
        _picArray2 = picArray2;
    }
}
- (void)setNameArray2:(NSMutableArray *)nameArray2
{
    if (_nameArray2 != nameArray2) {
        _nameArray2 = nameArray2;
    }
}

- (void)setIDArray2:(NSMutableArray *)IDArray2
{
    if (_IDArray2 != IDArray2) {
        _IDArray2 = IDArray2;
    }
}

-(void)setTitleArray2:(NSMutableArray *)titleArray2
{
    if (_titleArray2 != titleArray2) {
        _titleArray2 = titleArray2;
    }
}
//- (void)setTitleNumber2:(NSMutableArray *)titleNumber2
//{
//    if (_titleNumber2 != titleNumber2) {
//        _titleNumber2 = titleNumber2;
//    }
//}
- (void)setCellNumber2:(NSMutableArray *)cellNumber2
{
    if (_cellNumber2 != cellNumber2) {
        _cellNumber2 = cellNumber2;
    }
}
@end
