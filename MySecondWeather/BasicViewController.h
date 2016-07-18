//
//  BasicViewController.h
//  MySecondWeather
//
//  Created by 成都千锋 on 15/10/26.
//  Copyright (c) 2015年 mxxxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCity.h"
@interface BasicViewController : UIViewController
@property (nonatomic, copy) NSString *cityId;
@property (nonatomic, copy) NSString *cityName;
//@property (nonatomic, copy) NSString *jqID;
@property (nonatomic, strong) UILabel *myLabel;


/**
 定制导航栏
 */
-(void) customNavagationItem;

/**
 切换按钮点击
 */
-(void) changeCity;
/**
 加载数据
 */
-(void) loadData;
@end
