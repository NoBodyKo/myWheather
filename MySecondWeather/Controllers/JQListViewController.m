//
//  MyMoreFuncViewController.m
//  weather
//
//  Created by yanghong on 15-9-8.
//  Copyright (c) 2015年 mxxxx. All rights reserved.
//

#import "JQListViewController.h"
#import "MyCommon.h"
#import "MyJingQu.h"
#import "MyJingQuDAO.h"
#import "MyJQViewController.h"
#import "MyUtil.h"
#import "CityInfo.h"
@interface JQListViewController ()<UISearchBarDelegate,UICollectionViewDataSource,UICollectionViewDelegate>{
    UICollectionView *myCollectionView;
    MyJingQuDAO *JQdao;
    NSMutableArray *JQarray;
    NSString *currenCityName;
}

@end

@implementation JQListViewController

-(void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
   
    currenCityName = [CityInfo shareUserInfo].cityName;
    if (JQarray.count == 0) {
        [self loadJQlist];
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    JQdao = [MyJingQuDAO new];
    [self createCollectionview];
    [self createSearchBar];
    [self createHotJQListView];
    
}

#pragma mark 创建searchBar
-(void) createSearchBar{
    UISearchBar *mySearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, NAV_BARHEIGHT, WIDTH, NAVHEIGHT)];
    mySearchBar.delegate = self;
    mySearchBar.returnKeyType = UIReturnKeySearch;
   
    mySearchBar.showsCancelButton = YES;
    mySearchBar.placeholder = @"输入城市/地区/省份/景区";
    [self.view addSubview:mySearchBar];
}
#pragma mark UISearchBarDelegate 回调
-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    if (!JQarray) {
        JQarray = [NSMutableArray array];
        
    }
    JQarray = [[JQdao findJQbyJQName:searchBar.text] mutableCopy];
    if (JQarray.count == 0) {
        //NSLog(@"2");
        JQarray = [[JQdao findJQbyCityName:searchBar.text] mutableCopy];
        if (JQarray.count == 0) {
            JQarray = [[JQdao findJQbyProName:searchBar.text] mutableCopy];
            //NSLog(@"1");
            if (JQarray.count == 0) {
                [MyUtil showAlsert:@"糟糕，没有找到" withVC:self];
            }else{
                [myCollectionView reloadData];
            }
        }else{
            
            [myCollectionView reloadData];
        }
        
    }else{
        [myCollectionView reloadData];
    }
    
    
}

-(void) searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}

#pragma mark 创建热门景区列表
-(void) createHotJQListView{
    UIView *hotJQListView = [[UIView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT + NAV_BARHEIGHT , WIDTH, NAV_BARHEIGHT)];
    UILabel *clabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH / 5, NAV_BARHEIGHT)];
    clabel.text = @"热门景区:";
    clabel.font = [UIFont systemFontOfSize:14.0f];
    
    clabel.textAlignment = NSTextAlignmentCenter;
    [hotJQListView addSubview:clabel];
    NSArray *hotJQArray = @[@"故宫",@"秦皇陵",@"泰山",@"布达拉宫",@"黄鹤楼",@"西湖",@"都江堰景区",@"青城山"];
    
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 4; j++) {
            UIButton *JQButton = [UIButton buttonWithType:UIButtonTypeCustom];
            
            JQButton.frame = CGRectMake(WIDTH / 5 * (j + 1), i * NAV_BARHEIGHT / 2, WIDTH / 5, NAV_BARHEIGHT / 2);
            [JQButton setTitle:hotJQArray[4 * i + j] forState:UIControlStateNormal];
            JQButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
            JQButton.titleLabel.adjustsFontSizeToFitWidth = YES;
            [JQButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [JQButton setBackgroundImage:[UIImage imageNamed:@"btnbg"] forState:UIControlStateHighlighted];
            JQButton.tag = 200 + 4 * i + j;
            
            [JQButton addTarget:self action:@selector(hotJQButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [hotJQListView addSubview:JQButton];
        }
    }
    [self.view addSubview:hotJQListView];
}
-(void) hotJQButtonClicked:(UIButton *)sender{
    NSArray *jqIDarr = @[@"CN10101010018A",@"CN10111010119A",@"CN10112080103A",@"CN10114010104A",@"CN10120010116A",@"CN10121010109A",@"CN10127011102A",@"CN10127011103A"];
    
   
    MyJingQu *scenicPot = [JQdao findJQLocationNameByJQid:jqIDarr[sender.tag - 200]];
   
    if (self.jqChanged) {
        self.jqChanged(scenicPot.jinhquLocatPro,scenicPot.jingquLocation,scenicPot.jingquName,scenicPot.jingquID);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) loadJQlist{
    if (!JQarray) {
        JQarray = [NSMutableArray array];
    }
    JQarray = [[JQdao findJQbyCityName:currenCityName] mutableCopy];
}

-(void) createCollectionview{
    //确定是水平滚动，还是垂直滚动
    self.automaticallyAdjustsScrollViewInsets = NO;
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT + 2 * NAV_BARHEIGHT + 10, WIDTH, HEIGHT - NAVHEIGHT - 2 * NAV_BARHEIGHT) collectionViewLayout:flowLayout];
    myCollectionView.dataSource=self;
    myCollectionView.delegate=self;
    [myCollectionView setBackgroundColor:[UIColor whiteColor]];
    //注册Cell，必须要有
    [myCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"MyUICollectionViewCell"];
    
    
    [self.view addSubview:myCollectionView];
    
}
#pragma mark UICollectionViewDataSource 回调
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return JQarray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * CellIdentifier = @"MyUICollectionViewCell";
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    for (UIView *v in cell.contentView.subviews) {
        [v removeFromSuperview];
    }
    UILabel *JQLbel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60.0f, 30.0f)];
    
    MyJingQu *model = JQarray[indexPath.row];
    JQLbel.text = model.jingquName;
    JQLbel.textColor = [UIColor blackColor];
    JQLbel.font = [UIFont systemFontOfSize:14.0f];
    JQLbel.adjustsFontSizeToFitWidth = YES;
    JQLbel.numberOfLines = 2;
    cell.backgroundView = JQLbel;
    return cell;
}
#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(60.0f, 30.0f);
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
    MyJingQu *model = JQarray[indexPath.row];
   
    if (self.jqChanged) {
        self.jqChanged(model.jinhquLocatPro,model.jingquLocation,model.jingquName,model.jingquID);
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
