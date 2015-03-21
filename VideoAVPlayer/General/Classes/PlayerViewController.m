//
//  PlayerViewController.m
//  VideoAVPlayer
//
//  Created by gaoyanlong on 15-3-11.
//  Copyright (c) 2015年 shaowenle. All rights reserved.
//

#import "PlayerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "PlayerCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "DownDate.h"
#import "DownCell.h"
#import "DownloadViewController.h"

static NSString *playerIdntifier = @"player";

@interface PlayerViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>
{
    BOOL falg;
    BOOL falg1;
    AVPlayerLayer *playerLayer;
    NSString *URLString;
    UIImageView *media_starImageView;
    NSString *filePath;
    NSURL *url;
    NSString *urlStr;
    DownDate *downData;
}
@property (nonatomic,strong) AVPlayer *player;//播放器对象
@property (weak, nonatomic) IBOutlet UIView *container; //播放器容器
@property (weak, nonatomic) IBOutlet UIButton *playOrPause; //播放/暂停按钮
@property (weak, nonatomic) IBOutlet UIButton *nextButton;//下一集按钮
@property (strong, nonatomic) IBOutlet UISlider *slider;//滑块调整播放进度
@property (weak, nonatomic) IBOutlet UIButton *fullButton;//全屏按钮

@property (weak, nonatomic) IBOutlet UIButton *introButton;//简介按钮
@property (weak, nonatomic) IBOutlet UIButton *chooseButton;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;
@end

@implementation PlayerViewController

#pragma mark - 控制器视图方法


- (void)viewDidLoad {
    [super viewDidLoad];
    
    downData = [DownDate shareDownDate];
    

    //下载按钮
    UIBarButtonItem *downItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"bar_download_select@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(downButton)];
    self.navigationItem.rightBarButtonItem = downItem;
    
    self.container.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.width);
    
    
    
    falg = YES;
    falg1 = YES;
    
   
    
    //简介,选集的颜色
    [_introButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_chooseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.playOrPause setImage:[UIImage imageNamed:@"pui_pausebtn_b_disable@2x"] forState:UIControlStateNormal];
    [self setupUI];
    [self.player play];
    
    [self.container bringSubviewToFront:_playOrPause];
    [self.container bringSubviewToFront:_nextButton];
    [self.container bringSubviewToFront:_leftLabel];
    [self.container bringSubviewToFront:_slider];
    [self.container bringSubviewToFront:_rightLabel];
    [self.container bringSubviewToFront:_fullButton];
    
    //滚动视图
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 469, self.view.bounds.size.width, self.view.bounds.size.height - 469)];
    _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height - 469);
    _scrollView.tag = 200;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    //简介页面
    UIView *introView = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,self.view.bounds.size.height - 469)];
    [_scrollView addSubview:introView];
    //简介的内容
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 30)];
    titleLabel.text = self.string1;
    titleLabel.font = [UIFont systemFontOfSize:15];
    [introView addSubview:titleLabel];
    
    UIImageView *movieImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 45, 80, 120)];
    [movieImageView sd_setImageWithURL:[NSURL URLWithString:self.string2] placeholderImage:nil];
    [introView addSubview:movieImageView];
    
    UILabel *storyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 170, 100, 25)];
    storyLabel.text = @"剧情简介";
    [introView addSubview:storyLabel];

    
    media_starImageView = [[UIImageView alloc] initWithFrame:CGRectMake(110, 15, 20, 20)];
    media_starImageView.image = [UIImage imageNamed:@"media_star@2x"];
    [introView addSubview:media_starImageView];
    
    
    
    
    if (self.falg2) {
        [self fullOrExit:_fullButton];
        media_starImageView.hidden = YES;
    }
    
    
    
    UILabel *gradeLabel = [[UILabel alloc] initWithFrame:CGRectMake(135, 5, 100, 40)];
    gradeLabel.text = self.string3;
    gradeLabel.font = [UIFont systemFontOfSize:20];
    gradeLabel.textColor = [UIColor orangeColor];
    [introView addSubview:gradeLabel];
    //导演
    UILabel *directLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 40, self.view.bounds.size.width - 100, 20)];
    directLabel.text = self.string4;
    [introView addSubview:directLabel];
    //演员
    UILabel *actorLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 60, self.view.bounds.size.width - 100, 20)];
    actorLabel.text = self.string5;
    [introView addSubview:actorLabel];
    //题材
    UILabel *themeLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 80, self.view.bounds.size.width - 100, 20)];
    themeLabel.text = self.string6;
    [introView addSubview:themeLabel];
    //首映
    UILabel *firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, self.view.bounds.size.width - 100, 20)];
    firstLabel.text = self.string7;
    [introView addSubview:firstLabel];
    //详情
    UITextView *detailsTextView = [[UITextView alloc] initWithFrame:CGRectMake(100, 120, self.view.bounds.size.width - 100, 78)];
    detailsTextView.text = self.string8;
    detailsTextView.editable = NO;
    [introView addSubview:detailsTextView];
    
    
    
