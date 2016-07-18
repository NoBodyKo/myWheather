//
//  CityInfo.h
//  MySecondWeather
//
//  Created by wa1ksun on 16/6/12.
//  Copyright © 2016年 yh. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CityInfo : NSObject

+(CityInfo*)shareUserInfo;

@property(nonatomic, copy) NSString *cityName;      //城市名称
@property(nonatomic, copy) NSString *cityID;        //城市编码
@property(nonatomic, copy) NSString *cityProvince;  //城市所属省份
@property(nonatomic, copy) NSString *cityCountry;   //城市所在国家
@property(nonatomic, copy) NSString *cityDistrict;  //当前所在城市区县
@property(nonatomic, copy) NSString *cityStreet;    //当前所在城市所在街道

@end
