//
//  RecommendViewController.h
//  VideoAVPlayer
//
//  Created by gaoyanlong on 15-3-7.
//  Copyright (c) 2015年 shaowenle. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RecommendData;
@class PlayData1;
@class PlayerDicData;
@interface RecommendViewController : UIViewController
@property (nonatomic, strong) NSMutableArray *adArray;
@property (nonatomic, strong)  RecommendData *recommendData;
@property (nonatomic, strong) NSMutableArray *titleNameArray;
@property (nonatomic, strong) NSMutableArray *detailsNameArray;
@property (nonatomic, strong) NSMutableArray *detailsPicArray;
@property (nonatomic, strong) NSMutableArray *adMidArray;

@property (nonatomic, strong) PlayData1 *playData1;
@property (nonatomic, strong) PlayerDicData *playerDicData;

//@property (nonatomic, strong) NSMutableArray *playerArray;
@end
