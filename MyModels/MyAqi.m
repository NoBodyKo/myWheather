//
//  weatherModel1.m
//  weather
//
//  Created by 成都千锋 on 15/9/6.
//  Copyright (c) 2015年 mxxxx. All rights reserved.
//

#import "MyAqi.h"

@implementation MyAqi

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    // JSON格式的数据中有一个键叫做description
    // 但是和它对应的属性名字叫desc
    // 该方法专门处理键和属性名字不对应的情况
    // 做这件事情是为了支持KVC(Key-Value Coding)

}
@end
