//
//  CityListViewController.h
//  MySecondWeather
//
//  Created by 成都千锋 on 15/10/23.
//  Copyright (c) 2015年 mxxxx. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^myBlock) (NSString *,NSString *,NSString *);
@interface CityListViewController : UIViewController

@property (nonatomic, copy) myBlock changeCityBlock;

@end
