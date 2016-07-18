//
//  MyJQDayliyTableViewCell.m
//  MySecondWeather
//
//  Created by yanghong on 15-11-2.
//  Copyright (c) 2015年 mxxxx. All rights reserved.
//

#import "MyJQDayliyTableViewCell.h"
#import "MyDaily.h"
#import "MyDailyCond.h"
#import "MyDailyTmp.h"
#import "Mywind.h"
#import "ChineseToPinyin.h"
@implementation MyJQDayliyTableViewCell{
    UIView *myDaliView;
    UILabel *dateLabel;
    UIImageView *d_imageView;
    UIImageView *n_imageView;
    UILabel *maxTmpLabel;
    UILabel *minTmpLabel;
    UILabel *windDirLabel;
    UILabel *windScLabel;
}


- (instancetype) init {
    @throw [NSException exceptionWithName:@"MyJQDayliyTableViewCell" reason:@"请使用其他的初始化方法创建自定义表格单元格" userInfo:nil];
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.frame = CGRectMake(0, 0, MYWIDTH, MYHEIGHT);
        
        [self createUI];
    }
    return self;
}

-(void)createUI{
    myDaliView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MYWIDTH, MYHEIGHT)];
    dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MYWIDTH, MYHEIGHT / 7)];
    dateLabel.adjustsFontSizeToFitWidth = YES;
    dateLabel.textAlignment = NSTextAlignmentCenter;
    
    d_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(dateLabel.frame), MYWIDTH, dateLabel.frame.size.height)];
    n_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(d_imageView.frame), MYWIDTH, dateLabel.frame.size.height)];
    
    
    maxTmpLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(n_imageView.frame), MYWIDTH, MYHEIGHT / 7)];
    
    maxTmpLabel.textAlignment = NSTextAlignmentCenter;
    maxTmpLabel.textColor = [UIColor orangeColor];
    minTmpLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(maxTmpLabel.frame), MYWIDTH, MYHEIGHT / 7)];
    minTmpLabel.textAlignment = NSTextAlignmentCenter;
    minTmpLabel.textColor = [UIColor cyanColor];
    
    windDirLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(minTmpLabel.frame), MYWIDTH, dateLabel.frame.size.height)];
    windDirLabel.numberOfLines = 2;
    windDirLabel.textAlignment = NSTextAlignmentCenter;
    windDirLabel.adjustsFontSizeToFitWidth = YES;
    windScLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(windDirLabel.frame), MYWIDTH, dateLabel.frame.size.height)];
    windScLabel.textAlignment = NSTextAlignmentCenter;
    windScLabel.adjustsFontSizeToFitWidth = YES;
    
    [myDaliView addSubview:dateLabel];
    [myDaliView addSubview:d_imageView];
    [myDaliView addSubview:n_imageView];
    [myDaliView addSubview:maxTmpLabel];
    [myDaliView addSubview:minTmpLabel];

    [myDaliView addSubview:windDirLabel];
    [myDaliView addSubview:windScLabel];
    
    
    
    
    
    
    
    
    
    myDaliView.backgroundColor = [UIColor clearColor];
   
    [self.contentView addSubview:myDaliView];
}

-(void) setDateModel:(MyDaily *)dateModel andCondModel:(MyDailyCond *)condModel andTmpModel:(MyDailyTmp *)tmpModel andWindModel:(Mywind *)windModel{
    
    NSArray *arr = [dateModel.date componentsSeparatedByString:@"-"];
    NSString *str = [NSString stringWithFormat:@"%@-%@",arr[1],arr[2]];
    
    
    dateLabel.text = str;
    
    NSString *dstr = [ChineseToPinyin pinyinFromChiniseString:condModel.txt_d];
    if (dstr != nil) {
        dstr = [dstr lowercaseString];
        d_imageView.image = [UIImage imageNamed:dstr];

    }
    
    NSString *nstr = [ChineseToPinyin pinyinFromChiniseString:condModel.txt_n];
    if (nstr != nil) {
        nstr = [nstr lowercaseString];
        n_imageView.image = [UIImage imageNamed:nstr];
    }
    
    
    if (tmpModel.max == nil) {
        maxTmpLabel.text = @"暂无";
    }else{
    maxTmpLabel.text = [NSString stringWithFormat:@"%@℃",tmpModel.max];
    }
    if (tmpModel.min == nil) {
        minTmpLabel.text = @"暂无";
    }else{
    minTmpLabel.text = [NSString stringWithFormat:@"%@℃",tmpModel.min];
    }
    windDirLabel.text = windModel.dir;
    windScLabel.text = windModel.sc;
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
