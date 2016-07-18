//
//  MyCity.h
//  MySecondWeather
//
//  Created by 成都千锋 on 15/9/21.
//  Copyright (c) 2015年 mxxxx. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MyProvince;
@interface MyCity : NSObject
@property (nonatomic, copy) NSString *cityID;
@property (nonatomic, copy) NSString *cityName;
@property (nonatomic, strong) NSString *proName;
@end
