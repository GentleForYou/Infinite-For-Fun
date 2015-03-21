//
//  MyTableViewCell.h
//  VideoAVPlayer
//
//  Created by gaoyanlong on 15-3-9.
//  Copyright (c) 2015年 shaowenle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UIImageView *pic;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
