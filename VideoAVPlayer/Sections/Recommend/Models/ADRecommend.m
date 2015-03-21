//
//  ADRecommend.m
//  VideoAVPlayer
//
//  Created by gaoyanlong on 15-3-9.
//  Copyright (c) 2015年 shaowenle. All rights reserved.
//

#import "ADRecommend.h"

@implementation ADRecommend
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    [super setValue:value forKey:key];
}
- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ %@ ", self.focus, self.aword];
}
@end
