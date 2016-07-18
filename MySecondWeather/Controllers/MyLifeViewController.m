//
//  MyLifeViewController.m
//  weather
//
//  Created by yanghong on 15-9-8.
//  Copyright (c) 2015年 mxxxx. All rights reserved.
//

#import "MyLifeViewController.h"
#import "MyCommon.h"
#import "MyUtil.h"
#import "MyRequest.h"
#import "AFNetworking.h"
#import "MySuggestion.h"
#import "MyUITableViewCell.h"
#import "MyWeatherInfoViewController.h"
#import "CityInfo.h"
@interface MyLifeViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *myTableView;
    NSMutableArray *dataArray;
    MyUITableViewCell *cell;
    BOOL flag;
}

@end

@implementation MyLifeViewController

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
    
    myTableView.dataSource = self;
    myTableView.delegate = self;
    myTableView.rowHeight = MYHEIGHT;
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
               
               for (NSString *key in [tempDict allKeys]) {
                   if ([key isEqualToString:@"suggestion"]) {
                       [dataArray removeAllObjects];
                       for (NSString *key2 in [tempDict[key] allKeys]) {
                           NSDictionary *objDict = tempDict[key][key2];
                           MySuggestion *suggestionModel = [[MySuggestion alloc] init];
                           [suggestionModel setValuesForKeysWithDictionary:objDict];
                           [dataArray addObject:suggestionModel];
                            
                       }
                   }
                   
               }
                [myTableView reloadData];
               
           }
           
       }
      
   }];

}


#pragma mark UITableViewDataSource 回调
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  dataArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *imageArray = @[@"chuanyi",@"ganmao",@"yundong",@"shushidu",@"chuxing",@"xiche",@"fangshai"];
    NSArray *brfTitles = @[@"穿衣指数：",@"感冒指数：",@"运动指数：",@"人体舒适度：",@"出行指数：",@"洗车指数",@"防晒指数："];
    cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell = [[MyUITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CELL"];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
     MySuggestion *model = dataArray[indexPath.row];
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",imageArray[indexPath.row]]];
    [cell setImage:image];
    [cell setbrfTitleLabelText:brfTitles[indexPath.row]];
    [cell setModel:model];
    
    return cell;
}

//- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
//    return NO;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
