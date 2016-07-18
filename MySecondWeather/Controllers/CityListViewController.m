//
//  CityListViewController.m
//  MySecondWeather
//
//  Created by 成都千锋 on 15/10/23.
//  Copyright (c) 2015年 mxxxx. All rights reserved.
//

#import "CityListViewController.h"
#import "MyCityDAO.h"
#import "MyCity.h"
#import "MyProvince.h"
#import "MyProvinceDAO.h"
#import "MyCommon.h"
#import "MyUtil.h"
#import "CityInfo.h"
#define col 4
@interface CityListViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UISearchBarDelegate>{
    NSMutableArray *proArray;
    NSMutableArray *cityArray;
    NSMutableArray *tempCityArray;
    MyCityDAO *cityDao;
    MyProvinceDAO *proDao;
    UICollectionView *myCollectionView;
    UICollectionViewCell *selecedCell;
    //UIButton *selectBut;
    UIView *myView;
    NSString *currentProName;
    
    
}

@end

@implementation CityListViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//   static dispatch_once_t onceToken;
//    dispatch_once(&onceToken,^{
//
//        
//    });
    [self createMyView];
    //         NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    currentProName = [CityInfo shareUserInfo].cityProvince;
    [self loadCityList];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    cityDao = [[MyCityDAO alloc] init];
    proDao = [[MyProvinceDAO alloc] init];
    

}

#pragma mark 创建myView
-(void) createMyView{
    myView = [[UIView alloc] initWithFrame:CGRectMake(0, NAV_BARHEIGHT, WIDTH, HEIGHT - NAV_BARHEIGHT)];
    myView.backgroundColor = [UIColor whiteColor];
    
    [self createSearchBar];
    [self createHotCityListView];
    [self createProListView];
    [self createCollectionview];
    [self.view addSubview:myView];
}
#pragma mark -------以下创建myView内部视图
#pragma mark 创建searchBar
-(void) createSearchBar{
    UISearchBar *mySearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, WIDTH, NAVHEIGHT)];
    mySearchBar.delegate = self;
    mySearchBar.returnKeyType = UIReturnKeySearch;
    mySearchBar.showsCancelButton = YES;
    mySearchBar.placeholder = @"输入城市/省份/地区名称";
    [myView addSubview:mySearchBar];
}

#pragma mark UISearchBarDelegate 回调
-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if(!cityArray){
        cityArray = [NSMutableArray array];
    }
    cityArray = [[cityDao findAllByProName:searchBar.text] mutableCopy];
    if (cityArray.count == 0) {
        cityArray = [[cityDao findByCityName:searchBar.text] mutableCopy];
        if (cityArray.count == 0) {
            [MyUtil showAlsert:@"没有找到您输入的省份或者城市" withVC:self];
        }else{
            [myCollectionView reloadData];
        }
    }else{
        [myCollectionView reloadData];
    }
    [searchBar resignFirstResponder];
}
-(void) searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}


