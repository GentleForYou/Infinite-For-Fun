//
//  playData1.h
//  VideoAVPlayer
//
//  Created by gaoyanlong on 15-3-12.
//  Copyright (c) 2015年 shaowenle. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^BlockType)(NSString *string5);
@interface PlayData1 : NSObject
@property (nonatomic, copy) BlockType blockURL;
- (void)getData:(NSString *)urlString block:(BlockType)block;
- (void)sendValue:(BlockType)aBlock;

- (void)getData1:(NSString *)urlString block:(BlockType)block;

@end
