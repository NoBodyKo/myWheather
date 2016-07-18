//
//  MyWeatherInfoViewController.m
//  MySecondWeather
//
//  Created by 成都千锋 on 15/9/12.
//  Copyright (c) 2015年 mxxxx. All rights reserved.
//

#import "MyWeatherInfoViewController.h"
#import "CityListViewController.h"
#import "MyLifeViewController.h"
#import "ChineseToPinyin.h"
#import "AFNetworking.h"
#import "MyUtil.h"
#import "MyAqi.h"
#import "MyNow.h"
#import "Mywind.h"
#import "Mycond.h"
#import "MyHourly.h"
#import "MyRequest.h"
#import "UIImage+UIImageExtras.h"
#import "MyHourlyTableViewCell.h"
#import "CityInfo.h"
#import "AppDelegate.h"
#import "MyCityDAO.h"
#import "MyJingQuDAO.h"
#import "ScenicSpotInfo.h"
#import "MyJingQu.h"
static MyCityDAO *cityDao = nil;
static MyJingQuDAO *jqDao = nil;
@interface MyWeatherInfoViewController ()<UITableViewDataSource,UITableViewDelegate,AddressDelegate>{
 
    NSString *wstr;
    NSMutableArray *proArray;
    NSMutableArray *cityArray;
    NSMutableArray *hourlyArray;
    NSMutableArray *tempCityArray;
    UITableView *myTableView;
    NSMutableArray *dataArray;
    UIBarButtonItem *item2;
    UIImageView *bgImageView;
    //UITableView *myTableView;
    
}

@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *weakLabel;
@property (weak, nonatomic) IBOutlet UILabel *weatherLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImage;

@property (weak, nonatomic) IBOutlet UILabel *tLabel;
@property (weak, nonatomic) IBOutlet UILabel *hLabel;
@property (weak, nonatomic) IBOutlet UILabel *aLabel;
@property (weak, nonatomic) IBOutlet UILabel *wLabel;

@property (weak, nonatomic) IBOutlet UILabel *tmpLabel;
@property (weak, nonatomic) IBOutlet UILabel *humLabel;
@property (weak, nonatomic) IBOutlet UILabel *aqiLabel;
@property (weak, nonatomic) IBOutlet UILabel *windirLabel;
@property (weak, nonatomic) IBOutlet UILabel *windscLabel;

@property (weak, nonatomic) IBOutlet UIView *basicInfoView;
@property (weak, nonatomic) IBOutlet UIView *trendTableView;





@end

@implementation MyWeatherInfoViewController
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    
   // self.cityId = [accountDefaults stringForKey:@"myCityID"];
    
    
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        [self createHeadView];
        [self createMyTB];
       
    });
    if ([CityInfo shareUserInfo].cityName != nil && ![self.myLabel.text isEqualToString:[CityInfo shareUserInfo].cityName] && !((AppDelegate*)[UIApplication sharedApplication].delegate).isGetLocatNow) {
        [self loadData];
    }

    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
   // NSLog(@"%@",[[NSBundle mainBundle] bundleIdentifier]);
  
    ((AppDelegate*)[UIApplication sharedApplication].delegate).delegate=self;
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(setTimeAndWeek) userInfo:nil repeats:YES];
    timer.fireDate = [NSDate distantPast];
    bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, NAV_BARHEIGHT, WIDTH, HEIGHT - NAV_BARHEIGHT - TAB_BAR_HEIGHT)];
    [self.view addSubview:bgImageView];
    [self.view sendSubviewToBack:bgImageView];
    [self customNavagationItem];
    
}



