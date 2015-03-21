//
//  HeaderCollectionReusableView.h
//  VideoAVPlayer
//
//  Created by gaoyanlong on 15-3-7.
//  Copyright (c) 2015年 shaowenle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderCollectionReusableView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UIButton *headerMoreButton;

@end
