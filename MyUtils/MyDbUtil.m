//
//  MyDbUtil.m
//  MySecondWeather
//
//  Created by 成都千锋 on 15/9/21.
//  Copyright (c) 2015年 mxxxx. All rights reserved.
//

#import "MyDbUtil.h"
#define DATABASE_FILE_NAME @"province.db"
@implementation MyDbUtil
+(FMDatabase *) createDBWithFilename:(NSString *)filename{
    NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(
                           
                           NSDocumentDirectory,
                           
                           NSUserDomainMask,
                           
                           YES);
    
    NSString *documentFolderPath = [searchPaths objectAtIndex:0];
    
    
    
    //往应用程序路径中添加数据库文件名称，把它们拼接起来， 这里用到了宏定义（目的是不易出错)
    
    NSString * dbFilePath = [documentFolderPath stringByAppendingPathComponent:DATABASE_FILE_NAME];
    //NSLog(@"%@",dbFilePath);
    //1. 创建NSFileManager对象  NSFileManager包含了文件属性的方法
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
    
    
    //2. 通过 NSFileManager 对象 fm 来判断文件是否存在，存在 返回YES  不存在返回NO
    
    BOOL isExist = [fm fileExistsAtPath:dbFilePath];
    //NSLog(@"%d",isExist);
    //- (BOOL)fileExistsAtPath:(NSString *)path;
    
    
    
    //如果不存在 isExist = NO，拷贝工程里的数据库到Documents下
    if(isExist){
//        [fm removeItemAtPath:dbFilePath error:nil];
//        NSLog(@"222222");
//        NSString *backupDbPath = [[NSBundle mainBundle]
//                                  
//                                  pathForResource:@"province"
//                                  
//                                  ofType:@"db"];
//        
//        //这一步实现数据库的添加，
//        
//        // 通过NSFileManager 对象的复制属性，把工程中数据库的路径拼接到应用程序的路径上
//        
//        BOOL cp = [fm copyItemAtPath:backupDbPath toPath:dbFilePath error:nil];
//        if (cp) {
//            
//        }

    }
    else if (!isExist)
        
    {
        
        //拷贝数据库
        
        
        
        //获取工程里，数据库的路径,因为我们已在工程中添加了数据库文件，所以我们要从工程里获取路径
        
        NSString *backupDbPath = [[NSBundle mainBundle]
                                  
                                  pathForResource:@"province"
                                  
                                  ofType:@"db"];
        
        //这一步实现数据库的添加，
        
        // 通过NSFileManager 对象的复制属性，把工程中数据库的路径拼接到应用程序的路径上
        
        BOOL cp = [fm copyItemAtPath:backupDbPath toPath:dbFilePath error:nil];
        if (cp) {
            
        }
    }
    
    
    NSString *filePath = [NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@",filename]];
//    NSString *backupDbPath = [[NSBundle mainBundle]
//                              
//                              pathForResource:@"province"
//                              
//                              ofType:@"db"];
    
//    return [FMDatabase databaseWithPath:filePath];
    return [[FMDatabase alloc] initWithPath:filePath];

}

+(void) closeDB:(FMDatabase *)db{
    if (db) {
        [db close];
    }
}
@end
