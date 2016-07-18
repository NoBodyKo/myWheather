//
//  MyHourlyTableViewCell.h
//  MySecondWeather
//
//  Created by 成都千锋 on 15/10/29.
//  Copyright (c) 2015年 mxxxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCommon.h"
#define MYWIDTH (WIDTH - 90) / 4
#define MYHEIGHT (HEIGHT - NAV_BARHEIGHT - 16 * WIDTH / 25 - 40 - TAB_BAR_HEIGHT - 30)
@class MyHourly;
@class Mywind;
@interface MyHourlyTableViewCell : UITableViewCell


-(void) setModel:(MyHourly *) model withWind:(Mywind *) wModel;
@end
