//
//  JQListViewController.h
//  MySecondWeather
//
//  Created by 成都千锋 on 15/10/30.
//  Copyright (c) 2015年 mxxxx. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^myBlock) (NSString *,NSString *,NSString *,NSString *);
@interface JQListViewController : UIViewController

@property (nonatomic, copy) myBlock jqChanged;
@end
