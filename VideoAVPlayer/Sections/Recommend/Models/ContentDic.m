//
//  ContentDic.m
//  VideoAVPlayer
//
//  Created by gaoyanlong on 15-3-10.
//  Copyright (c) 2015年 shaowenle. All rights reserved.
//

#import "ContentDic.h"

@implementation ContentDic
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    [super setValue:value forKey:key];
}
- (NSString *)description
{
    return [NSString stringWithFormat:@"%@  ", self.titleName];
}
@end
