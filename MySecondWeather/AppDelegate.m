//
//  AppDelegate.m
//  MySecondWeather
//
//  Created by 成都千锋 on 15/9/12.
//  Copyright (c) 2015年 mxxxx. All rights reserved.
//

#import "AppDelegate.h"
#import "MyTabBarViewController.h"
#import "APIKey.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "CityInfo.h"
#import "MyUtil.h"
#define LocationTimeout 18
#define ReGeocodeTimeout 18

@interface AppDelegate () <UITabBarControllerDelegate,AMapLocationManagerDelegate>{
    
    AMapLocationManager*LocationManager;
}

@end

@implementation AppDelegate

//判断apiKey是否可用
- (void)configureAPIKey
{
    if ([APIKey length] == 0)
    {
        NSString *reason = [NSString stringWithFormat:@"apiKey为空，请检查key是否正确设置。"];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:reason delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
    }
   
    [AMapServices sharedServices].apiKey = (NSString *)APIKey;

}

//创建定位
- (void)createLocationManager{
    LocationManager = [AMapLocationManager new];
    [LocationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    LocationManager.delegate = self;
    [LocationManager setLocationTimeout:LocationTimeout];
    [LocationManager setReGeocodeTimeout:ReGeocodeTimeout];
    
}

//开始定位
- (void)locationStart{
    //[LocationManager startUpdatingLocation];
    _isGetLocatNow = YES;
    [LocationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
          }
        
        NSLog(@"location:%@", location);
        NSLog(@"regeocode:%@",regeocode.description);
        
        if (regeocode)
        {
            [CityInfo shareUserInfo].cityProvince = [regeocode.province substringToIndex:regeocode.province.length -  1];
            [CityInfo shareUserInfo].cityCountry = regeocode.country;
            [CityInfo shareUserInfo].cityDistrict = regeocode.district;
            [CityInfo shareUserInfo].cityStreet = regeocode.street;
            BOOL isMDcity = [MyUtil StringIsNull:regeocode.city];
            if (isMDcity) {
                [CityInfo shareUserInfo].cityName = [regeocode.province substringToIndex:regeocode.province.length -  1];
                //NSLog(@"%@",[CityInfo shareUserInfo].cityName);
            }else{
                [CityInfo shareUserInfo].cityName = [regeocode.city substringToIndex:regeocode.province.length -  1];
                NSLog(@"1211111");
            }
            //[CityInfo shareUserInfo].cityID = [NSString stringWithFormat:@"CN%@%@",regeocode.citycode,regeocode.adcode];
            //NSLog(@"reGeocode:%@", regeocode);
            
        }
        [_delegate didSUccessLocation];
    }];
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    [NSThread sleepForTimeInterval:3.0];
    [self configureAPIKey];
    [self createLocationManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSLog(@"%@",[paths objectAtIndex:0]);
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [_window makeKeyAndVisible];
    
    MyTabBarViewController *tbc = [[MyTabBarViewController alloc] init];
    tbc.delegate = self;
    
    [_window setRootViewController:tbc];
    [self locationStart];
    
    return YES;
}

//- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
//    
//    CATransition* animation = [CATransition animation];
//    [animation setDuration:0.5f];
//    [animation setType:kCATransitionMoveIn];
//    [animation setSubtype:kCATransitionFromRight];
//    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
//    
//   
//
//    [viewController.view.superview.layer addAnimation:animation forKey:nil];
//    
//} 
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void) amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"1111");
    [_delegate didFailedLocation];
    [manager stopUpdatingLocation];
    
}

- (void) amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location{
    //CLLocation *currentLocation = location;
    [LocationManager stopUpdatingLocation];
    CLLocationCoordinate2D coor = location.coordinate;
    //   NSLog(@"%lf--------%lf",coor.latitude,coor.longitude);
    
    [self getAddressByLatitude:coor.latitude longitude:coor.longitude];

    NSLog(@"22222");
}

-(void)getAddressByLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude{
    //反地理编码
    
    [_delegate getLatitude:latitude withLongitude:longitude];
    
}
@end
