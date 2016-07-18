//
//  MyJingQuDAO.h
//  MySecondWeather
//
//  Created by 成都千锋 on 15/10/27.
//  Copyright (c) 2015年 mxxxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyDbUtil.h"
@class MyJingQu;
@interface MyJingQuDAO : NSObject{
    FMDatabase *db;
}
/**
 通过城市名查找景区
 */
-(NSArray *) findJQbyCityName:(NSString *) cityName;
/**
 通过省份名查找景区
 */
-(NSArray *) findJQbyProName:(NSString *) proName;
/**
 通过景区名查找景区
 */
-(NSArray *) findJQbyJQName:(NSString *) JQName;
/**
 通过景区ID查找所在地
 */
-(MyJingQu *) findJQLocationNameByJQid:(NSString *) jqID;

-(MyJingQu *) findByProName:(NSString *)proName;
@end
