//
//  RecommendData.h
//  VideoAVPlayer
//
//  Created by gaoyanlong on 15-3-9.
//  Copyright (c) 2015年 shaowenle. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RecommendDataDelegate <NSObject>

- (void)getDataAndReload;

@end

@interface RecommendData : NSObject
@property (nonatomic, retain) NSDictionary *dictionary;

@property (nonatomic, assign) id<RecommendDataDelegate> delegate;
//+ (RecommendData *)shareDataHandle;
//@property (nonatomic, strong) NSString *urlString;
- (void)getData:(NSString *)urlString;
@end
