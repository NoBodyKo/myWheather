//
//  AppDelegate.h
//  MySecondWeather
//
//  Created by 成都千锋 on 15/9/12.
//  Copyright (c) 2015年 mxxxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@protocol AddressDelegate <NSObject>
@optional
-(void)getLatitude:(CLLocationDegrees)latitude withLongitude:(CLLocationDegrees)longitud;
-(void)didSUccessLocation;
-(void)didFailedLocation;
@end

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property(nonatomic,strong)id<AddressDelegate> delegate;
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, assign) BOOL isGetLocatNow;


@end

