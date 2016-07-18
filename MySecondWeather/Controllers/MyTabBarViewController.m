//
//  MyTabBarViewController.m
//  MySecondWeather
//
//  Created by 成都千锋 on 15/9/12.
//  Copyright (c) 2015年 mxxxx. All rights reserved.
//

#import "MyTabBarViewController.h"
#import "MyUIFactory.h"
#import "MyWeatherInfoViewController.h"
#import "UIImage+UIImageExtras.h"

@interface MyTabBarViewController (){
    NSMutableArray *vcArray;
    UINavigationController *nav;
    NSMutableArray *itemArray;
}

@end

@implementation MyTabBarViewController
    


- (void)viewDidLoad {
    [super viewDidLoad];
    
    vcArray = [NSMutableArray array];
    itemArray = [NSMutableArray array];
    NSArray *arr = @[@"基本信息",@"日常指数",@"近期天气",@"景点天气"];
    NSArray *imagearr = @[@"0-1",@"0-2",@"0-3",@"0-4"];
    
    
    MyWeatherInfoViewController *mwVC = [[MyWeatherInfoViewController alloc] init];
    UIImage *image = [UIImage imageNamed:imagearr[0]];
    CGSize imageSize = CGSizeMake(40.0, 40.0);
    
    
    mwVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:arr[0] image:image tag:200];
    mwVC.tabBarItem.image  = [image imageByScalingToSize:imageSize];


    
    nav =[[UINavigationController alloc] initWithRootViewController:mwVC];
    mwVC.navigationItem.title = mwVC.tabBarItem.title;
    [vcArray addObject:nav];
    
    NSArray *viewControllerArray = @[@"MyLifeViewController",@"MyFutureWeatherViewController",@"MyJQViewController"];
    
    for (int i = 1 ; i <= 3; i++) {
        
        UIViewController *vc = [MyUIFactory creatViewController:viewControllerArray[i - 1]];
        UIImage *image = [UIImage imageNamed:imagearr[i]];
        CGSize imageSize = CGSizeMake(40.0, 40.0);
        
        
        vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:arr[i] image:image tag:200 + i];
        vc.tabBarItem.image = [image imageByScalingToSize:imageSize];
        
        nav = [[UINavigationController alloc] initWithRootViewController:vc];
        
        vc.navigationItem.title = vc.tabBarItem.title;
        [vcArray addObject:nav];
    }

   
//    //添加手势
//    UISwipeGestureRecognizer *rihgtSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handlSwipe:)];
//    rihgtSwipe.direction = UISwipeGestureRecognizerDirectionRight;
//    [self.view addGestureRecognizer:rihgtSwipe];
//    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handlSwipe:)];
//    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
//    [self.view addGestureRecognizer:leftSwipe];
    

    
    self.viewControllers = vcArray;
    self.selectedIndex = 0;
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
    
    
}
//-(void)handlSwipe:(UISwipeGestureRecognizer *) sender{
//    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
//        if (self.selectedIndex < 3) {
//            self.selectedIndex += 1;
//        }
//        else{
//           
//            
//        }
//        
//        
//    }
//    else if (sender.direction == UISwipeGestureRecognizerDirectionRight){
//        if (self.selectedIndex > 0) {
//            self.selectedIndex -= 1;
//        }
//        else{
//            
//            
//        }
//        
//    }
//    
//    
//    
//}
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
