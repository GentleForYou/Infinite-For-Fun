//
//  ClassifyData2.h
//  VideoAVPlayer
//
//  Created by gaoyanlong on 15-3-14.
//  Copyright (c) 2015年 shaowenle. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^BlockType2)(NSDictionary *dicData2);
@interface ClassifyData2 : NSObject

@property (nonatomic, copy) BlockType2 blockDicData2;
- (void)sendValue:(BlockType2)aBlock;
- (void)getData2:(NSString *)urlString2 block:(BlockType2)block;
@end
