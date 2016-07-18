//
//  MyJingQuDAO.m
//  MySecondWeather
//
//  Created by 成都千锋 on 15/10/27.
//  Copyright (c) 2015年 mxxxx. All rights reserved.
//

#import "MyJingQuDAO.h"
#import "MyJingQu.h"
@implementation MyJingQuDAO

-(instancetype) init{
    if (self = [super init]) {
        db = [MyDbUtil createDBWithFilename:@"province.db"];
        [db open];
    }
    return self;
}


-(NSArray *) findJQbyCityName:(NSString *) cityName{
    NSMutableArray *mArray = [NSMutableArray array];
    FMResultSet *rs = [db executeQuery:@"select *from tb_jingqu where jingquLocation=?",cityName];
        while ([rs next]) {
            MyJingQu *JQ = [[MyJingQu alloc] init];
            JQ.jingquID = [rs stringForColumn:@"jingquID"];
            JQ.jingquName = [rs stringForColumn:@"jingquName"];
            JQ.jingquLocation = [rs stringForColumn:@"jingquLocation"];
            JQ.jinhquLocatPro = [rs stringForColumn:@"jingquProName"];
            [mArray addObject:JQ];
        }
    
    return [mArray copy];
    
}

-(NSArray *)findJQbyJQName:(NSString *)JQName{
     NSMutableArray *mArray = [NSMutableArray array];
   
    FMResultSet *rs = [db executeQuery:@"select *from tb_jingqu where jingquName=?",JQName];
        while ([rs next]) {
            MyJingQu *JQ = [[MyJingQu alloc] init];
            JQ.jingquID = [rs stringForColumn:@"jingquID"];
            JQ.jingquName = [rs stringForColumn:@"jingquName"];
            JQ.jingquLocation = [rs stringForColumn:@"jingquLocation"];
             JQ.jinhquLocatPro = [rs stringForColumn:@"jingquProName"];
            [mArray addObject:JQ];
        }
    
    return [mArray copy];
}
-(NSArray *)findJQbyProName:(NSString *)proName{
    NSMutableArray *mArray = [NSMutableArray array];

    FMResultSet *rs = [db executeQuery:@"select *from tb_jingqu where jingquProName=?",proName];
        while ([rs next]) {
            MyJingQu *JQ = [[MyJingQu alloc] init];
            JQ.jingquID = [rs stringForColumn:@"jingquID"];
            
            JQ.jinhquLocatPro = [rs stringForColumn:@"jingquProName"];
            JQ.jingquName = [rs stringForColumn:@"jingquName"];
            JQ.jingquLocation = [rs stringForColumn:@"jingquLocation"];
            [mArray addObject:JQ];
        }
    return [mArray copy];

}

-(MyJingQu *)findJQLocationNameByJQid:(NSString *)jqID{
    
      MyJingQu *jq = [MyJingQu new];
    FMResultSet *rs = [db executeQuery:@"select * from tb_jingqu where jingquID=?",jqID];
    

    while ([rs next]) {
        
        jq.jingquID = [rs stringForColumn:@"jingquID"];
        
        jq.jinhquLocatPro = [rs stringForColumn:@"jingquProName"];
        jq.jingquName = [rs stringForColumn:@"jingquName"];
        jq.jingquLocation = [rs stringForColumn:@"jingquLocation"];
    }
    return jq;
}
-(MyJingQu *) findByProName:(NSString *)proName{
    MyJingQu *jq = [MyJingQu new];
    FMResultSet *rs = [db executeQuery:@"select * from tb_jingqu where jingquProName=? limit 0,1",proName];
    while ([rs next]) {
        
        jq.jingquID = [rs stringForColumn:@"jingquID"];
        
        jq.jinhquLocatPro = [rs stringForColumn:@"jingquProName"];
        jq.jingquName = [rs stringForColumn:@"jingquName"];
        jq.jingquLocation = [rs stringForColumn:@"jingquLocation"];
    }
    return jq;
}
-(void) dealloc{
    if (db) {
        [db close];
        db = nil;
    }
}
@end
