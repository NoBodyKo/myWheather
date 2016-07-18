//
//  MyUIFactory.m
//  UI7day
//
//  Created by 成都千锋 on 15/8/25.
//  Copyright (c) 2015年 mxxxx. All rights reserved.
//

#import "MyUIFactory.h"

@implementation MyUIFactory
+(UIWindow *) createWindow{
    static UIWindow *window = nil;
    if (!window) {
        window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        window.backgroundColor = [UIColor whiteColor];
        
    }
    return window;
}
+(UIViewController *) creatViewController:(NSString *) vcName{
    Class cls = NSClassFromString(vcName);
    return cls ? [[cls alloc] init] : nil;
}

+(UIViewController *) creatViewController:(NSString *)vcName WithBgColor:(UIColor *)bgColor{
    UIViewController *vc = [self creatViewController:vcName];
    if (vc) {
        vc.view.backgroundColor = bgColor;

    }
    return vc;
    }
@end
