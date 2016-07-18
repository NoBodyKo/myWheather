//
//  MyDbUtil.h
//  MySecondWeather
//
//  Created by 成都千锋 on 15/9/21.
//  Copyright (c) 2015年 mxxxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
@interface MyDbUtil : NSObject
/*!
 @method 根据指定文件名创建数据库连接
 @param filename 数据库文件名
 @return 指向数据库的FMDatabase指针
 */
+(FMDatabase *) createDBWithFilename:(NSString *) filename;

/*!
 @method 关闭数据库
 @param db 指向数据库的FMDatabase指针
 */
+(void) closeDB:(FMDatabase *) db;

@end
