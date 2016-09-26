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
#import "ChineseToPinyin.h"
@implementation MyCityDAO

-(instancetype) init{
    if (self = [super init]) {
        _db = [MyDbUtil createDBWithFilename:@"province.db"];
        
        [_db open];
    }
    return self;
}

-(MyCity *) findByCityId:(NSString *) cityId{
    MyCity *city = [[MyCity alloc] init];
    FMResultSet *rs = [_db executeQuery:@"select * from tb_city where cityID=?",cityId];
    while ([rs next]) {
        city.cityID = [rs stringForColumn:@"cityID"];
        city.cityName = [rs stringForColumn:@"cityName"];
        city.proName = [rs stringForColumn:@"proName"];
     
    }
 
    return city;
}

-(NSArray *) findByCityName:(NSString *) cityName{
    NSMutableArray *mArray = [NSMutableArray array];
    FMResultSet *rs = [_db executeQuery:@"select * from tb_city where cityName=?",cityName];
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
    FMResultSet *rs = [_db executeQuery:@"select * from tb_city where proName=?",proNameStr];
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
    FMResultSet *rs = [_db executeQuery:sqlStr];
    while ([rs next]) {
        
        cityID = [rs stringForColumn:@"cityID"];
        
    }

    return cityID;

}
- (void)updatedb{
    NSMutableArray *cityNameArray = [NSMutableArray array];
    
    NSString *sqlStr = @"select cityName from tb_city ";
    FMResultSet *rs = [_db executeQuery:sqlStr];
    while ([rs next]) {
        [cityNameArray addObject:[rs stringForColumn:@"cityName"]];
    }
    for (int i = 0; i < cityNameArray.count; i++) {
        NSString *str = [NSString stringWithFormat:@"update tb_city set keys='%@' where cityName='%@'",[[[ChineseToPinyin changeToPinyinString:cityNameArray[i]] substringToIndex:1] uppercaseString],cityNameArray[i]];
        BOOL isSuceess = [_db executeUpdate:str];
        NSLog(@"%d",isSuceess);
    }
}
-(void) dealloc{
    if (_db) {
        [_db close];
        _db = nil;
    }
}
@end
