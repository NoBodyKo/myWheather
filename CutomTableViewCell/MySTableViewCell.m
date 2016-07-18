//
//  MySTableViewCell.m
//  MySecondWeather
//
//  Created by 成都千锋 on 15/9/17.
//  Copyright (c) 2015年 mxxxx. All rights reserved.
//

#import "MySTableViewCell.h"
#import "MyDailyTmp.h"
#import "MyDailyCond.h"
#import "MyDaily.h"
#import "ChineseToPinyin.h"
@implementation MySTableViewCell{
    UILabel *dateLabel;
    UILabel *weekLabel;
    UILabel *dLabel;
    UIImageView *dimageView;
    UILabel *nLabel;
    UIImageView *nimageView;
    UILabel *maxTmpLabel;
    UILabel *minTmpLabel;
    NSArray * arrWeek;
    
}

- (instancetype) init {
    @throw [NSException exceptionWithName:@"MySTableViewCell" reason:@"请使用其他的初始化方法创建自定义表格单元格" userInfo:nil];
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.frame = CGRectMake(0, 0, MYWIDTH, MYHEIGHT);
        
        [self creatUI];
    }
    return self;
}
-(void) creatUI{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MYWIDTH, MYHEIGHT)];
    dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 3 * MYWIDTH / 8, MYHEIGHT / 2)];
    dateLabel.textAlignment = NSTextAlignmentCenter;
    dateLabel.adjustsFontSizeToFitWidth = YES;
    dateLabel.textColor = [UIColor blackColor];
    [view addSubview:dateLabel];
    weekLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, MYHEIGHT / 2, MYWIDTH / 4, MYHEIGHT / 2)];
    weekLabel.textColor = [UIColor blackColor];
    weekLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:weekLabel];
    dLabel = [[UILabel alloc] initWithFrame:CGRectMake(3 * MYWIDTH / 8, 0, MYWIDTH / 8, MYHEIGHT / 2)];
    
    dLabel.textColor = [UIColor orangeColor];
    [view addSubview:dLabel];
    nLabel = [[UILabel alloc] initWithFrame:CGRectMake(3 * MYWIDTH / 8, MYHEIGHT / 2, MYWIDTH / 8, MYHEIGHT / 2)];
    nLabel.textColor = [UIColor blackColor];
    [view addSubview:nLabel];
    dimageView = [[UIImageView alloc] initWithFrame:CGRectMake(2 * MYWIDTH / 4, 0, MYHEIGHT / 2, MYHEIGHT / 2)];
    [view addSubview:dimageView];
    nimageView = [[UIImageView alloc] initWithFrame:CGRectMake(2 * MYWIDTH / 4, MYHEIGHT / 2, MYHEIGHT / 2, MYHEIGHT / 2)];
    [view addSubview:nimageView];
    maxTmpLabel = [[UILabel alloc] initWithFrame:CGRectMake(3 * MYWIDTH / 4, 0, MYWIDTH / 4, MYHEIGHT / 2)];
    maxTmpLabel.textColor = [UIColor orangeColor];
    [view addSubview:maxTmpLabel];
    minTmpLabel = [[UILabel alloc] initWithFrame:CGRectMake(3 * MYWIDTH / 4, MYHEIGHT / 2, MYWIDTH / 4, MYHEIGHT / 2)];
    minTmpLabel.textColor = [UIColor cyanColor];
    [view addSubview:minTmpLabel];
    [self.contentView addSubview:view];
    
}

-(void) setModel:(MyDaily *)dModel andTModel:(MyDailyTmp *)tModel andCModel:(MyDailyCond *)cModel{
    _dailyCondModel = cModel;
    _dailyModel = dModel;
    _dailyTmpModel = tModel;
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *Date = [dateFormatter dateFromString:dModel.date];
    dateLabel.text = dModel.date;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps = [calendar components:NSCalendarUnitWeekday
                        fromDate:Date];
    arrWeek=@[@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
    NSInteger weekday = [comps weekday] - 1;
    
    weekLabel.text = arrWeek[weekday];
    
    dLabel.text = @"白天";
    nLabel.text = @"夜间";
   
    NSString *dstr = [ChineseToPinyin pinyinFromChiniseString:cModel.txt_d];
    dstr = [dstr lowercaseString];
    dimageView.image = [UIImage imageNamed:dstr];
    
    NSString *nstr = [ChineseToPinyin pinyinFromChiniseString:cModel.txt_n];
    nstr = [nstr lowercaseString];
    nimageView.image = [UIImage imageNamed:nstr];
    
    maxTmpLabel.text = [NSString stringWithFormat:@"%@℃",tModel.max];
    minTmpLabel.text = [NSString stringWithFormat:@"%@℃",tModel.min];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
