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

+(void) showAlsert:(NSString *) msg withVC:(UIViewController *) vc;

+(AFHTTPRequestOperationManager *) sharedRequestOperationManager;
@end
