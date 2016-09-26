//
//  MyCityDAO.h
//  MySecondWeather
//
//  Created by 成都千锋 on 15/9/21.
//  Copyright (c) 2015年 mxxxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyDbUtil.h"

@class MyCity;
@interface MyCityDAO : NSObject{
    
}
@property (nonatomic, readwrite ,strong) FMDatabase *db;

- (void)updatedb;
/**
 通过城市ID查找
 */
-(MyCity *) findByCityId:(NSString *) cityId;
/**
 通过城市名查找
 */
-(NSArray *) findByCityName:(NSString *) cityName;
/**
 通过省份查找城市
 */
-(NSArray *) findAllByProName:(NSString *) proNameStr;
/**
 通过省份和城市查找ID
 */
-(NSString *) findCityIdByCityName:(NSString *)cityName andProName:(NSString *)proName;
@end
