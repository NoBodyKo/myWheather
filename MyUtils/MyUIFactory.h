//
//  MyUIFactory.h
//  UI7day
//
//  Created by 成都千锋 on 15/8/25.
//  Copyright (c) 2015年 mxxxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface MyUIFactory : NSObject
+(UIWindow *) createWindow;

+(UIViewController *) creatViewController:(NSString *) vcName;

+(UIViewController *) creatViewController:(NSString *)vcName WithBgColor:(UIColor *)bgColor;
@end
