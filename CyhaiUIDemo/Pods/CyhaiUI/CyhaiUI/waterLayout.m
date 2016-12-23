//
//  waterLayout.m
//  Runtime
//
//  Created by 陈海哥 on 2016/12/19.
//  Copyright © 2016年 陈海哥. All rights reserved.
//

#import "waterLayout.h"

@implementation waterLayout

-(instancetype)initWithItemscolMargin:(CGFloat)colMargin rolMargin:(CGFloat)rolMargin colCount:(NSInteger)colCount HeightBlock:(HeightBlock)block{
    self = [super init];
    if (self) {
        self.heightBlock = block;
        _colMargin = colMargin;//边缘的距离
        _colCount = colCount;
        _rolMargin = rolMargin;
    }
    return self;
}

-(NSMutableArray *)colsHeight{
    if(!_colsHeight){
        NSMutableArray * array = [NSMutableArray array];
        for(int i =0;i<_colCount;i++){
            //这里可以设置初始高度
            [array addObject:@(0)];
        }
        _colsHeight = [array mutableCopy];
    }
    return _colsHeight;
}
//需要复写5个方法

//布局前的的初始工作
- (void)prepareLayout{
    
    [super prepareLayout];
    self.colWidth = (self.collectionView.frame.size.width -(self.colCount+1)*self.colMargin)/self.colCount;
    //重新加载
    self.colsHeight = nil;
}


//内容尺寸
-(CGSize)collectionViewContentSize{
    
    NSNumber *longest = self.colsHeight[0];
#pragma mark
    for (int i=0; i<self.colsHeight.count; i++) {
        NSNumber *rolHeight = self.colsHeight[i];
        if (longest.floatValue<rolHeight.floatValue) {
            longest = rolHeight;
        }
    }
    return CGSizeMake(self.collectionView.frame.size.width, longest.floatValue);
    
}


//为每一个item设置属性
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    NSNumber *shortest = self.colsHeight[0];
    NSInteger shortCol = 0;
#pragma mark 找出的高度为0的下标，以确定到哪个了(1，2，3，5，8，13，21，0，0，0)
    for (int i=0; i<self.colsHeight.count; i++) {
        NSNumber *rolHeight = self.colsHeight[i];
        if (shortest.floatValue>rolHeight.floatValue) {
            shortest = rolHeight;
            shortCol = i;
        }
    }
    CGFloat x = (shortCol+1)*self.colMargin + shortCol*self.colWidth;
    CGFloat y = shortest.floatValue + self.rolMargin;
    
    //获取cell的高度
    CGFloat height = 0;
    //    NSAssert(self.heightBlock!=nil, @"为实现计算高度的block");
    if (self.heightBlock) {
        height = self.heightBlock(indexPath);
        
    }
#pragma mark 确定每个item的大小位置
    attributes.frame = CGRectMake(x, y, self.colWidth, height);
#pragma mark 将刚确定位置大小的item的高度+之前所有item的高度和边距替换数组原来初始数据（0）
    self.colsHeight[shortCol] = @(shortest.floatValue + self.rolMargin+height);
    return attributes;
    
}

//获取item的属性
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    NSMutableArray *mutArr = [NSMutableArray array];
    NSInteger items = [self.collectionView numberOfItemsInSection:0];
    for (int i=0; i<items; i++) {
        UICollectionViewLayoutAttributes *att = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [mutArr addObject:att];
    }
    return mutArr;
}

//这个方法是会在cell时重新布局并调用repareLayout方法
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

@end
