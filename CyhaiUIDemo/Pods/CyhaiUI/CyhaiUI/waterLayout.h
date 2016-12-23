//
//  waterLayout.h
//  Runtime
//
//  Created by 陈海哥 on 2016/12/19.
//  Copyright © 2016年 陈海哥. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef CGFloat (^HeightBlock)(NSIndexPath *indexPath);

@interface waterLayout : UICollectionViewLayout

/**
 列距离
 */
@property (nonatomic,assign)CGFloat colMargin;

/**
 列数
 */
@property (nonatomic,assign)CGFloat colCount;

/**
 行距离
 */
@property (nonatomic,assign)CGFloat rolMargin;

//数组存放每列的总高度
@property (nonatomic,strong) NSMutableArray *colsHeight;

//单元格的宽度
@property (nonatomic,assign)CGFloat colWidth;

@property (nonatomic,strong)HeightBlock heightBlock;

-(instancetype)initWithItemscolMargin:(CGFloat)colMargin rolMargin:(CGFloat)rolMargin colCount:(NSInteger)colCount HeightBlock:(HeightBlock)block;
@end
