//
//  ClassifyData.h
//  VideoAVPlayer
//
//  Created by gaoyanlong on 15-3-14.
//  Copyright (c) 2015年 shaowenle. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^BlockType1)(NSDictionary *dicData1);
@interface ClassifyData1 : NSObject
@property (nonatomic, copy) BlockType1 blockDicData1;
- (void)sendValue:(BlockType1)aBlock;
- (void)getData1:(NSString *)urlString1 block:(BlockType1)block;
@end
