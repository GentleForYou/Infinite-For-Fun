//
//  ADRecommend.h
//  VideoAVPlayer
//
//  Created by gaoyanlong on 15-3-9.
//  Copyright (c) 2015年 shaowenle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADRecommend : NSObject
@property (strong, nonatomic) NSString *aword;
@property (strong, nonatomic) NSString *mid;
@property (strong, nonatomic) NSString *focus;
@property (strong, nonatomic) NSString *update;
@property (strong, nonatomic) NSMutableArray *adArray;
@end
