//
//  MyUtil.h
//  NET01day01
//
//  Created by 成都千锋 on 15/9/8.
//  Copyright (c) 2015年 mxxxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class AFHTTPRequestOperationManager;
@interface MyUtil : NSObject
/**
 模态框
 */
+(void) showAlsert:(NSString *) msg withVC:(UIViewController *) vc;

/**
 带取消模态框
 */
+(void) showAlsertWithCancel:(NSString *) msg withTitle:(NSString *) title withVC:(UIViewController *) vc;
/**
 请求管理器
 */
+(AFHTTPRequestOperationManager *) sharedRequestOperationManager;
/**
 label大小自适应
 */
+(void)setLabelWidth:(NSString *)str andLabel:(UILabel *)label andView:(UIView *)myView andLabFont:(UIFont*)myfont andFramOrignx:(float)x andFramOrigny:(float)y andMaxWidth:(float)maxwidth andMaxHeight:(float)maxheight;

+(BOOL)StringIsNull:(NSString *) str;
@end