//    //选集页面
//    UIView *chooseView = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width,0,self.view.bounds.size.width,self.view.bounds.size.height - 469)];
//    chooseView.backgroundColor = [UIColor redColor];
//    [_scrollView addSubview:chooseView];
//    //选集的按钮
//    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    //滚动方向;(默认垂直排列)
//    //    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    //设置最小行间距(默认10.0)
//    flowLayout.minimumLineSpacing = 10;
//    //设置最小列间距(默认10.0)
//    flowLayout.minimumInteritemSpacing = 10;
//    //item大小;
//    flowLayout.itemSize = CGSizeMake(40, 40);
//    //设置集合视图(上左下右)的间距;
//        flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
//
//    UICollectionView *playerCollectionView = [[UICollectionView alloc] initWithFrame:chooseView.bounds collectionViewLayout:flowLayout];
//    [chooseView addSubview:playerCollectionView];
//    playerCollectionView.dataSource = self;
//    playerCollectionView.delegate = self;
//    playerCollectionView.backgroundColor = [UIColor redColor];
//    
//    //注册
//    [playerCollectionView registerNib:[UINib nibWithNibName:@"PlayerCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:playerIdntifier];
    
}
#pragma mark - UICollectionViewDataSource
//某个分区的item(cell)的个数;
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
//{
//    return 20;
//}
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//        PlayerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:playerIdntifier forIndexPath:indexPath];
//        cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row + 1];
//        return cell;
//}
-(void)dealloc{
    [self removeObserverFromPlayerItem:self.player.currentItem];
    [self removeNotification];
}

//回调设备旋转方法
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    //对视图进行旋转处理
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        playerLayer.frame = self.container.bounds;
    }
    else {
        playerLayer.frame = self.container.bounds;
        playerLayer.videoGravity = AVLayerVideoGravityResize;//视频填充模式
    }
}

#pragma mark - 私有方法
-(void)setupUI{
    //创建播放器层
    playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    playerLayer.frame = self.container.bounds;
    playerLayer.videoGravity = AVLayerVideoGravityResize;//视频填充模式
    [self.container.layer addSublayer:playerLayer];
}

/**
 *  截取指定时间的视频缩略图
 *
 *  @param timeBySecond 时间点
 */

/**
 *  初始化播放器
 *
 *  @return 播放器对象
 */
-(AVPlayer *)player{
    if (!_player) {
        AVPlayerItem *playerItem=[self getPlayItem:0];
        _player=[AVPlayer playerWithPlayerItem:playerItem];
        [self addProgressObserver];
        [self addObserverToPlayerItem:playerItem];
    }
    return _player;
}

/**
 *  根据视频索引取得AVPlayerItem对象
 *
 *  @param videoIndex 视频顺序索引
 *
 *  @return AVPlayerItem对象
 */
-(AVPlayerItem *)getPlayItem:(int)videoIndex{
    
//
    //@"http://58.244.255.12/play/82846AEB3B80981E4A674374C05B3F771144D3AF/1074654_smooth.mp4"
    if (self.falg2) {
        //本地播放
        if (downData.file) {
            url = downData.file;
        } else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"亲" message:@"还没有本地视频哦" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
        }
    } else {
    //在线播放
    if (self.string9 != nil) {
        URLString  = self.string9;
    } else {
        URLString = @"http://123.134.67.201:80/play/BEDF14F6FF4FF604DCCB053EEE20536EB33EFC37.mp4";
    }
        urlStr=[NSString stringWithFormat:URLString];
        //    urlStr =[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        url=[NSURL URLWithString:urlStr];
    }
        AVPlayerItem *playerItem=[AVPlayerItem playerItemWithURL:url];
        return playerItem;
}
#pragma mark - 通知
/**
 *  添加播放器通知
 */
