//
//  ScenicSpotInfo.m
//  MySecondWeather
//
//  Created by wa1ksun on 16/6/13.
//  Copyright © 2016年 yh. All rights reserved.
//

#import "ScenicSpotInfo.h"
static ScenicSpotInfo *scenicSpotInfo = nil;
@implementation ScenicSpotInfo
+(ScenicSpotInfo*)shareUserInfo
{
    if (!scenicSpotInfo) {
        scenicSpotInfo=[[ScenicSpotInfo alloc]init];
    }
    return scenicSpotInfo;
}

-(void) setScenicID:(NSString *)scenicID{
    [[NSUserDefaults standardUserDefaults] setObject:scenicID forKey:@"scenicID"];
}
-(NSString *) scenicID{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"scenicID"];
}

-(void) setScenicName:(NSString *)scenicName{
    [[NSUserDefaults standardUserDefaults] setObject:scenicName forKey:@"scenicName"];
}
-(NSString *) scenicName{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"scenicName"];
}

-(void) setScenicLocation:(NSString *)scenicLocation{
    [[NSUserDefaults standardUserDefaults] setObject:scenicLocation forKey:@"scenicLocation"];
}
-(NSString *) scenicLocation{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"scenicLocation"];

}

-(void) setScenicLocatPro:(NSString *)scenicLocatPro{
    [[NSUserDefaults standardUserDefaults]  setObject:scenicLocatPro forKey:@"scenicLocatPro"];
    
}
-(NSString *) scenicLocatPro{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"scenicLocatPro"];
}


@end
