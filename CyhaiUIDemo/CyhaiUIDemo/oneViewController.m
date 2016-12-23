//
//  oneViewController.m
//  CyhaiUIDemo
//
//  Created by 陈海哥 on 2016/12/23.
//  Copyright © 2016年 陈海哥. All rights reserved.
//

#import "oneViewController.h"
#import <waterLayout.h>
#import <mySearchBar.h>
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight  [UIScreen mainScreen].bounds.size.height

@interface oneViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchBarDelegate,UISearchResultsUpdating,UISearchControllerDelegate>
@property (nonatomic , strong)waterLayout *layout;

@property (nonatomic , strong)NSMutableArray *heightArr;

@property (nonatomic , strong)UICollectionView *collectionView;

@property (nonatomic , strong)mySearchBar * searchBar;

@property (nonatomic , strong)UISearchController * searVc;

@end

@implementation oneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.collectionView];
    
    [self testSearch];
}

- (void)testSearch
{
    self.searchBar = [[mySearchBar alloc] initWithFrame:CGRectMake(20, 65, 300, 60)];
    self.searchBar.searchInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    self.searchBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.searchBar];
    
}
-(UICollectionView *)collectionView{
    
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) collectionViewLayout:self.layout];
        _collectionView.backgroundColor = [UIColor redColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _collectionView;
    
}
-(NSMutableArray *)heightArr{
    if (!_heightArr) {
        //随机生成高度
        NSMutableArray *arr = [NSMutableArray array];
        for (int i=0; i<100; i++) {
            [arr addObject:@(arc4random()%50+80)];
        }
        _heightArr = [arr copy];
    }
    return _heightArr;
}

-(UICollectionViewLayout *)layout{
    if (!_layout) {
        _layout = [[waterLayout alloc] initWithItemscolMargin:3 rolMargin:10 colCount:6 HeightBlock:^CGFloat(NSIndexPath *indexPath) {
            
            return [self.heightArr[indexPath.item]floatValue];
        }];
    }
    return _layout;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.heightArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    
    return cell;
}

@end
