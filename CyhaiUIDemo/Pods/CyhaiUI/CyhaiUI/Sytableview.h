//
//  Sytableview.h
//  Runtime
//
//  Created by 陈海哥 on 2016/12/16.
//  Copyright © 2016年 陈海哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Sytableview : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)UITableView * sytableview;
@property (nonatomic , strong)NSMutableArray * sylistArr;
@property (nonatomic , strong)NSMutableArray * datasource;
@property (nonatomic , strong)NSMutableArray * headerArr;

@end
