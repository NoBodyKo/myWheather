//
//  MyDbUtil.m
//  MySecondWeather
//
//  Created by 成都千锋 on 15/9/21.
//  Copyright (c) 2015年 mxxxx. All rights reserved.
//

#import "MyDbUtil.h"

@implementation MyDbUtil
+(FMDatabase *) createDBWithFilename:(NSString *)filename{
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@",filename]];
    return [FMDatabase databaseWithPath:filePath];
}

+(void) closeDB:(FMDatabase *)db{
    if (db) {
        [db close];
    }
}
@end
