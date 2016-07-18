//
//  MyHourlyTableViewCell.m
//  MySecondWeather
//
//  Created by 成都千锋 on 15/10/29.
//  Copyright (c) 2015年 mxxxx. All rights reserved.
//

#import "MyHourlyTableViewCell.h"
#import "MyHourly.h"
#import "Mywind.h"
@implementation MyHourlyTableViewCell{
    UILabel *myDateLabel;
    UILabel *myTmpLabel;
    UILabel *myHumLabel;
    UILabel *myWindDirLabel;
    UILabel *myWindScLabel;
    
    UIView *cellView;
}

- (instancetype) init {
    @throw [NSException exceptionWithName:@"MyHourlyTableViewCell" reason:@"请使用其他的初始化方法创建自定义表格单元格" userInfo:nil];
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.frame = CGRectMake(0, 0, MYWIDTH, MYHEIGHT);
        
        [self creatUI];
    }
    return self;
}
-(void) creatUI{
    cellView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MYWIDTH, MYHEIGHT)];
    myDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MYWIDTH, MYHEIGHT / 5)];
    myDateLabel.textColor = [UIColor whiteColor];
    
    myTmpLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(myDateLabel.frame), MYWIDTH, MYHEIGHT / 5)];
    myTmpLabel.textColor = [UIColor whiteColor];
    
    myHumLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(myTmpLabel.frame), MYWIDTH, MYHEIGHT / 5)];
    myHumLabel.textColor = [UIColor whiteColor];
    myWindDirLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(myHumLabel.frame), MYWIDTH, MYHEIGHT / 5)];
    myWindDirLabel.textColor = [UIColor whiteColor];
    myWindScLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(myWindDirLabel.frame), MYWIDTH, MYHEIGHT / 5)];
    myWindScLabel.textColor = [UIColor whiteColor];
    [cellView addSubview:myDateLabel];
    [cellView addSubview:myTmpLabel];
    [cellView addSubview:myHumLabel];
    [cellView addSubview:myWindDirLabel];
    [cellView addSubview:myWindScLabel];
    
    
    cellView.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:cellView];
    
}

-(void) setModel:(MyHourly *)model withWind:(Mywind *)wModel{
    NSArray *array=[model.date componentsSeparatedByString:@" "];
    NSString *str = array[1];
    myDateLabel.text = str;
   
    myTmpLabel.text = [NSString stringWithFormat:@"%@℃",model.tmp];
    myHumLabel.text = [NSString stringWithFormat:@"%@%%",model.hum];
    myWindDirLabel.text = wModel.dir;
    myWindScLabel.text = wModel.sc;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
