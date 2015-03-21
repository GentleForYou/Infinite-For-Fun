//
//  DownloadViewController.h
//  VideoAVPlayer
//
//  Created by gaoyanlong on 15-3-6.
//  Copyright (c) 2015年 shaowenle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownloadViewController : UIViewController
+ (DownloadViewController *)shareDownloadViewController;
@property (nonatomic, strong) NSURL *URLString;
@property (nonatomic, strong) NSString *nameString;
@end
