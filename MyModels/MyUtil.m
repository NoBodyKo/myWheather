
//
//  MyUtil.m
//  NET01day01
//
//  Created by 成都千锋 on 15/9/8.
//  Copyright (c) 2015年 mxxxx. All rights reserved.
//

#import "MyUtil.h"
#import "AFNetworking.h"
@implementation MyUtil

+(AFHTTPRequestOperationManager *) sharedRequestOperationManager{
    static AFHTTPRequestOperationManager *sharedInstance = nil;
    if (!sharedInstance) {
        //创建一个HTTP请求操作管理器对象
        sharedInstance = [AFHTTPRequestOperationManager manager];
        //AFNetworking 默认只支持application/json类型的响应
        //有一些服务器返回的可能不是JSON格式类型
        //通过下面代码可以支持其他类型
        //
        sharedInstance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",@"text/xml",nil];
    }
    return sharedInstance;
}

+(void) showAlsert:(NSString *) msg withVC:(UIViewController *)vc{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [ac addAction:okAction];
    [vc presentViewController:ac animated:YES completion:nil];
}


@end
