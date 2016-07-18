//
//  MyUITableViewCell.h
//  MySecondWeather
//
//  Created by 成都千锋 on 15/9/12.
//  Copyright (c) 2015年 mxxxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#define MYWIDTH [UIScreen mainScreen].bounds.size.width
#define MYHEIGHT 100
@class MySuggestion;
@interface MyUITableViewCell : UITableViewCell



-(void) setModel:(MySuggestion *) model;

-(void) setImage:(UIImage *)image;

-(void) setbrfTitleLabelText:(NSString *)titleStr;
//-(void) creatUI;
@end
