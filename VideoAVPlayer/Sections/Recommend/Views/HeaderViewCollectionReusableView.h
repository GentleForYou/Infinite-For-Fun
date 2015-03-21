//
//  HeaderViewCollectionReusableView.h
//  VideoAVPlayer
//
//  Created by gaoyanlong on 15-3-10.
//  Copyright (c) 2015年 shaowenle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderViewCollectionReusableView : UICollectionReusableView
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) UIPageControl *page;
@property (nonatomic, strong) UIImageView *imageView;
@end
