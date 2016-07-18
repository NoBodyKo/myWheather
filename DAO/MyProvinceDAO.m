//
//  MyProvinceDAO.m
//  MySecondWeather
//
//  Created by 成都千锋 on 15/9/21.
//  Copyright (c) 2015年 mxxxx. All rights reserved.
//

#import "MyProvinceDAO.h"
#import "MyProvince.h"

//DAO模式 --- Data Access Object
//1.封装增删改查（CRUD）的操作API
//2.以对象为单位组织数据(增删改查都是以对象为单位进行)
@implementation MyProvinceDAO

-(instancetype) init{
    if (self = [super init]) {
        db = [MyDbUtil createDBWithFilename:@"province.db"];
        [db open];
    }
    return self;
}

-(NSArray *) findAll{
    NSMutableArray *mArray = [NSMutableArray array];
   
        FMResultSet *rs = [db executeQuery:@"select *from tb_province order by keys asc"];
        while ([rs next]) {
            MyProvince *pro = [[MyProvince alloc] init];
            pro.proID = [rs intForColumn:@"proID"];
            pro.proName = [rs stringForColumn:@"proName"];
            pro.keys = [rs stringForColumn:@"keys"];
            [mArray addObject:pro];
        }
    
    return [mArray copy];
}

-(NSString *)findByProName:(NSString *)proname{
     FMResultSet *rs = [db executeQuery:@"select *from tb_province where proName=? order by keys asc",proname];
    return [rs stringForColumn:@"proName"];
}

-(void) dealloc{
    if (db) {
        [db close];
        db = nil;
    }
}
@end
