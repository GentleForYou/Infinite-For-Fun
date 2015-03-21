//
//  DownCell.h
//  VideoAVPlayer
//
//  Created by gaoyanlong on 15-3-16.
//  Copyright (c) 2015年 shaowenle. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface DownCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *downButton;
@property (weak, nonatomic) IBOutlet UIProgressView *downProgressView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) NSURL *URL;
- (IBAction)down:(UIButton *)sender ;
@end
