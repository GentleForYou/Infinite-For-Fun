//
//  DownDate.m
//  VideoAVPlayer
//
//  Created by gaoyanlong on 15-3-16.
//  Copyright (c) 2015年 shaowenle. All rights reserved.
//

#import "DownDate.h"

@implementation DownDate
+ (DownDate *)shareDownDate
{
    static DownDate *downDate = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        downDate = [[DownDate alloc] init];
    });
    return downDate;
}
-(void)setNameString:(NSString *)nameString
{
    if (_nameString != nameString) {
        _nameString = nameString;
    }
}
- (void)setFile:(NSURL *)file
{
    if (_file != file) {
        _file = file;
    }
}
- (void)setUrlString:(NSString *)urlString
{
    if (_urlString != urlString) {
        _urlString = urlString;
    }
}

@end
