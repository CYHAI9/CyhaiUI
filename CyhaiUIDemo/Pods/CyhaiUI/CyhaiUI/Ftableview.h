//
//  Ftableview.h
//  Runtime
//
//  Created by 陈海哥 on 2016/12/15.
//  Copyright © 2016年 陈海哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Ftableview : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)UITableView * Mytablewview;
@property (nonatomic , strong)NSMutableArray * dataSource;

@end
