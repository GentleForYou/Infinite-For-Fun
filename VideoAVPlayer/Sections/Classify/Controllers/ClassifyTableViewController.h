//
//  ClassifyTableViewController.h
//  VideoAVPlayer
//
//  Created by gaoyanlong on 15-3-6.
//  Copyright (c) 2015年 shaowenle. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ClassifyData1;
@class ClassifyData2;
@class ClassifyData3;

@interface ClassifyTableViewController : UITableViewController
@property (nonatomic, strong) NSArray *arrayTitle;
@property (nonatomic, strong) ClassifyData1 *classifyData1;
@property (nonatomic, strong) ClassifyData2 *classifyData2;
@property (nonatomic, strong) ClassifyData3 *classifyData3;
@end
