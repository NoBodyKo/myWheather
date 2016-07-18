//
//  MyJQViewController.m
//  MySecondWeather
//
//  Created by 成都千锋 on 15/10/30.
//  Copyright (c) 2015年 mxxxx. All rights reserved.
//

#import "MyJQViewController.h"
#import "JQListViewController.h"
#import "MyCommon.h"
#import "MyRequest.h"
#import "MyDaily.h"
#import "MyDailyCond.h"
#import "MyDailyTmp.h"
#import "Mywind.h"
#import "BasicInfo.h"
#import "MyJQDayliyTableViewCell.h"
#import "ScenicSpotInfo.h"
@interface MyJQViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSString *JQID;
    UIView *basicInfoView;
    UILabel *dateLabel;
    UILabel *JQNameLabel;
    UILabel *weatherInfoLabel;
    UIImageView *weatherImageView;
    NSString *jqLocation;
    NSString *jqLocatPro;
    
    UILabel *jqLocationLabel;
    
    UIView *futureWeatherView;
    UITableView *myTabelView;
    
    NSMutableArray *dataArray;
}

@end

@implementation MyJQViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        [self createHeadView];
        [self createWeatherTB];
        
    });
    if (![jqLocatPro isEqualToString:[ScenicSpotInfo shareUserInfo].scenicLocatPro] || ![JQID isEqualToString:[ScenicSpotInfo shareUserInfo].scenicID]) {
        [self loadData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customNavagationItem];
    [self createBasicInfoView];
    [self createFuturWeather];
  
   
    self.view.backgroundColor = [UIColor whiteColor];
        // Do any additional setup after loading the view.
}


-(void) loadData{
    if (!dataArray) {
        dataArray = [NSMutableArray array];
        
    }
    JQID = [ScenicSpotInfo shareUserInfo].scenicID;
    jqLocatPro = [ScenicSpotInfo shareUserInfo].scenicLocatPro;
    jqLocation = [ScenicSpotInfo shareUserInfo].scenicLocation;
    //NSLog(@"%@",jqLocation);
    NSURLRequest *request = [MyRequest getJQRequest:JQID];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
       
        if (connectionError) {
            NSLog(@"%@",connectionError);
        }else{
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            //NSLog(@"%@",dict);
            NSArray *tempArray;
            for (NSString *key in [dict allKeys]) {
                tempArray = [dict objectForKey:key];
                
            }
            
            
            for (NSDictionary *tempDict in tempArray) {
                for (NSString *key in tempDict) {
                    if ([key isEqualToString:@"basic"]) {
                        NSDictionary *dict = tempDict[@"basic"];
                        BasicInfo *model = [[BasicInfo alloc] init];
                        [model setValuesForKeysWithDictionary:dict];
                        JQNameLabel.text = model.city;
                        jqLocationLabel.text = [jqLocatPro isEqualToString:jqLocation] ? jqLocation:[NSString stringWithFormat:@"%@-%@",jqLocatPro,jqLocation];
                        
                    }
                    
                    if ([key isEqualToString:@"daily_forecast"]) {
                        
                        
                        NSArray *objArray = tempDict[key];
                        [dataArray removeAllObjects];
                        for (NSDictionary *tempDict in objArray) {
                            NSMutableArray *dictArray = [NSMutableArray array];
                            
                            NSDictionary *condDict = tempDict[@"cond"];
                            MyDailyCond *condModel = [[MyDailyCond alloc] init];
                            [condModel setValuesForKeysWithDictionary:condDict];
                            [dictArray addObject:condModel];
                            
                            
                            
                            
                            NSDictionary *tmpDict = tempDict[@"tmp"];
                            MyDailyTmp *tmpModel = [[MyDailyTmp alloc] init];
                            [tmpModel setValuesForKeysWithDictionary:tmpDict];
                            [dictArray addObject:tmpModel];
                            
                            NSDictionary *windDict = tempDict[@"wind"];
                            Mywind *windModel = [[Mywind alloc] init];
                            [windModel setValuesForKeysWithDictionary:windDict];
                            [dictArray addObject:windModel];
                            
                            
                            MyDaily *dilyModel = [[MyDaily alloc] init];
                            [dilyModel setValuesForKeysWithDictionary:tempDict];
                            [dictArray addObject:dilyModel];
                            
                            
                            
                            [dataArray addObject:dictArray];
                            
                            
                            
                            
                            
                            
                        }

                        
                    }
                    [myTabelView reloadData];
                }
                
            }
        

        }
        
    }];
    
}


