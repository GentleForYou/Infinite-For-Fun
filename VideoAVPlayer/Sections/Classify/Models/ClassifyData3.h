//
//  ClassifyData3.h
//  VideoAVPlayer
//
//  Created by gaoyanlong on 15-3-14.
//  Copyright (c) 2015年 shaowenle. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^BlockType3)(NSDictionary *dicData3);
@interface ClassifyData3 : NSObject

@property (nonatomic, copy) BlockType3 blockDicData3;
- (void)sendValue:(BlockType3)aBlock;
- (void)getData3:(NSString *)urlString3 block:(BlockType3)block;
@end
