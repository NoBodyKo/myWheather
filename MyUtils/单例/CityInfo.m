//
//  CityInfo.m
//  MySecondWeather
//
//  Created by wa1ksun on 16/6/12.
//  Copyright © 2016年 yh. All rights reserved.
//

#import "CityInfo.h"
static CityInfo *cityInfo = nil;
@implementation CityInfo
+(CityInfo *)shareUserInfo
{
    if (!cityInfo) {
        cityInfo=[[CityInfo alloc]init];
    }
    return cityInfo;
}
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    if (!cityInfo) {
        cityInfo=[super allocWithZone:zone];
        return cityInfo;
    }
    return nil;
    
}
//封堵深复制，不让他重新开辟新内存
-(id)copyWithZone:(struct _NSZone *)zone
{
    return self;
}



- (void)setCityID:(NSString *)cityID{
    [[NSUserDefaults standardUserDefaults] setObject:cityID forKey:@"cityID"];
}
- (NSString *)cityID{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"cityID"];
}

- (void)setCityName:(NSString *)cityName{
    [[NSUserDefaults standardUserDefaults] setObject:cityName forKey:@"cityName"];
}
- (NSString *)cityName{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"cityName"];
}

- (void)setCityStreet:(NSString *)cityStreet{
    [[NSUserDefaults standardUserDefaults] setObject:cityStreet forKey:@"cityStreet"];
}
- (NSString *)cityStreet{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"cityStreet"];
}

- (void)setCityDistrict:(NSString *)cityDistrict{
    [[NSUserDefaults standardUserDefaults] setObject:cityDistrict forKey:@"cityDistrict"];
}
- (NSString *)cityDistrict{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"cityDistrict"];
}

- (void)setCityCountry:(NSString *)cityCountry{
    [[NSUserDefaults standardUserDefaults] setObject:cityCountry forKey:@"cityCountry"];
}
- (NSString *)cityCountry{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"cityCountry"];
}

- (void)setCityProvince:(NSString *)cityProvince{
    [[NSUserDefaults standardUserDefaults] setObject:cityProvince forKey:@"cityProvince"];
}
- (NSString *)cityProvince{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"cityProvince"];
}
@end
