//
//  MyCityDAO.m
//  MySecondWeather
//
//  Created by 成都千锋 on 15/9/21.
//  Copyright (c) 2015年 mxxxx. All rights reserved.
//

#import "MyCityDAO.h"
#import "MyProvince.h"
#import "MyCity.h"
@implementation MyCityDAO

-(instancetype) init{
    if (self = [super init]) {
        db = [MyDbUtil createDBWithFilename:@"province.db"];
        
        [db open];
    }
    return self;
}

-(MyCity *) findByCityId:(NSString *) cityId{
    MyCity *city = [[MyCity alloc] init];
    FMResultSet *rs = [db executeQuery:@"select * from tb_city where cityID=?",cityId];
    while ([rs next]) {
        city.cityID = [rs stringForColumn:@"cityID"];
        city.cityName = [rs stringForColumn:@"cityName"];
        city.proName = [rs stringForColumn:@"proName"];
     
    }
 
    return city;
}

-(NSArray *) findByCityName:(NSString *) cityName{
    NSMutableArray *mArray = [NSMutableArray array];
    FMResultSet *rs = [db executeQuery:@"select * from tb_city where cityName=?",cityName];
    while ([rs next]) {
        MyCity *city = [[MyCity alloc] init];
        city.cityID = [rs stringForColumn:@"cityID"];
        city.cityName = [rs stringForColumn:@"cityName"];
        city.proName = [rs stringForColumn:@"proName"];
        [mArray addObject:city];
    }
    return [mArray copy];
}

-(NSArray *) findAllByProName:(NSString *) proNameStr{
    NSMutableArray *mArray = [NSMutableArray array];
    FMResultSet *rs = [db executeQuery:@"select * from tb_city where proName=?",proNameStr];
    while ([rs next]) {
        MyCity *city = [[MyCity alloc] init];
        city.cityID = [rs stringForColumn:@"cityID"];
        city.cityName = [rs stringForColumn:@"cityName"];
        city.proName = [rs stringForColumn:@"proName"];
        [mArray addObject:city];
    }
    return [mArray copy];
}

-(NSString *) findCityIdByCityName:(NSString *)cityName andProName:(NSString *)proName{
    NSString *cityID = nil;
    NSString *sqlStr = [NSString stringWithFormat:@"select * from tb_city where cityName='%@' and proName='%@'",cityName,proName];
   // FMResultSet *rs = [db executeQuery:@"select * from tb_city where cityName=? and proName=?",cityName,proName];
    FMResultSet *rs = [db executeQuery:sqlStr];
    while ([rs next]) {
        
        cityID = [rs stringForColumn:@"cityID"];
        
    }

    return cityID;

}
-(void) dealloc{
    if (db) {
        [db close];
        db = nil;
    }
}
@end
