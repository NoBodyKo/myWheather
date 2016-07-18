//
//  MyFutureWeatherViewController.m
//  weather
//
//  Created by yanghong on 15-9-8.
//  Copyright (c) 2015年 mxxxx. All rights reserved.
//

#import "MyFutureWeatherViewController.h"
#import "MySTableViewCell.h"
#import "ChineseToPinyin.h"
#import "MyCommon.h"
#import "MyUtil.h"
#import "MyDaily.h"
#import "MyDailyCond.h"
#import "MyDailyTmp.h"
#import "MyRequest.h"
#import "CityInfo.h"
@interface MyFutureWeatherViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
    UITableView *myTableView;
    NSMutableArray *dataArray;
    BOOL flag;
   
}
    


@end

@implementation MyFutureWeatherViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
  

    if ([CityInfo shareUserInfo].cityName != nil && ![self.myLabel.text isEqualToString:[CityInfo shareUserInfo].cityName]) {
        [self loadData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
     
    
    [self customNavagationItem];
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    myTableView.rowHeight = MYHEIGHT;
    
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
    
    
    
    
}


-(void) loadData{
    self.myLabel.text = [CityInfo shareUserInfo].cityName;
    [MyUtil setLabelWidth:[CityInfo shareUserInfo].cityName andLabel:self.myLabel andView:self.view andLabFont:[UIFont systemFontOfSize:16.0f] andFramOrignx:self.myLabel.frame.origin.x andFramOrigny:0 andMaxWidth:WIDTH / 2 andMaxHeight:NAVHEIGHT];
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
               NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
               NSArray *tempArray;
               for (NSString *key in [dict allKeys]) {
                   tempArray = [dict objectForKey:key];
                   
               }
               
               
               for (NSDictionary *tempDict in tempArray) {
                   for (NSString *key in tempDict) {
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
                           
                               
                               MyDaily *dilyModel = [[MyDaily alloc] init];
                               [dilyModel setValuesForKeysWithDictionary:tempDict];
                               [dictArray addObject:dilyModel];
                               [dataArray addObject:dictArray];
                               

                       
                       

                       
                   }
                                   }
               [myTableView reloadData];
       }
     
        }
        }
        
       }];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MySTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell = [[MySTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CELL"];
    }
    MyDailyCond *cmodel = dataArray[indexPath.row][0];
    MyDailyTmp *tmodel = dataArray[indexPath.row][1];
    MyDaily *dmodel = dataArray[indexPath.row][2];
    [cell setModel:dmodel andTModel:tmodel andCModel:cmodel];
    return cell;
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
