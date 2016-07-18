//
//  MySTableViewCell.h
//  MySecondWeather
//
//  Created by 成都千锋 on 15/9/17.
//  Copyright (c) 2015年 mxxxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#define MYWIDTH [UIScreen mainScreen].bounds.size.width
#define MYHEIGHT 125
@class MyDaily,MyDailyCond,MyDailyTmp;
@interface MySTableViewCell : UITableViewCell

@property (nonatomic, strong) MyDaily *dailyModel;
@property (nonatomic, strong) MyDailyTmp *dailyTmpModel;
@property (nonatomic, strong) MyDailyCond *dailyCondModel;

-(void) setModel:(MyDaily *)dModel andTModel:(MyDailyTmp *)tModel andCModel:(MyDailyCond *)cModel;
//-(void) creatUI;
@end
