//
//  ScenicSpotInfo.h
//  MySecondWeather
//
//  Created by wa1ksun on 16/6/13.
//  Copyright © 2016年 yh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScenicSpotInfo : NSObject

+(ScenicSpotInfo*)shareUserInfo;
@property (nonatomic, copy)NSString *scenicID;
@property (nonatomic, copy)NSString *scenicName;
@property (nonatomic, copy)NSString *scenicLocation;
@property (nonatomic, copy)NSString *scenicLocatPro;
@end
