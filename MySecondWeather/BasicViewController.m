//
//  BasicViewController.m
//  MySecondWeather
//
//  Created by 成都千锋 on 15/10/26.
//  Copyright (c) 2015年 mxxxx. All rights reserved.
//

#import "BasicViewController.h"
#import "CityListViewController.h"
#import "MyCommon.h"
#import "MyUtil.h"
#import "CityInfo.h"
#import "ScenicSpotInfo.h"
#import "MyJingQuDAO.h"
#import "MyJingQu.h"
@interface BasicViewController (){
    MyJingQuDAO *jqDAO;
    UIBarButtonItem *item2;
}

@end

@implementation BasicViewController

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
//            NSUserDefaults *isFirstEnter = [NSUserDefaults standardUserDefaults];
//           
//            if (![isFirstEnter boolForKey:@"firstEnter"]) {
//                static dispatch_once_t onceToken;
//                dispatch_once(&onceToken,^{
//                    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
//                    NSUserDefaults *isFirstEnter = [NSUserDefaults standardUserDefaults];
//                    [accountDefaults setObject:@"CN101010100" forKey:@"myCityID"];
//                    [accountDefaults setObject:@"北京" forKey:@"myCityName"];
//                    [accountDefaults setObject:@"北京" forKey:@"myProName"];
//                    [accountDefaults setObject:@"CN10101010018A" forKey:@"myJQID"];
//                    [accountDefaults setObject:@"北京" forKey:@"myJQLocation"];
//                    [isFirstEnter setBool:1 forKey:@"firstEnter"];
//                   
//                });
//                
//
//            }
    
    
   
    }

- (void)viewDidLoad {
    [super viewDidLoad];
    jqDAO = [MyJingQuDAO new];
    self.myLabel.text = nil;
    _cityName = nil;
    //[accountDefaults synchronize];
    // Do any additional setup after loading the view.
}
#pragma mark 创建NavBarButton
-(void) customNavagationItem{
    
        self.myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, NAVHEIGHT)];
        self.myLabel.textAlignment = NSTextAlignmentRight;
        UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithCustomView:self.myLabel];
        item2 = [[UIBarButtonItem alloc] initWithTitle:@"切换" style:UIBarButtonItemStylePlain target:self action:@selector(changeCity)];
        
        self.navigationItem.rightBarButtonItems  = @[item2,item1];
    
    
    
}

-(void) changeCity{
    CityListViewController *cityVC = [CityListViewController new];
    cityVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:cityVC animated:YES];
    cityVC.changeCityBlock = ^(NSString * cityName,NSString *newCityId,NSString *newPro){
//        
//        NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
//        [accountDefaults setObject:newCityId forKey:@"myCityID"];
//        [accountDefaults setObject:cityName forKey:@"myCityName"];
        [CityInfo shareUserInfo].cityID = newCityId;
        [CityInfo shareUserInfo].cityName= cityName;
        [CityInfo shareUserInfo].cityProvince = newPro;
        MyJingQu *scenicPot = [jqDAO findByProName:newPro];
        
        [ScenicSpotInfo shareUserInfo].scenicLocatPro = scenicPot.jinhquLocatPro;
        [ScenicSpotInfo shareUserInfo].scenicName = scenicPot.jingquName;
        [ScenicSpotInfo shareUserInfo].scenicLocation = scenicPot.jingquLocation;
        [ScenicSpotInfo shareUserInfo].scenicID = scenicPot.jingquID;
        //[accountDefaults synchronize];
    };
    
    
    
    
}

-(void)loadData{
    
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
