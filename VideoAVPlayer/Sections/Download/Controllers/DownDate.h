//
//  DownDate.h
//  VideoAVPlayer
//
//  Created by gaoyanlong on 15-3-16.
//  Copyright (c) 2015年 shaowenle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownDate : NSObject
+ (DownDate *)shareDownDate;
@property (nonatomic, strong) NSString *nameString;
@property (nonatomic, strong) NSURL *file;
@property (nonatomic, strong) NSString *urlString;
@property (nonatomic, strong) NSMutableArray *nameArray;
@property (nonatomic, strong) NSMutableArray *urlArray;
@end
