//
//  ClassifyDataHandle2.h
//  VideoAVPlayer
//
//  Created by gaoyanlong on 15-3-14.
//  Copyright (c) 2015年 shaowenle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassifyDataHandle2 : NSObject
+ (ClassifyDataHandle2 *)shareClassifyDataHandle2;
@property (nonatomic, strong) NSMutableArray *picArray2;
@property (nonatomic, strong) NSMutableArray *nameArray2;
@property (nonatomic, strong) NSMutableArray *IDArray2;
@property (nonatomic, strong) NSMutableArray *titleArray2;
//@property (nonatomic, strong) NSMutableArray *titleNumber2;
@property (nonatomic, strong) NSMutableArray *cellNumber2;
@end
