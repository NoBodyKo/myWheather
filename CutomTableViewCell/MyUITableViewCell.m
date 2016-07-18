//
//  MyUITableViewCell.m
//  MySecondWeather
//
//  Created by 成都千锋 on 15/9/12.
//  Copyright (c) 2015年 mxxxx. All rights reserved.
//

#import "MyUITableViewCell.h"
#import "MySuggestion.h"


@implementation MyUITableViewCell{
    UILabel *brfTitleLabel;
    UILabel *brfLabel;
    UILabel *txtLabel;
    UIImageView *imageView;
}


- (instancetype) init {
    @throw [NSException exceptionWithName:@"MyUITableViewCell" reason:@"请使用其他的初始化方法创建自定义表格单元格" userInfo:nil];
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.frame = CGRectMake(0, 0, MYWIDTH, MYHEIGHT);
        
        [self creatUI];
    }
    return self;
}
-(void) creatUI{
    
    UIView *myView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MYWIDTH, MYHEIGHT)];
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MYWIDTH / 3, MYHEIGHT)];
    brfTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(MYWIDTH / 3, 0, MYWIDTH / 3, MYHEIGHT / 5)];
    brfTitleLabel.font = [UIFont systemFontOfSize:15.0f];
    
    brfLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(brfTitleLabel.frame), 0, MYWIDTH / 3, MYHEIGHT / 5)];
    brfLabel.font = [UIFont boldSystemFontOfSize:15.0];
    brfLabel.numberOfLines = 1;
    
    txtLabel = [[UILabel alloc] initWithFrame:CGRectMake( MYWIDTH / 3,  MYHEIGHT / 5,   2 * MYWIDTH / 3, MYHEIGHT - MYHEIGHT / 5)];
    txtLabel.numberOfLines = 3;
    txtLabel.adjustsFontSizeToFitWidth = YES;
    txtLabel.font = [UIFont boldSystemFontOfSize:15.0];
    [myView addSubview:imageView];
    [myView addSubview:brfTitleLabel];
    [myView addSubview:brfLabel];
    [myView addSubview:txtLabel];
    [self.contentView addSubview:myView];
    
    
}

-(void) setModel:(MySuggestion *) model{
    
    brfLabel.text = model.brf;
    txtLabel.text = model.txt;
    
    
    
}
-(void) setImage:(UIImage *)image{
    imageView.image = image;
}
-(void) setbrfTitleLabelText:(NSString *)titleStr{
    brfTitleLabel.text = titleStr;
}
@end
