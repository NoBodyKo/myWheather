//
//  MyRequst.m
//  MySecondWeather
//
//  Created by 成都千锋 on 15/9/17.
//  Copyright (c) 2015年 mxxxx. All rights reserved.
//

#import "MyRequest.h"

@implementation MyRequest
+(NSURLRequest *) getRequest:(NSString *)cityId{
    NSString *httpUrl = MYURL2;
    NSString *httpArg = [NSString stringWithFormat:@"cityid=%@",cityId];
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, httpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: @"a0bfb9a9929bb7a56cc6fc879946b957" forHTTPHeaderField: @"apikey"];
    return request;
}

+(NSURLRequest *) getJQRequest:(NSString *)JQID{
    NSString *httpUrl = MYJQURL;
    NSString *httpArg = [NSString stringWithFormat:@"cityid=%@",JQID];
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, httpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: @"a0bfb9a9929bb7a56cc6fc879946b957" forHTTPHeaderField: @"apikey"];
    return request;
}
@end