-(void) setTimeAndWeek{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
    //设置格式化样式
    [formatter setDateFormat:@"yyyy-MM-dd"];
    [formatter2 setDateFormat:@"HH:mm"];
    //设置时区
    formatter.timeZone = [NSTimeZone systemTimeZone];
    formatter2.timeZone = [NSTimeZone systemTimeZone];
    NSString *systemDate = [formatter stringFromDate:currentDate];
    NSString *systemTime = [formatter2 stringFromDate:currentDate];
    self.dateLabel.text = systemDate;
    self.timeLabel.text = systemTime;
    self.dateLabel.adjustsFontSizeToFitWidth = YES;
    self.timeLabel.adjustsFontSizeToFitWidth = YES;
    self.dateLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    
    
    NSDate *destDate= [formatter dateFromString:systemDate];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps = [calendar components:NSCalendarUnitWeekday
                        fromDate:destDate];
    
    NSArray * arrWeek=[NSArray arrayWithObjects:@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六", nil];
    NSInteger weekday = [comps weekday] - 1;
    self.weakLabel.text = [arrWeek objectAtIndex:weekday];
    self.weakLabel.textAlignment = NSTextAlignmentCenter;
}



-(void) loadData{
    self.myLabel.text = [CityInfo shareUserInfo].cityName;
    [MyUtil setLabelWidth:[CityInfo shareUserInfo].cityName andLabel:self.myLabel andView:self.view andLabFont:[UIFont systemFontOfSize:16.0f] andFramOrignx:self.myLabel.frame.origin.x andFramOrigny:0 andMaxWidth:WIDTH / 2 andMaxHeight:NAVHEIGHT];
    [self setTimeAndWeek];

    if (!hourlyArray) {
        hourlyArray = [NSMutableArray array];
    }
    if (!dataArray) {
        dataArray = [NSMutableArray array];
    }
    
    
    NSURLRequest *request = [MyRequest getRequest:[CityInfo shareUserInfo].cityID];

    [NSURLConnection sendAsynchronousRequest: request
               queue: [NSOperationQueue mainQueue]
    completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
       if (error) {
           
           [MyUtil showAlsert:[NSString stringWithFormat:@"%@",error] withVC:self];
           
       } else {
           NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:1 error:nil];
          
           NSArray *tempArray;
           for (NSString *key in [dict allKeys]) {
               tempArray = [dict objectForKey:key];
               
           }
           
           //NSLog(@"%@",tempArray);
           for (NSDictionary *tempDict in tempArray) {
               
               
             
               
               self.cityLabel.text = tempDict[@"basic"][@"city"];
               self.cityLabel.textAlignment = NSTextAlignmentCenter;
               self.cityLabel.adjustsFontSizeToFitWidth = YES;
               for (NSString *key in [tempDict allKeys]) {
                   if ([key isEqualToString:@"now"]) {
                       // 通过键取到对应的值
                       
                       NSDictionary *objDict = tempDict[key];
                       
                       for (NSString *key in [objDict allKeys]) {
                           if ([key isEqualToString:@"wind"]) {
                               NSDictionary *objDict2 = objDict[key];
                               
                               Mywind *tempWind = [[Mywind alloc] init];
                               [tempWind setValuesForKeysWithDictionary:objDict2];
                               _wLabel.text = @"风力风向";
                               _windirLabel.text = tempWind.dir;
                               _windscLabel.text = [NSString stringWithFormat:@"%@",tempWind.sc];
                               
                               
                         
                               
                               
                               
                           }else if ([key isEqualToString:@"cond"]){
                               NSDictionary *objDict3 = objDict[key];
                               
                               Mycond *tempCond = [[Mycond alloc] init];
                               [tempCond setValuesForKeysWithDictionary:objDict3];
                               
                               
                               self.weatherLabel.text = tempCond.txt;
                               self.weatherLabel.textAlignment = NSTextAlignmentCenter;
                               
                               wstr = [ChineseToPinyin pinyinFromChiniseString:tempCond.txt];
                               wstr = [wstr lowercaseString];
                               self.weatherImage.image = [UIImage imageNamed:wstr];
                              
                              
                               
                               bgImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"BG%@",wstr]];
                              
                               
                           }
                           
                       }
                       
                       NSDictionary *objDict4 = tempDict[key];
                       MyNow *tempNow = [[MyNow alloc] init];
                       
                       [tempNow setValuesForKeysWithDictionary:objDict4];
                       _tLabel.text = @"实时温度";
                       _tmpLabel.text = [NSString stringWithFormat:@"%@℃",tempNow.tmp];
                       _tmpLabel.adjustsFontSizeToFitWidth = YES;
                       _hLabel.text = @"相对湿度";
                       _humLabel.text = [NSString stringWithFormat:@"%@%%",tempNow.hum];
                       
                      
                      
                     
                       
                   }
                   else if ([key isEqualToString:@"aqi"]){
                       NSDictionary *objDict = tempDict[key];
                       for (NSString *key in [objDict allKeys]){
                           NSDictionary *objDict2 = objDict[key];
                           MyAqi *tempAqi = [[MyAqi alloc] init];
                           [tempAqi setValuesForKeysWithDictionary:objDict2];
                           _aLabel.text = @"空气质量";
                           _aqiLabel.text = tempAqi.qlty == nil ? @"未知   ": tempAqi.qlty;
                           _aqiLabel.textAlignment = NSTextAlignmentCenter;
                           _aqiLabel.adjustsFontSizeToFitWidth = YES;
                       }
                       
                   }
                   else if([key isEqualToString:@"hourly_forecast"]){
                       [hourlyArray removeAllObjects];
                       [dataArray removeAllObjects];
                        NSArray *myArr = tempDict[key];
                        for (NSDictionary *objDict in myArr) {
                            for (NSString *myKey in [objDict allKeys]) {
                                if ([myKey isEqualToString:@"wind"]) {
                                    Mywind *model = [Mywind new];
                                    [model setValuesForKeysWithDictionary:objDict[myKey]];
                                    [dataArray addObject:model];
                                }
                                
                                
                            }
                            MyHourly *model = [MyHourly new];
                            [model setValuesForKeysWithDictionary:objDict];
                            [hourlyArray addObject:model];
                       }
                      
                   }
               }
               
           }
        }
        [myTableView reloadData];
        
       
    }];
}
-(void) createHeadView{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 70.0, HEIGHT - NAV_BARHEIGHT - 16 * WIDTH / 25 - 40 - TAB_BAR_HEIGHT - 30)];
    
    headView.backgroundColor = [UIColor clearColor];
    //headView.transform = CGAffineTransformMakeRotation(M_PI / 2);
    NSArray *arr = @[@"时间",@"温度",@"湿度",@"风向",@"风力"];
    for (int i = 0; i < 5; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, i * headView.frame.size.height / 5, 70, headView.frame.size.height / 5 )];
        
        label.font = [UIFont systemFontOfSize:14.0f];
        //label.backgroundColor = [UIColor grayColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.text = arr[i];
        [headView addSubview:label];
    }
    [_trendTableView addSubview:headView];
}
#pragma mark 创建表格视图
-(void) createMyTB{
    self.automaticallyAdjustsScrollViewInsets = NO;
    myTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTableView.transform = CGAffineTransformMakeRotation(-M_PI / 2);
    myTableView.frame = CGRectMake(70,0,WIDTH - 90, HEIGHT - NAV_BARHEIGHT - 16 * WIDTH / 25 - 40 - TAB_BAR_HEIGHT - 30);
    
    myTableView.bounces = NO;
    myTableView.showsHorizontalScrollIndicator = NO;
    myTableView.showsVerticalScrollIndicator = NO;
    
    
    
    myTableView.dataSource = self;
    myTableView.delegate = self;
    myTableView.backgroundColor = [UIColor clearColor];
    
    
    
    
    [_trendTableView addSubview:myTableView];
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return hourlyArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyHourlyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell = [[ MyHourlyTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CELL"];
    }
    cell.transform = CGAffineTransformMakeRotation(M_PI / 2);
    
    cell.backgroundColor = [UIColor clearColor];
    Mywind *wModel = dataArray[indexPath.row];
    MyHourly *hModel = hourlyArray[indexPath.row];
    [cell setModel:hModel withWind:wModel];
    return cell;
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (WIDTH - 90) / 4;
}

-(BOOL) tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}
//-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 80.0f;
//}
//-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 80.0)];
//    
//    headView.backgroundColor = [UIColor whiteColor];
//    headView.transform = CGAffineTransformMakeRotation(M_PI / 2);
//    NSArray *arr = @[@"时间",@"温度",@"湿度",@"风向",@"风力"];
//    for (int i = 0; i < 5; i++) {
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,  80, 80, WIDTH / 5 )];
//        
//        label.font = [UIFont systemFontOfSize:14.0f];
//        label.backgroundColor = [UIColor grayColor];
//        label.textColor = [UIColor orangeColor];
//        label.text = arr[i];
//        [headView addSubview:label];
//    }
//    
//    return headView;
//}