#pragma mark 创建热门城市列表
-(void) createHotCityListView{
    UIView *hotCityListView = [[UIView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, WIDTH, NAV_BARHEIGHT)];
    UILabel *clabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH / 5, NAV_BARHEIGHT)];
    clabel.text = @"热门城市:";
    clabel.font = [UIFont systemFontOfSize:14.0f];
    clabel.textAlignment = NSTextAlignmentCenter;
    [hotCityListView addSubview:clabel];
    NSArray *hotcityArray = @[@"北京",@"上海",@"重庆",@"成都",@"深圳",@"广州",@"厦门",@"杭州"];
   
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 4; j++) {
            UIButton *cityButton = [UIButton buttonWithType:UIButtonTypeCustom];
            
            cityButton.frame = CGRectMake(WIDTH / 5 * (j + 1), i * NAV_BARHEIGHT / 2, WIDTH / 5, NAV_BARHEIGHT / 2);
            [cityButton setTitle:hotcityArray[4 * i + j] forState:UIControlStateNormal];
            [cityButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [cityButton setBackgroundImage:[UIImage imageNamed:@"btnbg"] forState:UIControlStateHighlighted];
            cityButton.tag = 200 + 4 * i + j;
//            if (cityButton.tag == 200) {
//                selectBut = cityButton;
//                cityButton.selected = YES;
//            }
            [cityButton addTarget:self action:@selector(hotcityButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [hotCityListView addSubview:cityButton];
        }
    }
    [myView addSubview:hotCityListView];
}
-(void) hotcityButtonClicked:(UIButton *) sender{
//    if (sender.tag == selectBut.tag) {
//        
//    }else{
//        selectBut.selected = NO;
//        sender.selected = YES;
//        selectBut = sender;
//    }
    NSArray *hotcCityProArr = @[@"北京",@"上海",@"重庆",@"四川",@"广东",@"广东",@"福建",@"浙江"];
    NSArray *hotcityIdArray = @[@"CN101010100",@"CN101020100",@"CN101040100",@"CN101270101",@"CN101280601",@"CN101280101",@"CN101230201",@"CN101210101"];
    
    if (self.changeCityBlock) {
        self.changeCityBlock(sender.currentTitle ,hotcityIdArray[sender.tag - 200],hotcCityProArr[sender.tag - 200]);
    }
    [self.navigationController popViewControllerAnimated:YES];
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"loadData" object:nil];
}
#pragma mark 创建省份列表
-(void) createProListView{
    if(!proArray){
        proArray = [NSMutableArray array];
    }
    proArray = [[proDao findAll] mutableCopy];
    
    UIView *proView = [[UIView alloc] initWithFrame:CGRectMake(0, NAV_BARHEIGHT + NAVHEIGHT + 10, WIDTH, 2 * NAV_BARHEIGHT)];
    proView.backgroundColor = [UIColor whiteColor];
    UILabel *pLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH / 5, proView.frame.size.height)];
    pLabel.text = @"省份列表:";
    pLabel.font = [UIFont systemFontOfSize:16.0f];
    pLabel.textAlignment = NSTextAlignmentCenter;
    pLabel.adjustsFontSizeToFitWidth = YES;
    [proView addSubview:pLabel];
    
    UIScrollView *proScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(pLabel.frame), 0, proView.frame.size.width - pLabel.frame.size.width ,proView.frame.size.height)];
    proScrollView.showsHorizontalScrollIndicator = NO;
    proScrollView.showsVerticalScrollIndicator = NO;
    proScrollView.backgroundColor = [UIColor whiteColor];
    [proView addSubview:proScrollView];
    int total = (int) proArray.count;
    int row = total % col ? (total / col + 1) :  total / col;
    float h = row * (NAV_BARHEIGHT - 15) / 2 + (row + 1) * 5;
    proScrollView.contentSize = CGSizeMake(proView.frame.size.width - pLabel.frame.size.width, h);
    for (int i = 0; i < row; i++) {
        for (int j = 0; j < col; j++) {
            if (i * col + j < proArray.count) {
                MyProvince *model = proArray[i * col + j];
                UIButton *proButton = [UIButton buttonWithType:UIButtonTypeCustom];
                proButton.frame = CGRectMake(5 + j * ((proScrollView.frame.size.width - 25) / 4 + 5), 5 + i * ((NAV_BARHEIGHT - 15) / 2 + 5), (proScrollView.frame.size.width - 25) / 4, (NAV_BARHEIGHT - 15) / 2 );
                proButton.tag = 200 + i * col + j;
                [proButton setTitle:model.proName forState:UIControlStateNormal];
                [proButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [proButton addTarget:self action:@selector(proButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                [proScrollView addSubview:proButton];
            }
        }
    }
    
    
    
    [myView addSubview:proView];
    
}
-(void) proButtonClicked:(UIButton *) sender{
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    [accountDefaults setObject:sender.currentTitle forKey:@"myProName"];
    currentProName = sender.currentTitle;
    [self loadCityList];
    
}
#pragma mark 创建城市列表
-(void) createCollectionview{
    //确定是水平滚动，还是垂直滚动
    self.automaticallyAdjustsScrollViewInsets = NO;
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT + 3 * NAV_BARHEIGHT + 10, WIDTH, myView.frame.size.height - NAVHEIGHT - 3 * NAV_BARHEIGHT) collectionViewLayout:flowLayout];
    myCollectionView.dataSource=self;
    myCollectionView.delegate=self;
    [myCollectionView setBackgroundColor:[UIColor whiteColor]];
    //注册Cell，必须要有
    [myCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"MyUICollectionViewCell"];
    
    
    [myView addSubview:myCollectionView];
    
}




#pragma mark -------以上为创建myView内部视图----------

-(void) loadCityList{
    if (!cityArray) {
        cityArray = [NSMutableArray array];
    }
    cityArray = [[cityDao findAllByProName:currentProName] mutableCopy];
   [myCollectionView reloadData];
    
    
    
}
#pragma mark UICollectionViewDataSource 回调
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return cityArray .count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * CellIdentifier = @"MyUICollectionViewCell";
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
   
    for (UIView *v in cell.contentView.subviews) {
        [v removeFromSuperview];
    }
    UIButton *cityBut = [UIButton buttonWithType:UIButtonTypeCustom];
    cityBut.frame = CGRectMake(0, 0, 60.0f, 20.0f);
    MyCity *model = cityArray[indexPath.row];
    [cityBut setTitle:model.cityName forState:UIControlStateNormal];
    [cityBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cityBut.titleLabel.adjustsFontSizeToFitWidth = YES;
    cell.backgroundView = cityBut;
    //[cell.contentView addSubview:cityBut];
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(60.0f, 20.0f);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

//header大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(WIDTH, 15.0f);
}

#pragma mark --UICollectionViewDelegate

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCity *model = cityArray[indexPath.row];
    if (self.changeCityBlock) {
        self.changeCityBlock(model.cityName,model.cityID,model.proName);
    }
    [self.navigationController popViewControllerAnimated:YES];
 
//    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    //临时改变个颜色，看好，只是临时改变的。如果要永久改变，可以先改数据源，然后在cellForItemAtIndexPath中控制。（和UITableView差不多吧！O(∩_∩)O~）
//    NSLog(@"%@",indexPath);
//    cell.backgroundColor = [UIColor cyanColor];
//    cell.selected = YES;
//    selecedCell = cell;
//    
    
    
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
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
