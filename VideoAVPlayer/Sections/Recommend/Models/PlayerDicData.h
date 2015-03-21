//
//  PlayerDicData.h
//  VideoAVPlayer
//
//  Created by gaoyanlong on 15-3-13.
//  Copyright (c) 2015年 shaowenle. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^BlockType2)(NSDictionary *dicData);

@interface PlayerDicData : NSObject
@property (nonatomic, copy) BlockType2 blockDicData;
- (void)sendValue:(BlockType2)aBlock;
//- (void)getData2:(NSString *)urlString;
- (void)getData2:(NSString *)urlString block:(BlockType2)block;
@end
