//
//  MyRequst.h
//  MySecondWeather
//
//  Created by 成都千锋 on 15/9/17.
//  Copyright (c) 2015年 mxxxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyCommon.h"
@interface MyRequest : NSObject
/**
 通过城市id获取数据
 */
+(NSURLRequest *) getRequest:(NSString *)cityId;

/**
 通过景区id获取数据
 */
+(NSURLRequest *) getJQRequest:(NSString *)JQID;

@end
