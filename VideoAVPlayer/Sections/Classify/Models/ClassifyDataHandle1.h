//
//  ClassifyDataHandle.h
//  VideoAVPlayer
//
//  Created by gaoyanlong on 15-3-14.
//  Copyright (c) 2015年 shaowenle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassifyDataHandle1 : NSObject
+ (ClassifyDataHandle1 *)shareClassifyDataHandle1;
@property (nonatomic, strong) NSMutableArray *picArray1;
@property (nonatomic, strong) NSMutableArray *nameArray1;
@property (nonatomic, strong) NSMutableArray *IDArray1;
@end