-(void)addNotification{
    //给AVPlayerItem添加播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
}

-(void)removeNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 *  播放完成通知
 *
 *  @param notification 通知对象
 */
-(void)playbackFinished:(NSNotification *)notification{
    NSLog(@"视频播放完成.");
}



#pragma mark - 监控
/**
 *  给播放器添加进度更新
 */
-(void)addProgressObserver{
    AVPlayerItem *playerItem = self.player.currentItem;
    UISlider *slider = self.slider;
    [slider addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventValueChanged];
    __weak PlayerViewController *blockSelf = self;
    //这里设置每秒执行一次
    [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        float current=CMTimeGetSeconds(time);
        float total=CMTimeGetSeconds([playerItem duration]);
        [blockSelf leftLabel:[blockSelf convertTime:current]];
        NSLog(@"当前播放时长%@", [blockSelf convertTime:current]);
        if (current) {
            [slider setValue:(current/total) animated:YES];
        }
    }];
}
- (void)changeValue:(UISlider *)aSlider
{
    AVPlayerItem *playerItem = self.player.currentItem;
    //从当前位置播放
    [self.player seekToTime:CMTimeMakeWithSeconds(aSlider.value * CMTimeGetSeconds([playerItem duration]), 1)];
}

- (NSString *)convertTime:(CGFloat)second{
        NSDate *d = [NSDate dateWithTimeIntervalSince1970:second];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        if (second/3600 >= 1) {
            [formatter setDateFormat:@"01:mm:ss"];
            } else {
                [formatter setDateFormat:@"mm:ss"];
                }
        NSString *showtimeNew = [formatter stringFromDate:d];
        return showtimeNew;
}

/**
 *  给AVPlayerItem添加监控
 *
 *  @param playerItem AVPlayerItem对象
 */
-(void)addObserverToPlayerItem:(AVPlayerItem *)playerItem{
    //监控状态属性，注意AVPlayer也有一个status属性，通过监控它的status也可以获得播放状态
    [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    //监控网络加载情况属性
    [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
}
-(void)removeObserverFromPlayerItem:(AVPlayerItem *)playerItem{
    [playerItem removeObserver:self forKeyPath:@"status"];
    [playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
}
/**
 *  通过KVO监控播放器状态
 *
 *  @param keyPath 监控属性
 *  @param object  监视器
 *  @param change  状态改变
 *  @param context 上下文
 */
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    AVPlayerItem *playerItem=object;
    __weak PlayerViewController *blockSelf = self;
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerStatus status= [[change objectForKey:@"new"] intValue];
        if(status==AVPlayerStatusReadyToPlay){
            [blockSelf rightLabel:[blockSelf convertTime:CMTimeGetSeconds(playerItem.duration)]];
            NSLog(@"视频总时长%@", [blockSelf convertTime:CMTimeGetSeconds(playerItem.duration)]);
        }
    }else if([keyPath isEqualToString:@"loadedTimeRanges"]){
        NSArray *array=playerItem.loadedTimeRanges;
        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];//本次缓冲时间范围
        float startSeconds = CMTimeGetSeconds(timeRange.start);
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        NSTimeInterval totalBuffer = startSeconds + durationSeconds;//缓冲总长度
        NSLog(@"视频共缓冲时长%@", [blockSelf convertTime:totalBuffer]);
    }
}


- (void)leftLabel:(NSString *)leftLabelText
{
    _leftLabel.text = leftLabelText;
}

- (void)rightLabel:(NSString *)rightLabelText
{
    _rightLabel.text = rightLabelText;
}
//隐藏tabar
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed=YES;
    }
    return self;
}
#pragma mark - UI事件
/**
 *  点击播放/暂停按钮
 *
 *  @param sender 播放/暂停按钮
 */
