//
//  now.m
//  weather
//
//  Created by 成都千锋 on 15/9/6.
//  Copyright (c) 2015年 mxxxx. All rights reserved.
//

#import "MyNow.h"

@implementation MyNow

- (void)setValue:(id)value forUndefinedKey:key {
    
    // 该方法专门处理键和属性名字不对应的情况
    // 做这件事情是为了支持KVC(Key-Value Coding)
    if ([key isEqualToString:@"status"]) {
        
    }
    
}
@end
