//
//  ClassifyDataHandle3.h
//  VideoAVPlayer
//
//  Created by gaoyanlong on 15-3-14.
//  Copyright (c) 2015年 shaowenle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassifyDataHandle3 : NSObject
+ (ClassifyDataHandle3 *)shareClassifyDataHandle3;
@property (nonatomic, strong) NSMutableArray *picArray3;
@property (nonatomic, strong) NSMutableArray *nameArray3;
@property (nonatomic, strong) NSMutableArray *IDArray3;
@property (nonatomic, strong) NSMutableArray *areaArray3;
@property (nonatomic, strong) NSMutableArray *typeArray3;
@end
