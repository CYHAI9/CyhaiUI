//
//  Sytableview.m
//  Runtime
//
//  Created by 陈海哥 on 2016/12/16.
//  Copyright © 2016年 陈海哥. All rights reserved.
//

#import "Sytableview.h"

@interface Sytableview ()

@end

@implementation Sytableview
- (NSMutableArray *)headerArr
{
    if (!_headerArr) {
        _headerArr = [NSMutableArray new];
        for(char c ='A';c<='Z';c++)
        {
            [_headerArr addObject:[NSString stringWithFormat:@"%c",c]];
        }
    }
    
    return _headerArr;
}
- (NSMutableArray *)sylistArr
{
    if (!_sylistArr) {
        _sylistArr = [NSMutableArray new];
        for(char c ='A';c<='Z';c++)
            
        {
            
            {
                [_sylistArr addObject:[NSString stringWithFormat:@"%c",c]];
            }
            
        }
    }
    return _sylistArr;
}
- (NSMutableArray *)datasource
{
    if (!_datasource) {
        _datasource = [NSMutableArray new];
        for (int i = 0; i < 10; i ++) {
            [_datasource addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    
    return _datasource;
}
- (UITableView *)sytableview
{
    if (!_sytableview) {
        _sytableview = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        _sytableview.delegate = self;
        _sytableview.dataSource = self;
        _sytableview.allowsSelection = self;
        //索引背景颜色
        _sytableview.sectionIndexBackgroundColor = [UIColor clearColor];
        //索引文字颜色
        _sytableview.sectionIndexColor = [UIColor orangeColor];
    }
    
    return _sytableview;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.sytableview];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.headerArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellsy"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellsy"];
    }
    cell.textLabel.text = self.datasource[indexPath.row];
    return cell;
}

//添加索引列
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView

{

    if (tableView != self.sytableview)
        
    {
        return nil;
    }
    
    return self.sylistArr;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

//索引列点击事件

-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    NSLog(@"===%@  ===%ld",title,index);
    //点击索引，列表跳转到对应索引的行
    
    [tableView
     scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index]
     atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    //弹出首字母提示
    
    //[self showLetter:title ];
    
    return index;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc]init];
    headView.backgroundColor = [UIColor clearColor];
    
    //标题背景
    UIView *biaotiView = [[UIView alloc]init];
    //        biaotiView.backgroundColor = [UIColor grayColor];
    biaotiView.frame=CGRectMake(0, 0, 320, 30);
    [headView addSubview:biaotiView];
    
    //标题文字
    UILabel *lblBiaoti = [[UILabel alloc]init];
    lblBiaoti.backgroundColor = [UIColor clearColor];
    lblBiaoti.textAlignment = NSTextAlignmentLeft;
    lblBiaoti.font = [UIFont systemFontOfSize:20];
    lblBiaoti.textColor = [UIColor blackColor];
    lblBiaoti.frame = CGRectMake(0, 7.5, 200, 15);
    lblBiaoti.text = [self.headerArr objectAtIndex:section];
    [biaotiView addSubview:lblBiaoti];
    return headView;
}

@end
