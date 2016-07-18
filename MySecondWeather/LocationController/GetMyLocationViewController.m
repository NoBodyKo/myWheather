//
//  GetMyLocationViewController.m
//  MySecondWeather
//
//  Created by 成都千锋 on 15/11/1.
//  Copyright (c) 2015年 mxxxx. All rights reserved.
//

#import "GetMyLocationViewController.h"

@interface GetMyLocationViewController ()
@property (nonatomic, copy) AMapLocatingCompletionBlock completionBlock;

@end

@implementation GetMyLocationViewController
@synthesize locationManager = _locationManager;


- (void)configLocationManager
{
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    
    [self.locationManager setAllowsBackgroundLocationUpdates:YES];
}
- (void)clearLocationManager
{
    [self.locationManager stopUpdatingLocation];
    
    //Restore Default Value
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [self.locationManager setPausesLocationUpdatesAutomatically:YES];
    [self.locationManager setAllowsBackgroundLocationUpdates:NO];
    
    self.locationManager.delegate = nil;
}
#pragma mark - Handle Action

- (void)returnAction
{
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
    [self clearLocationManager];
}
#pragma mark - MALocationManager Delegate

- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%s, amapLocationManager = %@, error = %@", __func__, [manager class], error);
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location
{
    NSLog(@"%s, didUpdateLocation = {lat:%f; lon:%f;}", __func__, location.coordinate.latitude, location.coordinate.longitude);
}
#pragma mark - Initialization



- (void)initLocationManager
{
    self.locationManager.delegate = self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initLocationManager];
    // Do any additional setup after loading the view.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