#pragma mark 基本信息视图
-(void) createBasicInfoView{
    basicInfoView = [[UIView alloc] initWithFrame:CGRectMake(15, NAV_BARHEIGHT + 10, WIDTH - 30, WIDTH / 3)];
    JQNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, basicInfoView.frame.size.width - 20, (basicInfoView.frame.size.height - 10) / 2)];
    JQNameLabel.textAlignment = NSTextAlignmentCenter;
    JQNameLabel.font = [UIFont systemFontOfSize:18.0f];
    jqLocationLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(JQNameLabel.frame), JQNameLabel.frame.size.width, JQNameLabel.frame.size.height)];
    jqLocationLabel.textAlignment = NSTextAlignmentCenter;
    jqLocationLabel.font = [UIFont systemFontOfSize:18.0f];
    
    [basicInfoView addSubview:JQNameLabel];
    [basicInfoView addSubview:jqLocationLabel];
    
    basicInfoView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:basicInfoView];
}

-(void) createFuturWeather{
    futureWeatherView = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(basicInfoView.frame) + 40, WIDTH - 30, HEIGHT - NAV_BARHEIGHT -TAB_BAR_HEIGHT - basicInfoView.frame.size.height - 70)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH - 30, 20)];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"未来七天天气";
    [futureWeatherView addSubview:label];
    
    
    futureWeatherView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:futureWeatherView];
}

-(void) createHeadView{
    NSArray *headLabelArr = @[@"日期",@"白天",@"夜间",@"高温",@"低温",@"风向",@"风力"];
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 40, futureWeatherView.frame.size.height - 20)];
    for (int i = 0; i < headLabelArr.count; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, i * headView.frame.size.height / headLabelArr.count, 60, headView.frame.size.height / headLabelArr.count)];
        label.text = headLabelArr[i];
        label.font = [UIFont systemFontOfSize:14.0f];
        
        [headView addSubview:label];
    }
    
    
    
    [futureWeatherView addSubview:headView];
}

-(void) createWeatherTB{
    self.automaticallyAdjustsScrollViewInsets = NO;
    myTabelView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    myTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTabelView.transform = CGAffineTransformMakeRotation(-M_PI / 2);
    myTabelView.frame = CGRectMake(40, 20, futureWeatherView.frame.size.width - 40, futureWeatherView.frame.size.height - 20);
    
    myTabelView.bounces = NO;
    myTabelView.showsHorizontalScrollIndicator = NO;
    myTabelView.showsVerticalScrollIndicator = NO;
    
    
    
    myTabelView.dataSource = self;
    myTabelView.delegate = self;
    myTabelView.backgroundColor = [UIColor clearColor];
    
    [futureWeatherView addSubview:myTabelView];
    
    
   

}

#pragma mark UITableViewDataSource回调
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //NSLog(@"%@",dataArray);
    return dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyJQDayliyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell = [[MyJQDayliyTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CELL"];
    }
    cell.transform = CGAffineTransformMakeRotation(M_PI / 2);
    //NSLog(@"%@",dataArray[indexPath.row]);
    MyDailyCond *cmodel = dataArray[indexPath.row][0];
    MyDailyTmp *tmodel = dataArray[indexPath.row][1];
    Mywind *wmodel = dataArray[indexPath.row][2];
    MyDaily *dmodel = dataArray[indexPath.row][3];
    [cell setDateModel:dmodel andCondModel:cmodel andTmpModel:tmodel andWindModel:wmodel];
    
    return cell;
}
#pragma mark UITableViewDelegate 回调
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (WIDTH - 30 - 40) / 4;
}











-(void) customNavagationItem{
    UIBarButtonItem *rItem = [[UIBarButtonItem alloc] initWithTitle:@"切换" style:UIBarButtonItemStylePlain target:self action:@selector(changeJQ)];
    self.navigationItem.rightBarButtonItem = rItem;
}
-(void) changeJQ{
    JQListViewController *JQListVC = [[JQListViewController alloc] init];
    JQListVC.jqChanged = ^(NSString *jqLocationPro,NSString *jqLoc,NSString *jqName,NSString *jqID){
        [ScenicSpotInfo shareUserInfo].scenicLocatPro = jqLocationPro;
        [ScenicSpotInfo shareUserInfo].scenicLocation = jqLoc;
        
        [ScenicSpotInfo shareUserInfo].scenicName = jqName;
        [ScenicSpotInfo shareUserInfo].scenicID = jqID;
    };
    JQListVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:JQListVC animated:YES];
    
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