- (IBAction)playClick:(UIButton *)sender {
    //    AVPlayerItemDidPlayToEndTimeNotification
    //AVPlayerItem *playerItem= self.player.currentItem;
    //pui_playbtn_b_disable@2x
    if(self.player.rate==0){ //说明时暂停
        [sender setImage:[UIImage imageNamed:@"pui_pausebtn_b_disable@2x"] forState:UIControlStateNormal];
        [self.player play];
    }else if(self.player.rate==1){//正在播放
        [self.player pause];
        [sender setImage:[UIImage imageNamed:@"pui_playbtn_b_disable@2x"] forState:UIControlStateNormal];
    }
}
//简介button
- (IBAction)introButton:(UIButton *)sender {
    [_introButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_chooseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _scrollView.contentOffset = CGPointMake(0, 0);
}
//选集button
- (IBAction)chooseButton:(UIButton *)sender {
    _scrollView.contentOffset = CGPointMake(self.view.bounds.size.width, 0);
    [_chooseButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_introButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}
- (BOOL)shouldAutorotate{
    return NO;
}
//结束减速
- (void)scrollViewDidEndDecelerating:(UIScrollView *)aScrollView
{
    if(aScrollView.contentOffset.x < self.view.bounds.size.width) {
        [_introButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_chooseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    } else {
        [_chooseButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_introButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

//全屏或退出Button
- (IBAction)fullOrExit:(UIButton *)sender {
    if (falg) {
        [sender setImage:[UIImage imageNamed:@"pui_zoomoutbtn@2x"] forState:UIControlStateNormal];
        falg = !falg;
        
        
        self.container.frame = CGRectMake(0, 0, self.view.bounds.size.height, self.view.bounds.size.width);
        playerLayer.frame = self.container.bounds;
        [self.view bringSubviewToFront:self.container];
//        playerLayer.videoGravity = AVLayerVideoGravityResize;//视频填充模式
        //旋转屏幕，但是只旋转当前的View
        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
        self.view.transform = CGAffineTransformMakeRotation(M_PI/2);
        CGRect frame = [UIScreen mainScreen].applicationFrame;
        self.view.bounds = CGRectMake(0, 64, frame.size.height, frame.size.width);
        //隐藏导航栏
        [[self navigationController] setNavigationBarHidden:YES animated:YES];
    } else {
        [sender setImage:[UIImage imageNamed:@"pui_zoominbtn@2x"] forState:UIControlStateNormal];
        falg = !falg;
        
        self.container.frame = CGRectMake(0, 0, self.view.bounds.size.height, self.view.bounds.size.height);
        playerLayer.frame = self.container.bounds;
        [self.view bringSubviewToFront:self.container];
        //旋转屏幕，但是只旋转当前的View
        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeLeft];
        self.view.transform = CGAffineTransformMakeRotation(M_PI*2);
        CGRect frame = [UIScreen mainScreen].applicationFrame;
        self.view.bounds = CGRectMake(0, 0, frame.size.height, frame.size.width);
        //显示导航栏
        [[self navigationController] setNavigationBarHidden:NO animated:YES];
        if (self.falg2) {
             _falg2 = !_falg2;
            [self.navigationController popViewControllerAnimated:YES];
            media_starImageView.hidden = NO;
        }
    }
}

//下一个视频Button
- (IBAction)nextButton:(UIButton *)sender {
}
//点击隐藏或者出现播放进度控制栏
- (IBAction)tapPlayer:(id)sender {
    if (falg1) {
        falg1 = !falg1;
        _playOrPause.hidden = YES;
        _nextButton.hidden = YES;
        _slider.hidden = YES;
        _fullButton.hidden = YES;
        _leftLabel.hidden = YES;
        _rightLabel.hidden = YES;
        
    } else {
        falg1 = !falg1;
        _playOrPause.hidden = NO;
        _nextButton.hidden = NO;
        _slider.hidden = NO;
        _fullButton.hidden = NO;
        _leftLabel.hidden = NO;
        _rightLabel.hidden = NO;
    }
    
}
- (void)downButton
{
    downData.urlArray = [NSMutableArray arrayWithCapacity:0];
    downData.nameArray = [NSMutableArray arrayWithCapacity:0];
    DownloadViewController *downloadVC = [DownloadViewController shareDownloadViewController];
    downloadVC.URLString = url;
    downloadVC.nameString = self.string1;
    [self.navigationController pushViewController:downloadVC animated:YES];
    
    
}

/**
 *  切换选集，这里使用按钮的tag代表视频名称
 *
 *  @param sender 点击按钮对象
 */
//- (IBAction)navigationButtonClick:(UIButton *)sender {
//    [self removeNotification];
//    [self removeObserverFromPlayerItem:self.player.currentItem];
//    AVPlayerItem *playerItem=[self getPlayItem:sender.tag];
//    [self addObserverToPlayerItem:playerItem];
//    //切换视频
//    [self.player replaceCurrentItemWithPlayerItem:playerItem];
//    [self addNotification];
//}

@end