#pragma mark --Appdelegate
-(void)didFailedLocation
{
       ((AppDelegate*)[UIApplication sharedApplication].delegate).isGetLocatNow = NO;
//    MBProgressHUD* progress=[MBProgressHUD showHUDAddedTo:self.tabBarController.view animated:YES];
//    progress.dimBackground=YES;
//    progress.mode=MBProgressHUDModeText;
//    progress.detailsLabelText=@"未能定位到您当前的城市";
//    [progress hide:YES afterDelay:2];

//      _longitude=116.46;
//    _lati=39.92;
//    [self getDataFromLatitudeWithLongtitude];
}

-(void)getLatitude:(CLLocationDegrees)latitude withLongitude:(CLLocationDegrees)longitud
{
    
    // NSLog(@"%lf-----%lf",latitude,longitud);
    CLLocationDegrees la=0.000;
    CLLocationDegrees lo=0.000;
    if (latitude!=0) {
//        if ([[NSString stringWithFormat:@"%.3f",latitude] isEqualToString:[NSString stringWithFormat:@"%.3f",_lati]]) {
//            return;
//        }else
//        {
            lo=longitud;
            la=latitude;
//        }
    }else
    {
        lo=116.46;
        la=39.92;
        
    }
//    _longitude=lo;
//    _lati=la;
    CLLocation *location=[[CLLocation alloc]initWithLatitude:la longitude:lo];
    CLGeocoder * geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark=[placemarks firstObject];
        //NSString * cityString=placemark.addressDictionary[@"City"];
        NSLog(@"111%@",placemark.addressDictionary);
//        if (!([UserInfo shareUserInfo].cityName.length <= 0)) {
//            ((CustomNavBarView*)((CustomNavigationController*)self.navigationController).cusTomNavB).label1.text=[UserInfo shareUserInfo].cityName;
//        }else
//        {
//            
////            MBProgressHUD* progress=[MBProgressHUD showHUDAddedTo:self.tabBarController.view animated:YES];
////            progress.dimBackground=YES;
////            progress.mode=MBProgressHUDModeText;
////            progress.detailsLabelText=@"未能定位到您当前的城市";
////            
////            [progress hide:YES afterDelay:2];
////            ((CustomNavBarView*)((CustomNavigationController*)self.navigationController).cusTomNavB).label1.text=@"北京";
////            [UserInfo shareUserInfo].cityName=@"北京";
////            _longitude=116.46;
////            _lati=39.92;
//            
//            
//        }
        // [self.delegate getCurrentCity:[cityString substringToIndex:cityString.length-1]];
        
        //  NSLog(@"FormattedAddressLines:%@\nName:%@\nState:%@\nStreet:%@\nSublocality:%@\nSubThoroughfare:%@\nThoroughfare:%@",placemark.addressDictionary[@"FormattedAddressLines"],placemark.addressDictionary[@"Name"],placemark.addressDictionary[@"State"],placemark.addressDictionary[@"Street"],placemark.addressDictionary[@"SubLocality"],placemark.addressDictionary[@"SubThoroughfare"],placemark.addressDictionary[@"Thoroughfare"]);
    }];
    
    
    
}
-(void)didSUccessLocation{
    ((AppDelegate*)[UIApplication sharedApplication].delegate).isGetLocatNow = NO;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
       cityDao = [[MyCityDAO alloc] init];
        jqDao = [[MyJingQuDAO alloc] init];
    });
    [CityInfo shareUserInfo].cityID = [cityDao findCityIdByCityName:[CityInfo shareUserInfo].cityName andProName:[CityInfo shareUserInfo].cityProvince];
    [ScenicSpotInfo shareUserInfo].scenicLocatPro = [CityInfo shareUserInfo].cityProvince;
    self.cityName = [CityInfo shareUserInfo].cityName;
    MyJingQu *scenicPot = [jqDao findByProName:[CityInfo shareUserInfo].cityProvince];
    [ScenicSpotInfo shareUserInfo].scenicName = scenicPot.jingquName;
    [ScenicSpotInfo shareUserInfo].scenicID = scenicPot.jingquID;
    [ScenicSpotInfo shareUserInfo].scenicLocation = scenicPot.jingquLocation;
    [ScenicSpotInfo shareUserInfo].scenicLocatPro = scenicPot.jinhquLocatPro;
    [self loadData];
     NSLog(@"%@",[CityInfo shareUserInfo].cityProvince);
    
    NSLog(@"%@",[CityInfo shareUserInfo].cityName );
    
}

@end
