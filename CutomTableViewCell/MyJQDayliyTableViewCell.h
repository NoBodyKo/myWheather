//
//  MyJQDayliyTableViewCell.h
//  MySecondWeather
//
//  Created by yanghong on 15-11-2.
//  Copyright (c) 2015年 mxxxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCommon.h"
#define MYWIDTH (WIDTH - 30 - 40) / 4
#define MYHEIGHT (HEIGHT - NAV_BARHEIGHT -TAB_BAR_HEIGHT - WIDTH / 3 - 90)
@class Mywind,MyDaily,MyDailyCond,MyDailyTmp;




@interface MyJQDayliyTableViewCell : UITableViewCell

-(void) setDateModel:(MyDaily *)dateModel andCondModel:(MyDailyCond *)condModel andTmpModel:(MyDailyTmp *)tmpModel andWindModel:(Mywind *)windModel;

@end
