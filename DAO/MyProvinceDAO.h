//
//  MyProvinceDAO.h
//  MySecondWeather
//
//  Created by 成都千锋 on 15/9/21.
//  Copyright (c) 2015年 mxxxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyDbUtil.h"
@class MyProvince;

@interface MyProvinceDAO : NSObject{
    FMDatabase *db;
}

/**
 通过名字查找省份
 */
-(NSString *) findByProName:(NSString *)proname;
/**
 查找所有省份
 */
-(NSArray *) findAll;

@end
