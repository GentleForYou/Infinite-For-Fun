//
//  HeaderViewCollectionReusableView.m
//  VideoAVPlayer
//
//  Created by gaoyanlong on 15-3-10.
//  Copyright (c) 2015年 shaowenle. All rights reserved.
//

#import "HeaderViewCollectionReusableView.h"
@interface HeaderViewCollectionReusableView ()<UIScrollViewDelegate>


@end

@implementation HeaderViewCollectionReusableView
- (void)awakeFromNib {
    // Initialization code
    
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(change) userInfo:nil repeats:YES];
    
    self.images = [NSMutableArray arrayWithCapacity:8];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    [_scrollView setContentSize:CGSizeMake(self.bounds.size.width * 8, self.bounds.size.height)];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.pagingEnabled = YES;
    [self addSubview:_scrollView];
    _scrollView.delegate = self;//控制点移动
    
    
    NSArray *array = @[@"123", @"123", @"home_topbar_icon_download@2x", @"home_topbar_icon_download@2x", @"home_topbar_icon_download@2x", @"home_topbar_icon_download@2x", @"123", @"123"];
    for (int i = 0; i < 8; i++) {
        self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:array[i]]];
        _imageView.frame = CGRectMake(self.bounds.size.width * i, 0, self.bounds.size.width, self.bounds.size.height);
        _imageView.tag = 200 + i;
        [_images addObject:_imageView];
        [_scrollView addSubview:_images[i]];
}
    
    self.page = [[UIPageControl alloc] initWithFrame:CGRectMake(self.bounds.size.width - 120, self.bounds.size.height - 20, 120, 20)];
    _page.numberOfPages = 8;
    [self addSubview:_page];

}
- (void)change
{
    _page.currentPage++;
    if (_page.currentPage == 8) {
        _page.currentPage = 0;
    }
     _scrollView.contentOffset = CGPointMake(self.bounds.size.width * _page.currentPage, 0);
    
}
//控制点进行移动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView1
{
    if (_page.currentPage == 7) {
        _page.currentPage = 0;
        scrollView1.contentOffset = CGPointMake(0, 0);
    }
    _page.currentPage = scrollView1.contentOffset.x / self.bounds.size.width;
}

@end
