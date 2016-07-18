//
//  GetMyLocationViewController.h
//  MySecondWeather
//
//  Created by 成都千锋 on 15/11/1.
//  Copyright (c) 2015年 mxxxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
@interface GetMyLocationViewController : UIViewController<AMapLocationManagerDelegate>

@property (nonatomic, strong) AMapLocationManager *locationManager;

- (void)returnAction;

@end
